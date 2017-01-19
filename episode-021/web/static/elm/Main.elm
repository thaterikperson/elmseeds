module Main exposing (..)

import Animation exposing (deg)
import Animation.Messenger
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
                            let
                                animations =
                                    [ Animation.toWith
                                        (Animation.easing { duration = (Time.second * 1), ease = Ease.outCubic })
                                        [ Animation.left (Animation.rem 30)
                                        , Animation.top (Animation.rem 30)
                                        ]
                                    , Animation.to
                                        [ Animation.rotate3d (deg 0) (deg rotation) (deg 0)
                                        ]
                                    ]

                                final =
                                    if rotation == 0 then
                                        animations ++ [ Animation.Messenger.send FirstCardDealt ]
                                    else
                                        animations
                            in
                                Animation.interrupt final style

                        card1Style =
                            { initialCardStyle
                                | front = card1Styles 0 initialCardStyle.front
                                , back = card1Styles 180 initialCardStyle.back
                            }

                        updated =
                            { model
                                | hand = [ card1 ]
                                , remainingCards = remainingCards
                                , cardStyles =
                                    [ card1Style ]
                                    -- , dealerHand = [ dealerCard1 ]
                                    -- , dealerCardStyles = [ dealerCard1Style ]
                            }
                    in
                        updated ! []

                _ ->
                    model ! []

        FirstCardDealt ->
            case model.remainingCards of
                dealerCard1 :: remainingCards ->
                    let
                        dealerCard1Styles rotation style =
                            let
                                animations =
                                    [ Animation.toWith
                                        (Animation.easing { duration = (Time.second * 1), ease = Ease.outCubic })
                                        [ Animation.left (Animation.rem 30)
                                        , Animation.top (Animation.rem -2)
                                        ]
                                    , Animation.Messenger.send FirstDealerCardDealt
                                    ]
                            in
                                Animation.interrupt animations style

                        dealerCard1Style =
                            { initialCardStyle
                                | front = dealerCard1Styles 0 initialCardStyle.front
                                , back = dealerCard1Styles 180 initialCardStyle.back
                            }

                        updated =
                            { model
                                | remainingCards = remainingCards
                                , dealerHand = [ dealerCard1 ]
                                , dealerCardStyles = [ dealerCard1Style ]
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
                stylesAndCmds : List CardStyle -> ( List CardStyle, List (Cmd Msg) )
                stylesAndCmds cardStyles =
                    cardStyles
                        |> List.map
                            (\s ->
                                let
                                    ( frontMsg, frontCmd ) =
                                        Animation.Messenger.update msg s.front

                                    ( backMsg, backCmd ) =
                                        Animation.Messenger.update msg s.back
                                in
                                    ( CardStyle frontMsg backMsg, Cmd.batch [ frontCmd, backCmd ] )
                            )
                        |> List.foldr
                            (\( style, cmd ) ( styleList, cmdList ) ->
                                ( style :: styleList, cmd :: cmdList )
                            )
                            ( [], [] )

                ( styles, cmds ) =
                    stylesAndCmds model.cardStyles

                ( dealerStyles, dealerCmds ) =
                    stylesAndCmds model.dealerCardStyles

                updated =
                    { model
                        | menuStyle = Animation.update msg model.menuStyle
                        , cardStyles = styles
                        , dealerCardStyles = dealerStyles
                    }
            in
                updated ! (cmds ++ dealerCmds)

        UrlChange location ->
            modelWithLocation location model ! []

        NavigateTo page ->
            let
                cmd =
                    Navigation.newUrl (Routes.pageToPath page)
            in
                model ! [ cmd ]
