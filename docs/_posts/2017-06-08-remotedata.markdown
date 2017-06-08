---
layout: post
title:  "RemoteData"
date:   2017-06-08 14:11:00 -0400
categories:
label: ep-037
number: 37
tiny_description: Use the RemoteData pattern to improve HTTP request handling.
---

Rather than track HTTP requests' statuses with something like an `isLoading: Bool` property, use the `RemoteData` type and pattern. This provides a succinct way to represent the different states a request can be in, without muddying up your model.


### Examples

**Main.elm**

```elm
type RemoteData e a
    = NotAsked
    | Loading
    | Failure e
    | Success a


type alias Model =
    { wins : RemoteData Http.Error Int
    , games : RemoteData Http.Error Int
    }
```

**View.elm**

```elm
case model.wins of
    NotAsked ->
        text ""

    Loading ->
        div [ class "throbber" ] []

    Failure e ->
        div [ class "error" ] [ text "error" ]

    Success wins ->
        h4 [] [ text <| toString wins ]

```

#### Links

* [How Elm Slays a UI Antipattern](http://blog.jenkster.com/2016/06/how-elm-slays-a-ui-antipattern.html)
* [krisajenkins/remotedata](http://package.elm-lang.org/packages/krisajenkins/remotedata/latest)
