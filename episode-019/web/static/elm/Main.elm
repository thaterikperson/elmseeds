module Main exposing (..)

import Animation exposing (deg)
import Ease
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
        , subscriptions = (\model -> Animation.subscription Animate [ model.menuStyle ])
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
                        }
                in
                    updated ! []

            ToggleMenu ->
                let
                    tos =
                        if model.isMenuOpen then
                            [ Animation.top (Animation.rem -4)
                            , Animation.opacity 0.0
                            ]
                        else
                            [ Animation.top (Animation.rem 0)
                            , Animation.opacity 1.0
                            ]

                    menuStyle =
                        Animation.interrupt
                            [ Animation.to tos
                            ]
                            model.menuStyle
                in
                    { model | isMenuOpen = not model.isMenuOpen, menuStyle = menuStyle } ! []

            Animate msg ->
                let
                    updated =
                        { model
                            | menuStyle = Animation.update msg model.menuStyle
                        }
                in
                    updated ! []

            UrlChange location ->
                modelWithLocation location model ! []

            NavigateTo page ->
                let
                    cmd =
                        Navigation.newUrl (Routes.pageToPath page)
                in
                    model ! [ cmd ]
