---
layout: post
title:  "Navigation"
date:   2016-12-01 11:03:00 -0500
categories:
label: ep-016
tiny_description: Update the browser's url bar and history with Elm.
---

[elm-lang/navigation](http://package.elm-lang.org/packages/elm-lang/navigation/latest) gives your Elm app the ability to modify the browser's url bar and history. By stopping the event propagation when clicking a link, you can execute `Navigation.newUrl` to change the url bar, and then update your model accordingly when the `update` function is called.

### Examples

```sh
$ elm-package install elm-lang/navigation
```

```elm
main =
    Navigation.program
        UrlChange
        { init = initialState
        , update = update
        , view = View.mainView
        , subscriptions = (\_ -> AnimationFrame.times CurrentTick)
        }


initialState : Location -> ( Model, Cmd Msg )
initialState location =
    initialModel ! []


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
      UrlChange location ->
          let
              newPage =
                  case model.page of
                      Home ->
                          About

                      About ->
                          Home

              _ =
                  Debug.log "UrlChange" location
          in
              { model | page = newPage } ! []

      AboutLinkClick ->
          let
              cmd =
                  Navigation.newUrl "/about"
          in
              model ! [ cmd ]
```

#### Links

* [elm-lang/navigation](http://package.elm-lang.org/packages/elm-lang/navigation/latest)
