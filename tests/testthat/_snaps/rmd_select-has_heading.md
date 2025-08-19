# has_heading validates input comprehensively

    i In argument: `has_heading(123)`.
    Caused by error in `has_heading()`:
    ! Assertion on 'heading' failed: Must be of type 'character', not 'double'.

---

    i In argument: `has_heading(NULL)`.
    Caused by error in `has_heading()`:
    ! Assertion on 'heading' failed: Must be of type 'character', not 'NULL'.

---

    i In argument: `has_heading(character(0))`.
    Caused by error in `has_heading()`:
    ! Assertion on 'heading' failed: Must have length >= 1, but has length 0.

---

    i In argument: `has_heading(c("valid", NA))`.
    Caused by error in `has_heading()`:
    ! Assertion on 'heading' failed: Contains missing values (element 2).

