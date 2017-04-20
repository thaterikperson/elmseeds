---
layout: post
title:  "Animations"
date:   2016-06-23 10:00:00 -0500
categories:
label: ep-006
number: 6
tiny_description: Animate your HTML the Elm way.
---

Animations in Elm are very natural, but require a couple of community libraries to do well. The first, [animation-frame](http://package.elm-lang.org/packages/elm-lang/animation-frame/1.0.0/) provides precise timing using the browser's `requestAnimationFrame` callback. Using that precise timing, you can interpolate the values you want to animate between, and render your view on each tick. Interpolating those values is made much easier using [elm-animation](http://package.elm-lang.org/packages/mgold/elm-animation/1.0.4/) and [easing-functions](http://package.elm-lang.org/packages/elm-community/easing-functions/1.0.1/). Using these libraries, you can generate all sorts of proper-looking and buttery-smooth animations.


### Samples

##### Main module
```
Html.program
  { -- …
  , subscriptions = (\_ -> AnimationFrame.times CurrentTick)
  }

update msg model =
  FetchNewCard ->
    let
      animation = Animation.animation model.currentTick |> from 0 |> to 300 |> ease Ease.outQuart
    in
      { model | animation = animation } ! []
  CurrentTick time ->
    { model | currentTick = time } ! []
```

##### View module
```
xCoordinate = Animation.animate model.currentTick model.animation
animatingDiv =
  div
    [style [("left", (toString xCoordinate) ++ "px")]]
    [text "This will animate"]
```

### Links
* [elm-lang/animation-frame](http://package.elm-lang.org/packages/elm-lang/animation-frame/1.0.0/)
* [mgold/elm-animation](http://package.elm-lang.org/packages/mgold/elm-animation/1.0.4/)
* [elm-community/easing-functions](http://package.elm-lang.org/packages/elm-community/easing-functions/1.0.1/)
* [easyings.net](http://easings.net)
