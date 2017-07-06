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
        Signin ->
            { model | count = model.count + 1 } ! []
