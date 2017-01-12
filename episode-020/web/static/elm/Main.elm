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
        , subscriptions =
            (\model ->
                let
                    styles =
                        (model.cardStyles ++ model.dealerCardStyles)
                            |> List.map (\s -> [ s.front, s.back ])
                            |> List.concat
                in
                    Animation.subscription Animate (model.menuStyle :: styles)
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
            case model.remainingCards of
                card1 :: dealerCard1 :: card2 :: dealerCard2 :: remainingCards ->
                    let
                        card1Styles rotation style =
                            Animation.interrupt
                                [ Animation.toWith
                                    (Animation.easing { duration = (Time.second * 1), ease = Ease.outCubic })
                                    [ Animation.left (Animation.rem 30)
                                    , Animation.top (Animation.rem 30)
                                    ]
                                , Animation.to
                                    [ Animation.rotate3d (deg 0) (deg rotation) (deg 0)
                                    ]
                                ]
                                style

                        card1Style =
                            { initialCardStyle
                                | front = card1Styles 0 initialCardStyle.front
                                , back = card1Styles 180 initialCardStyle.back
                            }

                        dealerCard1Styles rotation style =
                            Animation.interrupt
                                [ Animation.wait (Time.second * 2)
                                , Animation.toWith
                                    (Animation.easing { duration = (Time.second * 1), ease = Ease.outCubic })
                                    [ Animation.left (Animation.rem 30)
                                    , Animation.top (Animation.rem -2)
                                    ]
                                , Animation.wait (Time.second * 4)
                                , Animation.to
                                    [ Animation.rotate3d (deg 0) (deg rotation) (deg 0)
                                    ]
                                ]
                                style

                        dealerCard1Style =
                            { initialCardStyle
                                | front = dealerCard1Styles 0 initialCardStyle.front
                                , back = dealerCard1Styles 180 initialCardStyle.back
                            }

                        card2Styles rotation style =
                            Animation.interrupt
                                [ Animation.wait (Time.second * 3)
                                , Animation.toWith
                                    (Animation.easing { duration = (Time.second * 1), ease = Ease.outCubic })
                                    [ Animation.left (Animation.rem 25)
                                    , Animation.top (Animation.rem 30)
                                    ]
                                , Animation.to
                                    [ Animation.rotate3d (deg 0) (deg rotation) (deg 0)
                                    ]
                                ]
                                style

                        card2Style =
                            { initialCardStyle
                                | front = card2Styles 0 initialCardStyle.front
                                , back = card2Styles 180 initialCardStyle.back
                            }

                        dealerCard2Styles style =
                            Animation.interrupt
                                [ Animation.wait (Time.second * 5)
                                , Animation.toWith
                                    (Animation.easing { duration = (Time.second * 1), ease = Ease.outCubic })
                                    [ Animation.left (Animation.rem 25)
                                    , Animation.top (Animation.rem -2)
                                    ]
                                ]
                                style

                        dealerCard2Style =
                            { initialCardStyle
                                | front = dealerCard2Styles initialCardStyle.front
                                , back = dealerCard2Styles initialCardStyle.back
                            }

                        updated =
                            { model
                                | hand = [ card1, card2 ]
                                , remainingCards = remainingCards
                                , cardStyles = [ card1Style, card2Style ]
                                , dealerHand = [ dealerCard1, dealerCard2 ]
                                , dealerCardStyles = [ dealerCard1Style, dealerCard2Style ]
                            }
                    in
                        updated ! []

                _ ->
                    model ! []

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
                        , cardStyles =
                            List.map
                                (\s ->
                                    { front = Animation.update msg s.front
                                    , back = Animation.update msg s.back
                                    }
                                )
                                model.cardStyles
                        , dealerCardStyles =
                            List.map
                                (\s ->
                                    { front = Animation.update msg s.front
                                    , back = Animation.update msg s.back
                                    }
                                )
                                model.dealerCardStyles
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
