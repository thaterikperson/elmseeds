module Model exposing (..)


type Msg
    = Low
    | Mid
    | High
    | Reset


type alias Model =
    { runningCount : Int
    , numberOfDecks : Int
    , cardsRemaining : Int
    }


model : Model
model =
    { runningCount = 0
    , numberOfDecks = 6
    , cardsRemaining = 6 * 52
    }


trueCount : Model -> Float
trueCount model =
    let
        decksRemaing =
            (toFloat model.cardsRemaining) / 52
    in
        (toFloat model.runningCount) / decksRemaing
