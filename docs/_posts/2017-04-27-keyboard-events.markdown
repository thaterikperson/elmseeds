---
layout: post
title:  "Keyboard Events"
date:   2017-04-27 15:01:00 -0400
categories:
label: ep-032
number: 32
tiny_description: Handle modifier keys when typing in a textarea.
---

Elm's `Html.Events.onInput` lets you handle changes to a textarea, but only if you care about the raw text. If you want to handle keyboard shortcuts, or treating key presses differently when the _shift_ key is held, you need to listen for specific keyboard events.

### Examples

**View.elm**

```elm
view =
  textarea
      [ on "keyup" keyCodeAndShiftDecoder
      , placeholder "Your message…"
      , value model.message
      , onInput MessageUpdate
      ]
      []

keyCodeAndShiftDecoder : Decoder Msg
keyCodeAndShiftDecoder =
    Json.Decode.map2 KeyUp
        keyCode
        (Json.Decode.at [ "shiftKey" ] Json.Decode.bool)
```

#### Links

* [Html.Events](http://package.elm-lang.org/packages/elm-lang/html/2.0.0/Html-Events)
* [KeyboardEvent - Web APIs](https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent)
