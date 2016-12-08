module View exposing (..)

import Animation
import Blackjack exposing (Card, CardType(..), CardSuit(..), suitOfCard, typeOfCard, bestScore, newHand, addCardToHand)
import Date exposing (Date, Month(..))
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Json
import Model exposing (..)
import Routes exposing (Page(..))


cardToText : Card -> String
cardToText card =
    let
        suitText =
            case suitOfCard card of
                Clubs ->
                    "Clubs"

                Diamonds ->
                    "Diamonds"

                Hearts ->
                    "Hearts"

                Spades ->
                    "Spades"

        typeText =
            case typeOfCard card of
                Ace ->
                    "A"

                King ->
                    "K"

                Queen ->
                    "Q"

                Jack ->
                    "J"

                Ten ->
                    "10"

                Nine ->
                    "9"

                Eight ->
                    "8"

                Seven ->
                    "7"

                Six ->
                    "6"

                Five ->
                    "5"

                Four ->
                    "4"

                Three ->
                    "3"

                Two ->
                    "2"
    in
        typeText ++ " " ++ suitText


dateToString : Date -> String
dateToString date =
    let
        month =
            case Date.month date of
                Jan ->
                    "Jan"

                Feb ->
                    "Feb"

                Mar ->
                    "Mar"

                Apr ->
                    "Apr"

                May ->
                    "May"

                Jun ->
                    "Jun"

                Jul ->
                    "Jul"

                Aug ->
                    "Aug"

                Sep ->
                    "Sep"

                Oct ->
                    "Oct"

                Nov ->
                    "Nov"

                Dec ->
                    "Dec"
    in
        month ++ " " ++ (toString <| Date.day date)


aboutView : Model -> Html Msg
aboutView model =
    div [ class "container" ]
        [ div [ class "row" ]
            [ div [ class "eight columns offset-by-two" ]
                [ h1 [] [ text "Blackjack by Elmseeds" ]
                , p []
                    [ text "A work in progress Blackjack game."
                    ]
                , p []
                    [ text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus egestas augue porttitor est cursus, non interdum diam luctus. Duis ac auctor quam, eget auctor erat. In porttitor turpis et libero iaculis vestibulum. Cras interdum mi in arcu sagittis dapibus. Suspendisse potenti. Duis id lectus luctus lorem tristique interdum ornare eu lorem. Vivamus eleifend aliquet vulputate. Quisque pretium semper elementum. Vivamus at purus eleifend, viverra nibh nec, euismod felis. Nullam condimentum venenatis elit, id vestibulum leo accumsan at. Nulla sit amet turpis ipsum. Quisque placerat interdum erat a pulvinar. Sed tristique, nisl quis aliquam commodo, metus lectus blandit erat, non porttitor sapien eros eu enim. Sed hendrerit turpis nec risus congue, in lacinia ipsum pretium. Suspendisse a ultricies diam, sit amet ornare augue. Aenean mollis sapien sit amet ligula vestibulum rhoncus. In eget ipsum mollis, consectetur libero nec, venenatis odio. Etiam semper quam vel imperdiet varius."
                    ]
                , p []
                    [ a [ href "/", onLinkClick (NavigateTo About) ] [ text "Home" ]
                    ]
                ]
            ]
        ]


onLinkClick : msg -> Attribute msg
onLinkClick msg =
    onWithOptions "click"
        { stopPropagation = True
        , preventDefault = True
        }
        (Json.succeed msg)


homeView : Model -> Html Msg
homeView model =
    customThemeView "black" model


customThemeView : String -> Model -> Html Msg
customThemeView theme model =
    let
        blank =
            span [] []

        cardLabel =
            (\c -> label [] [ text <| cardToText c ])

        x =
            case model.activeAnimation of
                Nothing ->
                    0

                Just a ->
                    Animation.animate model.currentTick a

        deckView =
            div [ class "deck" ] []

        cardView =
            case model.card of
                Nothing ->
                    blank

                Just card ->
                    div [ class "card", style [ ( "left", (toString x) ++ "px" ) ] ] [ cardLabel card ]

        previousCardView =
            case model.previousCard of
                Nothing ->
                    blank

                Just card ->
                    div [ class "card", style [ ( "left", (toString (x * 2)) ++ "px" ) ] ] [ cardLabel card ]
    in
        div [ class ("container " ++ theme) ]
            [ div [ class "row" ]
                [ div [ class "twelve columns links" ]
                    [ a [ href "/theme/black", onLinkClick (NavigateTo (Theme "black")) ] [ text "Black Theme" ]
                    , a [ href "/theme/blue", onLinkClick (NavigateTo (Theme "blue")) ] [ text "Blue Theme" ]
                    , a [ href "/theme/red", onLinkClick (NavigateTo (Theme "red")) ] [ text "Red Theme" ]
                    , a [ href "/about", onLinkClick (NavigateTo About) ] [ text "About" ]
                    ]
                ]
            , div [ class "row card-row" ] [ deckView, cardView, previousCardView ]
            , div [ class "row" ]
                [ div [ class "one-third column" ]
                    [ button [ onClick DealHand ] [ text "Deal" ]
                    ]
                ]
            , div [ class "row" ]
                [ div [ class "one-third column" ]
                    [ (case model.error of
                        Nothing ->
                            span [] []

                        Just msg ->
                            span [ class "error" ] [ text msg ]
                      )
                    ]
                ]
            ]


mainView : Model -> Html Msg
mainView model =
    case model.page of
        Home ->
            homeView model

        About ->
            aboutView model

        Theme color ->
            customThemeView color model
