---
layout: post
title:  "Chaining Animations"
date:   2017-01-19 15:02:00 -0500
categories:
label: ep-021
number: 21
tiny_description: Chain HTML animations together.
---

In the final episode of the series on [mdgriffith/elm-style-animation](http://package.elm-lang.org/packages/mdgriffith/elm-style-animation/3.5.1), we learn how
to chain multiple animations together in a coherent way. By firing a new `Msg` at the end of an animation, we're able
to keep blocks of code shorter and more maintainable.

See:
* [Part 1](https://elmseeds.thaterikperson.com/elm-style-animation)
* [Part 2](https://elmseeds.thaterikperson.com/elm-style-animation-two)


### Examples

**Main.elm**

```elm

DealHand ->
    let
        card1Styles style =
            Animation.interrupt
                [ Animation.toWith
                    (Animation.easing { duration = (Time.second * 1), ease = Ease.outCubic })
                    [ Animation.left (Animation.rem 30)
                    , Animation.top (Animation.rem 30)
                    ]
                , Animation.Messenger.send FirstCardDealt
                ]
                style

          card1Style =
              { initialCardStyle
                  | front = card1Styles 0 initialCardStyle.front
              }
    in
        { model | cardStyles = [ card1Style ] } ! []

FirstCardDealt ->
  let
      -- Perform next animation here
  in
      model ! []

Animate msg ->
    let
        stylesAndCmds : List CardStyle -> ( List CardStyle, List (Cmd Msg) )
        stylesAndCmds cardStyles =
            cardStyles
                |> List.map
                    (\s ->
                        let
                            ( frontMsg, frontCmd ) =
                                Animation.Messenger.update msg s.front
                        in
                            ( {s | front = frontMsg }, frontCmd )
                    )
                |> List.foldr
                    (\( style, cmd ) ( styleList, cmdList ) ->
                        ( style :: styleList, cmd :: cmdList )
                    )
                    ( [], [] )

        ( styles, cmds ) =
            stylesAndCmds model.cardStyles

        ( dealerStyles, dealerCmds ) =
            stylesAndCmds model.dealerCardStyles

        updated =
            { model
                | cardStyles = styles
                , dealerCardStyles = dealerStyles
            }
    in
        updated ! (cmds ++ dealerCmds)
```

#### Links

* [mdgriffith/elm-style-animation](http://package.elm-lang.org/packages/mdgriffith/elm-style-animation/3.5.1)
