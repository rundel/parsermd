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

### Pattern 4: BOOST_SPIRIT_DEFINE rules for `>` targets (from Group 2)

When a named rule is the target of `>` (i.e., `> my_rule`), it must be defined using the two-phase `BOOST_SPIRIT_DEFINE` pattern — NOT the inline `auto const` pattern:

```cpp
// CORRECT — name appears in expectation failure's which():
x3::rule<struct fdiv_attr_tag, client::ast::pandoc_attr> const fdiv_attr = "div attribute (unbraced name or {attrs})";
auto const fdiv_attr_def = cbrace_attrs | unbraced_attr;
BOOST_SPIRIT_DEFINE(fdiv_attr);

// WRONG — which() returns mangled C++ type name, filtered out by error handler:
auto const fdiv_attr = x3::rule<struct _, client::ast::pandoc_attr>{"div attribute (unbraced name or {attrs})"}
= cbrace_attrs | unbraced_attr;
```

The inline pattern creates a `rule_definition` object, and `what(rule_definition)` returns the mangled type name rather than the rule's string name. The `BOOST_SPIRIT_DEFINE` pattern stores a proper `rule` object whose `what()` returns the name.

**Note:** The inline `auto const` pattern works fine when `>` is INSIDE the rule (Pattern 1), because the inner `>` target is a sub-rule like `id_name`. It only fails when the rule itself is the direct target of an EXTERNAL `>`.

### C++ operator precedence: `>>` vs `>`

**Critical:** In C++, `>>` (shift) has HIGHER precedence than `>` (comparison). This means:

```cpp
A >> B > C >> D    // parsed as: (A >> B) > (C >> D)
```

So `> fdiv_attr >> skip[...]` wraps `fdiv_attr >> skip[...]` as a single expression — NOT just `fdiv_attr`. When this combined expression fails, `which()` returns the mangled type of the whole sequence.

**Fix:** Use explicit parentheses to isolate the `>` target:

```cpp
// WRONG — > wraps fdiv_attr >> skip[...] >> *blank as one expression:
lexeme >> *blank > fdiv_attr >> skip[...] >> *blank > fdiv_eol

// CORRECT — > wraps only fdiv_attr:
(lexeme >> *blank > fdiv_attr) >> skip[...] >> (*blank > fdiv_eol)
```

### Negative lookahead (`!`) and expectation failures

When a rule containing `>` is used in a negative lookahead (`!rule`), expectation failures from the inner `>` propagate THROUGH the `!` — they are not caught. This means `!fdiv_open` can throw if `fdiv_open` internally commits with `>` and then fails.

**Fix:** In `parse_markdown.h`, `md_line` used `!fdiv_open` to detect fenced div lines. After adding `>` to `fdiv_open_def`, this was replaced with a simpler prefix check:

```cpp
auto const partial_fdiv_start = x3::lexeme[
    x3::repeat(3, x3::inf)[x3::char_(':')]
  ];

// In md_line: use partial_fdiv_start instead of fdiv_open | fdiv_close
= !(x3::lit("#") | partial_chunk_start | block_start | partial_fdiv_start | yaml_start) >> ...
```

This pattern (simple prefix check for negative lookahead, full rule for actual parsing) should be applied whenever adding `>` to a rule that's used in `!` contexts.

### Key principles

1. **Prefer integrating detection into existing rules** over adding standalone detection rules. E.g., add `>` inside `id_attr` rather than creating a separate `bare_hash` detection rule.
2. **Use `>` (expect) to commit** after matching an unambiguous prefix. This surfaces the sub-rule's name as the "expected" message.
3. **Use `!` (negative lookahead) for constraint checks** (ordering, catch-all). Name the rule with the constraint that SHOULD hold.
4. **Negative lookahead rules have no attribute type** — use `x3::rule<struct _>{}`, not `x3::rule<struct _, std::string>{}`.
5. **`sa_throw_error` is no longer the preferred approach** — the `>` + named rule pattern is cleaner and integrates better with Spirit's error handling.
6. **Use `BOOST_SPIRIT_DEFINE` for `>` targets** — rules that appear as the direct RHS of `>` must use the two-phase definition pattern.
7. **Parenthesize `>` expressions** — due to C++ `>>` having higher precedence than `>`, always wrap `>` and its target in parentheses when mixed with `>>`.
8. **Replace full rules with prefix checks in `!` contexts** — if adding `>` to a rule used in `!` lookaheads, create a simple prefix-only check for the lookahead.

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

## Group 2 — `parse_fenced_div.h` ✅ COMPLETE

Two error cases now produce specific messages:

| Input | Error message |
|---|---|
| `:::\n` (no attribute) | `expected div attribute (unbraced name or {attrs})` |
| `::: a x\n` (two unbraced words) | `expected end of line after div attribute` |
| `:: {}\n` `:: \n` (only 2 colons) | Generic (deferred — no easy `>` hook) |

**Changes made:**
- `src/parse_fenced_div.h`: Added `fdiv_attr` and `fdiv_eol` as `BOOST_SPIRIT_DEFINE` rules (Pattern 4). Restructured `fdiv_open_def` to use `>` with parentheses for correct precedence.
- `src/parse_markdown.h`: Replaced `!fdiv_open | !fdiv_close` in `md_line` lookahead with simpler `!partial_fdiv_start` to avoid expectation failures propagating through `!`.

**Lessons learned:** Pattern 4 (BOOST_SPIRIT_DEFINE for `>` targets), operator precedence (`>>` > `>`), and `!`/expectation interaction — all documented in Patterns section above.

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
2. **Group 2** ✅ COMPLETE
3. **Group 4** (chunk header) — next
4. **Group 3** (YAML) — deferred

## Key Files

- `src/parse_pandoc_attr.h` — Group 1 ✅
- `src/parse_fenced_div.h` — Group 2 ✅
- `src/parse_markdown.h` — Group 2 (partial_fdiv_start for lookahead) ✅
- `src/parse_yaml.h` — Group 3 (deferred)
- `src/parse_chunk.h` — Group 4
- `src/parser_error_handler.h` — error handler infrastructure (read-only reference)
- `tests/testthat/_snaps/` — snapshots to update after each fix
- `tests/testthat/test-parse-*.R` — test files to add/update cases
