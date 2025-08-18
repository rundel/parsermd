# has_shortcode validates input

    Assertion on 'func_name' failed: Must be of type 'character' (or 'NULL'), not 'double'.

---

    Assertion on 'func_name' failed: Must have length >= 1, but has length 0.

---

    Assertion on 'func_name' failed: Contains missing values (element 2).

# has_shortcode validates input comprehensively

    i In argument: `has_shortcode(123)`.
    Caused by error in `has_shortcode()`:
    ! Assertion on 'func_name' failed: Must be of type 'character' (or 'NULL'), not 'double'.

---

    i In argument: `has_shortcode(character(0))`.
    Caused by error in `has_shortcode()`:
    ! Assertion on 'func_name' failed: Must have length >= 1, but has length 0.

---

    i In argument: `has_shortcode("")`.
    Caused by error in `has_shortcode()`:
    ! Function names cannot be empty strings

---

    i In argument: `has_shortcode(c("valid", NA))`.
    Caused by error in `has_shortcode()`:
    ! Assertion on 'func_name' failed: Contains missing values (element 2).

---

    i In argument: `has_shortcode(c("video", ""))`.
    Caused by error in `has_shortcode()`:
    ! Function names cannot be empty strings

