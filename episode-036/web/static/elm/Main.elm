module Main exposing (..)

import Html
import Model exposing (..)
import Task
import View
import Window


main : Program Never Model Msg
main =
    Html.program
        { init = ( initialModel, initialSize )
        , update = update
        , view = View.mainView
        , subscriptions =
            (\_ ->
                Window.resizes SizeUpdated
            )
        }


initialSize : Cmd Msg
initialSize =
    Window.size
        |> Task.perform SizeUpdated


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SizeUpdated newSize ->
            { model | windowSize = newSize } ! []
