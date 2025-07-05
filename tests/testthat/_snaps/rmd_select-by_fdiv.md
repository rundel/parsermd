# by_fdiv validates input correctly

    i In argument: `by_fdiv(123)`.
    Caused by error in `by_fdiv()`:
    ! All patterns must be character vectors, pattern 1 is <numeric>

---

    i In argument: `by_fdiv(character(0))`.
    Caused by error in `by_fdiv()`:
    ! All patterns must be length 1 character vectors, pattern 1 has length 0

---

    i In argument: `by_fdiv(c("valid", NA))`.
    Caused by error in `by_fdiv()`:
    ! All patterns must be length 1 character vectors, pattern 1 has length 2

---

    i In argument: `by_fdiv(c("a", "b"))`.
    Caused by error in `by_fdiv()`:
    ! All patterns must be length 1 character vectors, pattern 1 has length 2

---

    i In argument: `by_fdiv("note", regexp = "invalid")`.
    Caused by error in `by_fdiv()`:
    ! Assertion on 'regexp' failed: Must be of type 'logical', not 'character'.

