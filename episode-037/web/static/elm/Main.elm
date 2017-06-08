module Main exposing (..)

import Http
import Html
import Json.Decode as Decode
import Model exposing (..)
import Task
import View
import Window


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
        FetchData ->
            let
                winsCmd =
                    Http.get "http://localhost:4000/wins" Decode.int
                        |> Http.send WinsFetched

                gamesCmd =
                    Http.get "http://localhost:4000/games" Decode.int
                        |> Http.send GamesFetched
            in
                { model | wins = Loading, games = Loading } ! [ winsCmd, gamesCmd ]

        WinsFetched (Ok wins) ->
            { model | wins = Success wins } ! []

        WinsFetched (Err error) ->
            let
                _ =
                    Debug.log "WinsFetched" error
            in
                { model | wins = Failure error } ! []

        GamesFetched (Ok games) ->
            { model | games = Success games } ! []

        GamesFetched (Err error) ->
            let
                _ =
                    Debug.log "GamesFetched" error
            in
                { model | games = Failure error } ! []
