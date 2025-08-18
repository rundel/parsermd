# by_fdiv validates input correctly

    i In argument: `by_fenced_div(id = 123)`.
    Caused by error in `by_fenced_div()`:
    ! Assertion on 'id' failed: Must be of type 'character' (or 'NULL'), not 'double'.

---

    i In argument: `by_fenced_div(id = c("a", "b"))`.
    Caused by error in `by_fenced_div()`:
    ! Assertion on 'id' failed: Must have length 1, but has length 2.

---

    i In argument: `by_fenced_div(class = 123)`.
    Caused by error in `by_fenced_div()`:
    ! Assertion on 'class' failed: Must be of type 'character' (or 'NULL'), not 'double'.

---

    i In argument: `by_fenced_div(attr = 123)`.
    Caused by error in `by_fenced_div()`:
    ! `attr` must be a character vector or list

