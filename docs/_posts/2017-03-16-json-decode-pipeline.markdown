---
layout: post
title:  "Json.Decode.Pipeline"
date:   2017-03-16 14:16:00 -0400
categories:
label: ep-028
number: 28
tiny_description: Decode large and complex Json objects with easy to understand functions.
---

The core `Json.Decode` module has functions `map` through `map8` which allow you to easily decode Json objects with up to eight properties, but if you want to decode more properties than that, things get a little tricky. Dealing with optional and nullable properties complicates things even further. Use No Red Ink's [`Json.Decode.Pipeline`](http://package.elm-lang.org/packages/NoRedInk/elm-decode-pipeline/3.0.0/Json-Decode-Pipeline) to decode larger objects and better represent the underlying Json you're parsing.


### Examples

**Main.elm**

```elm
import Json.Decode.Pipeline exposing (decode, required, optional)


personDecoder : Decoder Person
personDecoder =
    decode Person
        |> required "username" string
        |> required "url" string
        |> required "bank" float
        |> required "lastBetSize" float
        |> required "handsPlayed" int
        |> required "handsWon" int
        |> required "averageBet" float
        |> required "lastPlayedAt" string
        |> optional "favoriteCasino" (maybe string) Nothing
```

#### Links

* [NoRedInk/elm-decode-pipeline](http://package.elm-lang.org/packages/NoRedInk/elm-decode-pipeline/3.0.0/Json-Decode-Pipeline)
* [Episode 10: Json.Decode.Extra](http://elmseeds.thaterikperson.com/json-decode-extra)
