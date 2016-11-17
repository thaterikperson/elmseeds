module Main exposing (..)

import AnimationFrame
import Animation exposing (animation, from, to, ease)
import Blackjack as Bj
import Ease
import Html
import Http
import Json.Decode as JD exposing (Decoder, field)
import Json.Encode as JE
import Model exposing (..)
import String
import Task exposing (Task, andThen, mapError)
import Time exposing (second)
import View


main =
    Html.program
        { init = initialState
        , update = update
        , view = View.mainView
        , subscriptions = (\_ -> AnimationFrame.times CurrentTick)
        }


initialState : ( Model, Cmd Msg )
initialState =
    initialModel ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        ( leftCard, rightCard, remainingCards ) =
            case model.remainingCards of
                h :: h_ :: t ->
                    ( Just h, Just h_, t )

                _ ->
                    ( Nothing, Nothing, [] )
    in
        case msg of
            DealHand ->
                let
                    updated =
                        { model
                            | card = rightCard
                            , previousCard = leftCard
                            , counter = model.counter + 1
                            , error = Nothing
                            , remainingCards = remainingCards
                            , activeAnimation = Just (Animation.animation model.currentTick |> from 0 |> to 220 |> ease Ease.outQuart)
                        }

                    localTask =
                        locallyStore updated
                            |> mapError LocallyStoreError

                    remoteTask value =
                        remotelyStore value model
                            |> mapError (RemotelyStoreError << httpErrorToString)

                    cmd =
                        localTask
                            |> andThen remoteTask
                            |> Task.attempt Storage
                in
                    updated ! [ cmd ]

            CurrentTick time ->
                { model | currentTick = time } ! []

            Storage (Err error) ->
                let
                    updated =
                        updateModelFromErrorType error model
                in
                    updated ! []

            Storage (Ok serverResponse) ->
                let
                    updated =
                        { model
                            | numberOfHands = serverResponse.numberOfHands
                            , numberOfWins = serverResponse.numberOfWins
                            , favoriteCasino = serverResponse.favoriteCasino
                        }
                in
                    updated ! []


locallyStore : Model -> Task String Int
locallyStore model =
    Model.locallyStore model


remotelyStore : Int -> Model -> Task Http.Error ServerResponse
remotelyStore counter model =
    let
        decoder =
            JD.map4 toServerResponse
                (field "status" JD.string)
                (field "number_of_hands" JD.int)
                (field "number_of_wins" JD.int)
                (field "favorite_casino" <|
                    JD.oneOf
                      [ JD.null Nothing
                      , JD.map Just JD.string
                      ]
                )

        url =
            "http://localhost:4000?count=" ++ (toString (counter))
    in
        Http.post url Http.emptyBody decoder
          |> Http.toTask


httpErrorToString : Http.Error -> String
httpErrorToString error =
    case error of
        Http.Timeout ->
            "Timeout"

        Http.NetworkError ->
            "Network error"

        Http.BadPayload string _ ->
            string

        Http.BadStatus _ ->
            "Bad Status"

        Http.BadUrl string ->
          string


toServerResponse : String -> Int -> Int -> Maybe String -> ServerResponse
toServerResponse status hands wins casino =
    let
        casinoResult =
            casino
                |> Maybe.andThen
                    (\c ->
                        c
                            |> String.toInt
                            |> Result.toMaybe
                    )

        favoriteCasino =
            casinoResult
                |> Maybe.andThen (\num -> Model.toCasino num)
                |> Maybe.withDefault Unknown
    in
        ServerResponse status hands wins favoriteCasino
