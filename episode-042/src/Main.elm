module Main exposing (..)

import Html
import Model exposing (Model, Msg(..))
import View


main : Program Never Model Msg
main =
    Html.program
        { init = ( Model.initialModel, Cmd.none )
        , update = update
        , view = View.view
        , subscriptions = (\_ -> Sub.none)
        }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Signin ->
            ( model, Cmd.none )

        EmailUpdated email ->
            ( { model | email = email }, Cmd.none )

        PasswordUpdated password ->
            ( { model | password = password }, Cmd.none )

        AgeUpdated age ->
            ( { model | age = age }, Cmd.none )
