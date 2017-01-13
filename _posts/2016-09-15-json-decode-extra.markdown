---
layout: post
title:  "Json.Decode.Extra"
date:   2016-09-15 10:30:00 -0500
categories:
label: ep-010
number: 10
tiny_description: Use Json.Decode.Extra when Json.Decode isn't enough.
---

[Json.Decode.Extra](http://package.elm-lang.org/packages/elm-community/json-extra/1.1.0/Json-Decode-Extra) is a set of "Convenience functions for working with Json". It adds functions that you'll find yourself in need of when doing more advanced work with Json and Elm. Elm's default `Json.Decode` library is pretty good but has some shortcomings.

### Examples

##### Main.elm

```bash
$ elm-package install elm-community/json-extra
```

```elm
import Json.Decode.Extra as Extra exposing ((|:))

metaDataDecoder : Decoder MetaData
metaDataDecoder =
  Json.Decode.map MetaData ("username" := JD.string)
    |: ("lastPlayedAt" := Extra.date)
    |: ("url" := JD.string)
    |: ("bank" := JD.float)
    |: ("lastBetSize" := betDecoder)

betDecoder : Decoder (Maybe Float)
betDecoder =
  Json.Decode.float |> Extra.withDefault 0.0
```


### Links

* [Json.Decode.Extra](http://package.elm-lang.org/packages/elm-community/json-extra/1.1.0/Json-Decode-Extra)
* [Json.Decode](http://package.elm-lang.org/packages/elm-lang/core/4.0.5/Json-Decode)
