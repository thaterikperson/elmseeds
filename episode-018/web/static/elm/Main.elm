module Main exposing (..)

import AnimationFrame
import Animation exposing (animation, from, to, ease)
import Ease
import Http
import Json.Decode as JD exposing (Decoder, field)
import Model exposing (..)
import Navigation exposing (Location)
import Routes exposing (Page(..))
import String
import Task exposing (Task, andThen, mapError)
import View


main : Program Never Model Msg
main =
    Navigation.program
        UrlChange
        { init = initialState
        , update = update
        , view = View.mainView
        , subscriptions = (\_ -> Sub.none)
        }


initialState : Location -> ( Model, Cmd Msg )
initialState location =
    modelWithLocation location initialModel ! []


modelWithLocation : Location -> Model -> Model
modelWithLocation location model =
    let
        page =
            location
                |> Routes.pathParser
                |> Maybe.withDefault Home
    in
        { model | page = page }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DealHand ->
            let
                cmd =
                    remotelyStore model.counter model
                        |> Task.attempt Storage
            in
                { model | counter = model.counter + 1 } ! [ cmd ]

        UrlChange location ->
            modelWithLocation location model ! []

        NavigateTo page ->
            let
                cmd =
                    Navigation.newUrl (Routes.pageToPath page)
            in
                model ! [ cmd ]

        Storage (Ok result) ->
            let
                _ =
                    Debug.log "Storage Ok" result
            in
                model ! []

        Storage (Err error) ->
            let
                _ =
                    Debug.log "Storage Err" error
            in
                model ! []


remotelyStore : Int -> Model -> Task Error String
remotelyStore counter model =
    let
        decoder =
            JD.map4 toServerResponse
                (field "status" JD.string)
                (field "number_of_hands" JD.int)
                (field "number_of_wins" JD.int)
                (field "favorite_casino" <| JD.maybe JD.string)

        url =
            "http://localhost:4000?count=" ++ (toString (counter))
    in
        Http.post url Http.emptyBody decoder
            |> Http.toTask
            |> Task.map (.status >> String.toUpper)
            |> Task.mapError (RemotelyStoreError << httpErrorToString)


httpErrorToString : Http.Error -> String
httpErrorToString error =
    case error of
        Http.Timeout ->
            "Timeout"

        Http.NetworkError ->
            "Network error"

        Http.BadPayload string _ ->
            string

        Http.BadStatus { body } ->
            body

        Http.BadUrl string ->
            string


toServerResponse : String -> Int -> Int -> Maybe String -> ServerResponse
toServerResponse status hands wins casino =
    let
        favoriteCasino =
            casino
                |> Maybe.andThen (\c -> Result.toMaybe (String.toInt c))
                |> Maybe.andThen Model.toCasino
                |> Maybe.withDefault Unknown
    in
        ServerResponse status hands wins favoriteCasino
