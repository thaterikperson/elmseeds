---
layout: post
title:  "Form Validation"
date:   2017-07-20 14:33:00 -0400
categories:
label: ep-042
number: 42
tiny_description: Use elm-validate to check your forms' inputs.
---

Form validation doesn't need to be difficult or require a significant amount of code. Using [elm-validate](http://package.elm-lang.org/packages/rtfeldman/elm-validate/latest) will simplify your validation and increase code reuse throughout your application.

### Examples

**View.elm**

```elm
validate : Model -> List String
validate model =
    Validate.all
        [ .password >> Validate.ifBlank "Password cannot be blank"
        , .password >> ifLengthLessThan 8 "Password must be 8+ characters"
        , .email >> Validate.ifInvalidEmail "Email address is invalid"
        , .age >> Validate.ifNotInt "Age must be a number"
        ]
        model


ifLengthLessThan : Int -> error -> Validate.Validator error String
ifLengthLessThan minLength err =
    Validate.ifInvalid
        (\string ->
            (String.length string) < minLength
        )
        err
```

#### Links

* [rtfeldman/elm-validate](http://package.elm-lang.org/packages/rtfeldman/elm-validate/latest)
