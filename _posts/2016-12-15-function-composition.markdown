---
layout: post
title:  "Function Composition"
date:   2016-12-15 11:28:00 -0500
categories:
label: ep-018
number: 18
tiny_description: Combine multiple functions into a single function.
---

The `>>` and `<<` functions in Elm allow you to combine two functions to produce a new function. The resulting function is most often useful when passed as a parameter to functions like `map` and `filter.`. The direction of the arrow implies how the result is passed along between the functions.

### Examples

```elm
Http.post url Http.emptyBody decoder
    |> Http.toTask
    |> Task.map (.status >> String.toUpper)
    |> Task.mapError (RemotelyStoreError << httpErrorToString)
```

#### Links

* [elm-lang/core#>>](http://package.elm-lang.org/packages/elm-lang/core/5.0.0/Basics#>>)
