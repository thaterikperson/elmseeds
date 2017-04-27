module Main exposing (..)

import Html
import Model exposing (..)
import View


main : Program Never Model Msg
main =
    Html.program
        { init = ( initialModel, Cmd.none )
        , update = update
        , view = View.mainView
        , subscriptions = (\_ -> Sub.none)
        }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        AddMessage ->
            case model.message of
                "" ->
                    model ! []

                message ->
                    { model | messages = message :: model.messages, message = "" } ! []

        MessageUpdate msg ->
            { model | message = msg } ! []

        KeyUp keyCode isShift ->
            case ( keyCode, isShift ) of
                ( 13, True ) ->
                    update AddMessage model

                _ ->
                    model ! []
