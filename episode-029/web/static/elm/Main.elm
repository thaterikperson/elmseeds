module Main exposing (..)

import Html
import Http exposing (stringPart, Request)
import Json.Decode as Decode exposing (Decoder, float, int, list)
import Model exposing (..)
import Task
import View
import Json.Decode.Pipeline exposing (decode, required)


main : Program Never Model Msg
main =
    Html.program
        { init = ( initialModel, initCmd )
        , update = update
        , view = View.mainView
        , subscriptions = (\_ -> Sub.none)
        }


initCmd : Cmd Msg
initCmd =
    Http.get "/data" (list dayDecoder)
        |> Http.send DataRequestCompleted


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToggleMenu ->
            { model | isMenuOpen = not model.isMenuOpen } ! []

        DataRequestCompleted (Ok days) ->
            let
                updated =
                    { model | days = days }
            in
                updated ! []

        DataRequestCompleted (Err err) ->
            model ! []


dayDecoder : Decoder Day
dayDecoder =
    decode Day
        |> required "day" int
        |> required "wins" int
        |> required "losses" int
        |> required "gain" float
