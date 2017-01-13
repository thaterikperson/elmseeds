---
layout: post
title:  "Destructuring"
date:   2016-07-21 10:15:00 -0500
categories:
label: ep-008
number: 8
tiny_description: Use destructuring to test and bind variables with fewer lines of code.
---

Destructuring is a way to bind variables using a syntax that is similar to type creation. It applies to lists, records, tuples and option types.

### Examples

```elm
type MyType
  = AType Int


aFunction =
  let
    a = [1, 2, 3]
    _ =
      case a of
        [] -> 1
        h :: h' :: t -> 2
        h :: t -> 3

    b = { record = "r", number = 3, a = "" }
    { record, number } = b

    c = (1, "tuple")
    _ =
      case c of
        (x, "tuple") -> 1
        (_, "other") -> 2
        _ -> 3

    e = AType 3
    (AType x) = e
  in
   --…
```


### Links

* [Elm Destructuring (or Pattern Matching) cheatsheet](https://gist.github.com/yang-wei/4f563fbf81ff843e8b1e)
