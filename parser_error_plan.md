# Error Message Improvement Candidates

## Context

The parser currently uses two mechanisms for informative errors:
- Named `x3::rule<>{"friendly name"}` with `>` (expect operator) — when `>` fires an `expectation_failure`, `on_error` uses the rule name as the "expected ..." message
- Negative lookahead rules (`!parser`) with descriptive names — when used with `>`, a failed check produces "expected {rule name}"

Most generic errors fall into two categories:
- **Missing detection** — a bad token is present but no rule detects it before the generic `}` / eol expectation fires
- **`>>` instead of `>`** — the parser uses sequence (`>>`) where expect (`>`) would give the rule name as context

The goal of this plan is to list candidates grouped by fix approach so they can be worked through systematically.

---

## Patterns Established (from Group 1 implementation)

### Pattern 1: Named sub-rule with `>` commitment

When a rule like `id_attr` matches a prefix (e.g. `#`) but needs a follow-up (e.g. identifier characters), extract the follow-up into a named sub-rule and use `>` to commit:

```cpp
auto const id_name = x3::rule<struct _, std::string>{"id name after '#'"}
= +(x3::char_("a-zA-Z0-9._-"));

auto id_attr = x3::rule<struct _, std::string> ("id attribute")
= x3::raw[ x3::lit("#") > id_name ];
```

If `#` matches but `id_name` fails (e.g. `{#}`), the error says "expected id name after '#'".

Similarly for `class_attr`:
```cpp
auto const class_name = x3::rule<struct _, std::string>{"class name after '.'"}
= +(x3::char_("a-zA-Z0-9._-"));

auto class_attr = x3::rule<struct _, std::string> ("class attribute")
= x3::raw[ x3::lit(".") > class_name ];
```

And for `key_value_attr` (the value part after `=`):
```cpp
auto kv_value = x3::rule<struct _, std::string> ("value after '=' in key=value attribute")
= x3::raw[
    ( x3::raw[q_string] |             // quoted value
      +(x3::char_ - x3::char_(" }"))  // unquoted value
  )];

auto key_value_attr = x3::rule<struct _, client::ast::key_value> ("key=value attribute")
= (x3::raw[ +(x3::char_("a-zA-Z0-9_-")) ] >>
   x3::lit("=")) >
  kv_value;
```

### Pattern 2: Negative lookahead rule for ordering/constraint checks

When you need to verify that a certain construct does NOT appear at a position (e.g. "no id after classes"), use a negative lookahead with a descriptive name:

```cpp
auto const no_class = x3::rule<struct _>{".class attributes to appear before any key=value attributes"}
= !class_attr;

auto const no_id = x3::rule<struct _>{"#id attributes to appear before any .class or key=value attributes"}
= !id_attr;
```

**Important:** Negative lookahead (`!parser`) produces `unused_type`, so the rule must NOT have an attribute type parameter (use `x3::rule<struct _>`, not `x3::rule<struct _, std::string>`).

These are wired into the grammar with `>`:
```cpp
(class_attr % +x3::lit(" ") | x3::attr(std::vector<std::string>())) >> *x3::lit(" ") >
no_id >
(key_value_attr % ...) > *x3::lit(" ") >
no_id >
no_class >
not_bare_word
```

When `no_id` fails (because `id_attr` succeeds — meaning an id IS present), the `>` fires "expected #id attributes to appear before any .class or key=value attributes".

**Note:** When `!id_attr` checks and `id_attr` internally commits (via `>`) on `#` then fails on the identifier (e.g. `{.class #}`), the inner expectation failure from `id_name` propagates through the `!` — so the user gets "expected id name after '#'" rather than the `no_id` message. This is correct and desirable behavior.

### Pattern 3: Catch-all negative lookahead for bare tokens

For tokens that don't match any valid form, use a negative lookahead on the character class:

```cpp
auto const not_bare_word = x3::rule<struct _>{"#id, .class, or key=value attribute(s)"}
= !x3::char_("a-zA-Z0-9_-");
```

This catches bare words like `{warning}` that lack the `#`/`.` prefix or `=` for key=value.

### Key principles

1. **Prefer integrating detection into existing rules** over adding standalone detection rules. E.g., add `>` inside `id_attr` rather than creating a separate `bare_hash` detection rule.
2. **Use `>` (expect) to commit** after matching an unambiguous prefix. This surfaces the sub-rule's name as the "expected" message.
3. **Use `!` (negative lookahead) for constraint checks** (ordering, catch-all). Name the rule with the constraint that SHOULD hold.
4. **Negative lookahead rules have no attribute type** — use `x3::rule<struct _>{}`, not `x3::rule<struct _, std::string>{}`.
5. **`sa_throw_error` is no longer the preferred approach** — the `>` + named rule pattern is cleaner and integrates better with Spirit's error handling.

---

## Group 1 — `parse_pandoc_attr.h` ✅ COMPLETE

All four error cases now produce specific messages:

| Input | Error message |
|---|---|
| `{.}` | `expected class name after '.'` |
| `{#}` | `expected id name after '#'` |
| `{key=}` | `expected value after '=' in key=value attribute` |
| `{warning}` / `{test}` | `expected #id, .class, or key=value attribute(s)` |

Additionally, the old `sa_throw_error`-based `misplaced_class` / `misplaced_id` rules were replaced with the cleaner `no_class` / `no_id` negative lookahead pattern. Error messages improved from "expected id attributes..." to "expected #id attributes..." with the prefix included.

---

## Group 2 — `parse_fenced_div.h`: use `>` to surface existing rule names

`fdiv_open_def` uses `>>` throughout so failures are silent. Switching specific `>>` to `>` after the colons section would let named rules provide context.

| Input | Error currently | Root cause | Suggested fix |
|---|---|---|---|
| `:::\n` (no attribute) | `Failed to parse line 1` | `cbrace_attrs \| unbraced_attr` fails silently | Change `>>` to `>` after `:::` so `cbrace_attrs \| unbraced_attr` is expected; rename the alternative to something like `"div attribute (unbraced name or {attrs})"` |
| `::: a x\n` (two unbraced words) | `Failed to parse line 1` | After `unbraced_attr` matches `a`, `eol` fails on ` x` | After the attribute, the `>> x3::eol` should become `> x3::eol` with a named parser |
| `:: {}\n` `:: \n` (only 2 colons) | `Failed to parse line 1` | `repeat(3, inf)` fails silently | Harder — no easy `>` hook; lower priority |

**Approach:** Apply Pattern 1 — create named rules for the attribute section and end-of-line, then use `>` to commit after `:::`.

**Files:** `src/parse_fenced_div.h`

---

## Group 3 — `parse_yaml.h` — DEFERRED

Adding `>` inside `yaml_start` after `---` would commit the document parser to YAML when it sees `---\n` followed by a blank line, breaking `parse_rmd("---\n\n---\n---\n...\n")` which currently (correctly) treats the first `---\n\n` as markdown. Requires restructuring that risks document-parser backtracking. Deferred pending further design.

| Input | Error currently | Root cause |
|---|---|---|
| `---\n\n---\n` `---\n\nvalue: 1\n---\n` | `Failed to parse line 1` | Blank-line lookahead `&(! ...)` fires silently |
| `--\n` `----\n` (wrong dash count) | `Failed to parse line 1` | `x3::lit("---")` fails silently |

**Files:** `src/parse_yaml.h`

---

## Group 4 — `parse_chunk.h`: header parsing failures

Chunk header errors are currently split: some already have good messages (`expected "="`, `expected R expression`), others are generic.

| Input | Error currently | Suggested message |
|---|---|---|
| `` ```{}\n `` (empty engine) | `Failed to parse line 1` | `expected chunk engine name` |
| `` ```{r\n `` (no closing `}`) | `Failed to parse line 1` | `expected closing brace } in chunk header` |
| `` ```r}\n `` (no opening `{`) | `Failed to parse line 1` | `expected opening brace { in chunk header` |
| `` ```{r}\n `` only header, no body/close | `Failed to parse line 1` | Already has "expected code block end (```)" via another path — confirm |
| `` ```{=}\n `` (empty raw format) | `Failed to parse line 1` | `expected raw format name after '='` |
| `` ```{==}\n `` `` ```{=a=}\n `` | `Failed to parse line 1` | `expected single format name for raw chunk` |
| `` ````{r}\n``` `` (mismatched fence) | `Failed to parse line 1` | `expected closing fence with matching tick count (4 ticks)` |

**Approach:** Apply Pattern 1 — change `>>` to `>` after `` ```{ `` in `chunk_start` to commit, and name sub-rules for engine, closing brace, etc. Verify negative lookaheads for code listings (`#lst-`) and `{{engine}}` patterns don't cause regressions.

Chunk fence mismatches are the hardest: the opening tick count must be threaded into the closing fence check. These may warrant a separate investigation.

**Files:** `src/parse_chunk.h`

---

## Execution Order

1. **Group 1** ✅ COMPLETE
2. **Group 2** (fdiv open) — next
3. **Group 4** (chunk header) — after Group 2
4. **Group 3** (YAML) — deferred

## Key Files

- `src/parse_pandoc_attr.h` — Group 1 ✅
- `src/parse_fenced_div.h` — Group 2
- `src/parse_yaml.h` — Group 3 (deferred)
- `src/parse_chunk.h` — Group 4
- `src/parser_error_handler.h` — error handler infrastructure (read-only reference)
- `tests/testthat/_snaps/` — snapshots to update after each fix
- `tests/testthat/test-parse-*.R` — test files to add/update cases
