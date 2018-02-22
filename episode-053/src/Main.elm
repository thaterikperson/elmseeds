module Main exposing (main)

import Html exposing (Html, h1, text)
import Navigation exposing (Location)
import Route
import UrlParser


type Msg
    = SetRoute Location


type Page
    = Home
    | Newest


type alias Model =
    { page : Page
    }


main : Program Never Model Msg
main =
    Navigation.program SetRoute
        { init = init
        , update = update
        , view = view
        , subscriptions = (\_ -> Sub.none)
        }


init : Location -> ( Model, Cmd Msg )
init location =
    ( setRoute location { page = Home }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetRoute location ->
            ( setRoute location model, Cmd.none )


setRoute : Location -> Model -> Model
setRoute location model =
    let
        route =
            UrlParser.parsePath Route.route location
                |> Maybe.withDefault Route.Home
    in
        case route of
            Route.Home ->
                { model | page = Home }

            Route.Newest ->
                { model | page = Newest }


view : Model -> Html Msg
view model =
    case model.page of
        Home ->
            h1 [] [ text "👩\x200D💻 News" ]

        Newest ->
            h1 [] [ text "Newest" ]
