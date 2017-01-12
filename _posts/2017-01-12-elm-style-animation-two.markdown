---
layout: post
title:  "Advanced Animations"
date:   2017-01-12 11:02:00 -0500
categories:
label: ep-020
tiny_description: Create advanced HTML animations.
---

In this episode, we use [mdgriffith/elm-style-animation](http://package.elm-lang.org/packages/mdgriffith/elm-style-animation/3.5.1) to perform several, interrelated animations on an html deck of cards.


### Examples

**Main.elm**

```elm

DealHand ->
    let
        dealerCard1Styles rotation style =
            Animation.interrupt
                [ Animation.wait (Time.second * 2)
                , Animation.toWith
                    (Animation.easing { duration = (Time.second * 1), ease = Ease.outCubic })
                    [ Animation.left (Animation.rem 30)
                    , Animation.top (Animation.rem -2)
                    ]
                , Animation.wait (Time.second * 4)
                , Animation.to
                    [ Animation.rotate3d (deg 0) (deg rotation) (deg 0)
                    ]
                ]
                style

          dealerCard1Style =
              { initialCardStyle
                  | front = dealerCard1Styles 0 initialCardStyle.front
                  , back = dealerCard1Styles 180 initialCardStyle.back
              }
    in
        { model | dealerCardStyles = [ dealerCard1Style ] } ! []

Animate msg ->
    let
        updated =
            { model
                | dealerCardStyles =
                    List.map
                        (\s ->
                            { front = Animation.update msg s.front
                            , back = Animation.update msg s.back
                            }
                        )
                        model.dealerCardStyles
            }
    in
        updated ! []
```

#### Links

* [mdgriffith/elm-style-animation](http://package.elm-lang.org/packages/mdgriffith/elm-style-animation/3.5.1)
