module Main exposing (..)

import Http
import Http.Progress exposing (Progress)
import Model exposing (..)
import Navigation exposing (Location)
import Routes exposing (Page(..))
import Time
import View


main : Program Never Model Msg
main =
    Navigation.program
        UrlChange
        { init = initialState
        , update = update
        , view = View.mainView
        , subscriptions =
            (\model ->
                case model.currentRequest of
                    Nothing ->
                        Sub.none

                    Just req ->
                        Http.Progress.track (toString model.currentRequestNumber) FetchedBytesProgress req
            )
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
                req =
                    Http.getString "/large"

                currentRequestNumber =
                    model.currentRequestNumber + 1
            in
                { model
                    | base64Text = "fetching…"
                    , currentRequest = Just req
                    , currentRequestNumber = currentRequestNumber
                }
                    ! []

        FetchedBytesProgress progress ->
            let
                text =
                    case progress of
                        Http.Progress.None ->
                            "starting…"

                        Http.Progress.Some { bytes, bytesExpected } ->
                            100
                                * (toFloat bytes)
                                / (toFloat bytesExpected)
                                |> toString
                                |> flip (++) "%"

                        Http.Progress.Done txt ->
                            txt

                        Http.Progress.Fail error ->
                            "Error"
            in
                { model | base64Text = text } ! []

        ToggleMenu ->
            { model | isMenuOpen = not model.isMenuOpen } ! []

        UrlChange location ->
            modelWithLocation location model ! []

        NavigateTo page ->
            let
                cmd =
                    Navigation.newUrl (Routes.pageToPath page)
            in
                model ! [ cmd ]
