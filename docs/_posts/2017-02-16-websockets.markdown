---
layout: post
title:  "WebSockets"
date:   2017-02-16 15:43:00 -0500
categories:
label: ep-024
number: 24
tiny_description: Communicate via WebSockets with Elm.
---

WebSockets open up your app to realtime communication with the server. Using the [WebSocket](http://package.elm-lang.org/packages/elm-lang/websocket/latest) library to handle the connections will unburden you from worrying about the messy details, so you can focus on improving your app for your users.


### Examples

**Main.elm**

```elm
main =
    Navigation.program
        UrlChange
        { subscriptions =
            (\model ->
                WS.listen wsAddress Heard
            )
        }

update msg model =
    case msg of
        DealHand ->
            let
                cmd =
                    WS.send wsAddress "payload"
            in
                model ! [ cmd ]

        Heard msg ->
            let
                _ =
                    Debug.log "msg" msg
            in
                model ! []
```

#### Links

* [elm-lang/websocket](http://package.elm-lang.org/packages/elm-lang/websocket/latest)
