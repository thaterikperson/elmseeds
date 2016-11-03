module Main exposing (..)

import Html.App as Html
import Html exposing (..)


main =
  Html.beginnerProgram
    { view = view
    , update = update
    , model = model
    }

model = 1

view model =
  div []
    [ h1 [] [text "Hello Elm"]
    , h4 [] [text "Elm is Fun"]
    ]

update model msg =
  model
