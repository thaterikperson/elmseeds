module Main exposing (..)

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
            model ! []

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
