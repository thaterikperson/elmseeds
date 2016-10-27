---
layout: post
title:  "Generative Testing"
date:   2016-10-27 11:44:00 -0400
categories:
label: ep-012
tiny_description: Generative testing uses a little code to write a lot of tests.
---

[elm-community/elm-test](http://package.elm-lang.org/packages/elm-community/elm-test/latest) has the ability to do generative testing. In this episode we look at a basic use case for it and discover how it finds bugs that would be much harder to find with only hand-written unit tests.

### Examples

```elm
import Expect
import Fuzz
import Test exposing (Test, describe, test)
import Test.Runner.Html

faceCardsFuzzer : Fuzzer Hand
faceCardsFuzzer =
  Fuzz.map (\cards -> addCardsToHand cards newHand)
    (Fuzz.list
      (Fuzz.map2 deserializeCard
        (Fuzz.intRange 8 11)
        (Fuzz.intRange 0 3)))


splitTests : Test
splitTests =
  describe "isSplittable"
    [ test "Two different cards" <| \() -> isSplittable aS9D |> Expect.equal False
    , test "Different cards, same suit" <| \() -> isSplittable aS9S |> Expect.equal False
    , test "Same cards" <| \() -> isSplittable aSaD |> Expect.equal True
    , test "Two face cards" <| \() -> isSplittable tHtC |> Expect.equal True
    , fuzz faceCardsFuzzer "Any face cards" <|
        \(BjHand cards) ->
          let expect = List.length cards == 2
          in isSplittable (BjHand cards) |> Expect.equal expect
    ]

main : Program Never
main =
  Test.Runner.Html.run splitTests
```


### Links

* [elm-community/elm-test](http://package.elm-lang.org/packages/elm-community/elm-test/latest)
* [John Hughes - Testing the Hard Stuff and Staying Sane](https://www.youtube.com/watch?v=zi0rHwfiX1Q) - Video teaching generative testing from the author of QuickSpec, a generative testing framework for Erlang
