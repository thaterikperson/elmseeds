module Main exposing (..)

import Blackjack exposing (Card, CardSuit(..), CardType(..), newCard, addCardToHand, hasAce, newHand)
import Http
import Json.Encode as JE
import Model exposing (..)
import Navigation exposing (Location)
import Routes exposing (Page(..))
import Time
import View
import WebSocket as WS


wsAddress : String
wsAddress =
    "ws://localhost:4000/socket/websocket"


main : Program Never Model Msg
main =
    Navigation.program
        UrlChange
        { init = initialState
        , update = update
        , view = View.mainView
        , subscriptions =
            (\model ->
                WS.listen wsAddress Heard
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
                f :: s :: rest ->
                    let
                        payload =
                            JE.encode 0 <|
                                JE.object
                                    [ ( "event", JE.string "phx_join" )
                                    , ( "topic", JE.string "all" )
                                    , ( "payload", JE.string "card1" )
                                    , ( "ref", JE.int 1 )
                                    ]

                        cmd =
                            WS.send wsAddress payload
                    in
                        model ! [ cmd ]

                _ ->
                    model ! []

        Heard msg ->
            let
                _ =
                    Debug.log "msg" msg
            in
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
