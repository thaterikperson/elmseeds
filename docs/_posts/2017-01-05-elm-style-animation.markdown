---
layout: post
title:  "Elm-Style-Animation"
date:   2017-01-05 14:56:00 -0500
categories:
label: ep-019
number: 19
tiny_description: Create basic HTML animations.
---

In this episode, we use [mdgriffith/elm-style-animation](http://package.elm-lang.org/packages/mdgriffith/elm-style-animation/3.5.1) to create a basic animation that animates two properties of an element and then reverses it.

We covered animations and the [mgold/elm-animation](http://package.elm-lang.org/packages/mgold/elm-animation/latest) library in [Episode 006](/animations), but I wanted to show off elm-style-animation, which is more powerful and requires a little less code when doing advanced animations.

### Examples

**Main.elm**

```elm
ToggleMenu ->
    let
        tos =
            if model.isMenuOpen then
                [ Animation.top (Animation.rem -4)
                , Animation.opacity 0.0
                ]
            else
                [ Animation.top (Animation.rem 0)
                , Animation.opacity 1.0
                ]

        menuStyle =
            Animation.interrupt [ Animation.to tos ] model.menuStyle
    in
        { model | isMenuOpen = not model.isMenuOpen, menuStyle = menuStyle } ! []

Animate msg ->
    let
        updated =
            { model | menuStyle = Animation.update msg model.menuStyle }
    in
        updated ! []
```

**View.elm**

```elm
navView : Model -> Html Msg
navView model =
    let
        styles =
            Animation.render model.menuStyle

        attributes =
            class "submenu" :: styles
    in
        div attributes [ text "Navigation" ]
```

#### Links

* [mdgriffith/elm-style-animation](http://package.elm-lang.org/packages/mdgriffith/elm-style-animation/3.5.1)
