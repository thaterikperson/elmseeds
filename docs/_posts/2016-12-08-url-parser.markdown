---
layout: post
title:  "Url Parser"
date:   2016-12-08 13:51:00 -0500
categories:
label: ep-017
number: 17
tiny_description: Parse the browser's url to update your model.
---

A follow up to the [Navigation](/navigation) episode, [evancz/url-parser](http://package.elm-lang.org/packages/evancz/url-parser/2.0.1) helps you parse a [`Navigation.Location`](http://package.elm-lang.org/packages/elm-lang/navigation/2.0.1/Navigation#Location) record into a union type. Including that type in your model allows you to update the view based on the page the user requests.

### Examples

```sh
$ elm-package install evancz/url-parser
```

**Routes.elm**

```elm
type Page
    = Home
    | About
    | Theme String

pageParser : Parser (Page -> a) a
pageParser =
    oneOf
        [ map Home (s "")
        , map About (s "about")
        , map Theme (s "theme" </> string)
        ]


pathParser : Navigation.Location -> Maybe Page
pathParser location =
    UrlParser.parsePath pageParser location
```

**Main.elm**

```elm
modelWithLocation : Location -> Model -> Model
modelWithLocation location model =
    let
        page =
            location
                |> Routes.pathParser
                |> Maybe.withDefault Home
    in
        { model | page = page }


initialState : Location -> ( Model, Cmd Msg )
initialState location =
    modelWithLocation location initialModel ! []


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
      UrlChange location ->
          modelWithLocation location model ! []
```

#### Links

* [evancz/url-parser](http://package.elm-lang.org/packages/evancz/url-parser/2.0.1)
