# option parsing - bad input

    Failed to parse line 1, expected R expression
    x=
    ~^
    

---

    Failed to parse line 1
    =1
    ^~
    

---

    Failed to parse line 1, expected "="
    x y
    ~~^
    

---

    Failed to parse line 1
    .1 = x
    ^~~~~~
    

---

    Failed to parse line 1
    1 = x
    ^~~~~
    

---

    Failed to parse line 1, expected R expression
    x = 1, y =
          ~~~^
    

---

    Failed to parse line 1, expected R expression
    x = , y = 1
    ~~~^~~~~~~~
    

---

    Failed to parse line 1
    x = 1 y = 1
    ~~~~~~~~^~~
    

---

    Failed to parse line 1
    x = 1, .1 = 1
    ~~~~~^~~~~~~~
    

---

    Failed to parse line 1
    .1 = 1, y = 1
    ^~~~~~~~~~~~~
    

---

    Failed to parse line 1
    x = log(y
    ~~~~~~~^~
    

---

    Failed to parse line 1
    x = log(y))
    ~~~~~~~~~~^
    

---

    Failed to parse line 1
    x = log(y
    ~~~~~~~^~
    

---

    Failed to parse line 1
    x = log(y))
    ~~~~~~~~~~^
    

