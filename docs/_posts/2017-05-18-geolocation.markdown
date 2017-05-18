---
layout: post
title:  "Geolocation"
date:   2017-05-18 14:17:00 -0400
categories:
label: ep-035
number: 35
tiny_description: Fetch a user's location via the browser.
---

Fetching a user's location with Elm's [geolocation](http://package.elm-lang.org/packages/elm-lang/geolocation/latest) package is pretty simple, but you may run into errors with Safari. Make sure you use `https`, and use the `nowWith` function to specify a timeout to get Safari to work properly.

### Examples

**Main.elm**

```elm
FetchLocation ->
    let
        cmd =
            Geolocation.nowWith
                { enableHighAccuracy = False
                , timeout = Just 2000
                , maximumAge = Nothing
                }
                |> Task.attempt LocationUpdated
    in
        model ! [ cmd ]
```

#### Links

* [elm-lang/geolocation](http://package.elm-lang.org/packages/elm-lang/geolocation/latest)
* [Ngrok](https://ngrok.com) - Secure tunnels to localhost
