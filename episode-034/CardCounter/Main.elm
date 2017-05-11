module Main exposing (..)

import Model exposing (..)
import NativeUi as Ui
import View


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Low ->
            { model | runningCount = model.runningCount + 1, cardsRemaining = model.cardsRemaining - 1 } ! []

        Mid ->
            { model | cardsRemaining = model.cardsRemaining - 1 } ! []

        High ->
            { model | runningCount = model.runningCount - 1, cardsRemaining = model.cardsRemaining - 1 } ! []

        Reset ->
            { model | runningCount = 0, cardsRemaining = model.numberOfDecks * 52 } ! []


main : Program Never Model Msg
main =
    Ui.program
        { init = ( model, Cmd.none )
        , view = View.view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
