---
layout: post
title:  "HttpBuilder"
date:   2017-06-15 13:56:00 -0400
categories:
label: ep-038
number: 38
tiny_description: Use HttpBuilder to simplify complex HTTP requests.
---

Building an HTTP request can get messy if you include extra headers, decode the body into something other than Json,
or even append some query parameters. [HttpBuilder](http://package.elm-lang.org/packages/lukewestby/elm-http-builder/latest) works with sane defaults and simple functions to help you construct your requests with minimal effort.


### Examples

**Main.elm**

```elm
case msg of
    Signin ->
        let
            builderCmd =
                HttpBuilder.post "http://localhost:4000/signin"
                    |> HttpBuilder.withHeader "X-CSRF-TOKEN" model.token
                    |> HttpBuilder.withJsonBody jsonBody
                    |> HttpBuilder.withQueryParams [ ( "timestamp", (toString model.timestamp) ) ]
                    |> HttpBuilder.withExpect (Http.expectJson Decode.int)
                    |> HttpBuilder.send SigninCompleted
        in
            model ! [ builderCmd ]
```

#### Links

* [lukewestby/elm-http-builder](http://package.elm-lang.org/packages/lukewestby/elm-http-builder/latest)
