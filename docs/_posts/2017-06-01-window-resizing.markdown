---
layout: post
title:  "Window Resizing"
date:   2017-06-01 18:15:00 -0400
categories:
label: ep-036
number: 36
tiny_description: Get notified when the browser changes dimensions.
---

Getting notified when a user's browser changes dimensions could be done via ports, or you can use the [elm-lang/window](http://package.elm-lang.org/packages/elm-lang/window/latest) package to handle the heavy lifting for you.

The `Window` package allows you to fetch the window size at any given point with `Window.size`, or listen for updates by subscribing to `Window.resizes`.

### Examples

**Main.elm**

```elm
main : Program Never Model Msg
main =
    Html.program
        { init = ( initialModel, initialSize )
        , update = update
        , view = View.mainView
        , subscriptions =
            (\_ ->
                Window.resizes SizeUpdated
            )
        }


initialSize : Cmd Msg
initialSize =
    Window.size
        |> Task.perform SizeUpdated
```
