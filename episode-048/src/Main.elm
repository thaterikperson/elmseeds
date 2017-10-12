module Main exposing (..)

import Array
import Html
import Model exposing (Model, Msg(..))
import View


init : ( Model, Cmd Msg )
init =
    ( Model.initialModel, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SelectTab id ->
            model ! []


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , view = View.view
        , subscriptions = (\_ -> Sub.none)
        }
