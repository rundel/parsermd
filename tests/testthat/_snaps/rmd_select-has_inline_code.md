# has_inline_code validates input

    Assertion on 'engine' failed: Must be of type 'character' (or 'NULL'), not 'double'.

---

    Assertion on 'engine' failed: Must have length >= 1, but has length 0.

---

    Assertion on 'engine' failed: Contains missing values (element 2).

# has_inline_code validates input comprehensively

    i In argument: `has_inline_code(123)`.
    Caused by error in `has_inline_code()`:
    ! Assertion on 'engine' failed: Must be of type 'character' (or 'NULL'), not 'double'.

---

    i In argument: `has_inline_code(character(0))`.
    Caused by error in `has_inline_code()`:
    ! Assertion on 'engine' failed: Must have length >= 1, but has length 0.

---

    i In argument: `has_inline_code("")`.
    Caused by error in `has_inline_code()`:
    ! Engine names cannot be empty strings

---

    i In argument: `has_inline_code(c("valid", NA))`.
    Caused by error in `has_inline_code()`:
    ! Assertion on 'engine' failed: Contains missing values (element 2).

---

    i In argument: `has_inline_code(c("r", ""))`.
    Caused by error in `has_inline_code()`:
    ! Engine names cannot be empty strings

