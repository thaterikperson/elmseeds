module Main exposing (..)

import Html
import Http exposing (stringPart, Request)
import Json.Decode as Decode exposing (Decoder, field, string, float, int, maybe)
import Model exposing (..)
import Task
import View
import Json.Decode.Pipeline exposing (decode, required, optional)


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
    Http.getString "/person"
        |> Http.send PersonRequestCompleted


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToggleMenu ->
            { model | isMenuOpen = not model.isMenuOpen } ! []

        PersonRequestCompleted (Ok rawText) ->
            let
                ( raw, person ) =
                    case Decode.decodeString personDecoder rawText of
                        Ok p ->
                            ( rawText, Just p )

                        Err error ->
                            ( Debug.log "error" error, Nothing )
            in
                { model | person = person, rawPersonString = raw } ! []

        PersonRequestCompleted (Err err) ->
            { model | person = Nothing, rawPersonString = (toString err) } ! []


personDecoder : Decoder Person
personDecoder =
    decode Person
        |> required "username" string
        |> required "url" string
        |> required "bank" float
        |> required "lastBetSize" float
        |> required "handsPlayed" int
        |> required "handsWon" int
        |> required "averageBet" float
        |> required "lastPlayedAt" string
        |> optional "favoriteCasino" string ""



--     Decode.andThen subPersonDecoder (field "favoriteCasino" (maybe string))
--
--
-- subPersonDecoder : Maybe String -> Decoder Person
-- subPersonDecoder casino =
--     Decode.map8 (\a b c d e f g h -> Person a b c d e f g h casino)
--         (field "username" string)
--         (field "url" string)
--         (field "bank" float)
--         (field "lastBetSize" float)
--         (field "handsPlayed" int)
--         (field "handsWon" int)
--         (field "averageBet" float)
--         (field "lastPlayedAt" string)
