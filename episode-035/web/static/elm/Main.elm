module Main exposing (..)

import Geolocation
import Html
import Model exposing (..)
import Task
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
        FetchLocation ->
            let
                cmd =
                    Geolocation.nowWith
                        { enableHighAccuracy = False
                        , timeout = Just 2000
                        , maximumAge = Nothing
                        }
                        |> Task.attempt LocationUpdated
            in
                model ! [ cmd ]

        LocationUpdated (Ok location) ->
            { model | location = Just location } ! []

        LocationUpdated (Err error) ->
            let
                _ =
                    Debug.log "LocationUpdated" error
            in
                model ! []
