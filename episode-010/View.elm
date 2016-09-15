module View exposing (..)

import Animation
import Blackjack exposing (Card, CardType (..), CardSuit (..), suitOfCard, typeOfCard, bestScore, newHand, addCardToHand)
import Date exposing (Date, Month(..))
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import Result


cardToText : Card -> String
cardToText card =
  let
    suitText =
      case suitOfCard card of
        Clubs -> "Clubs"
        Diamonds -> "Diamonds"
        Hearts -> "Hearts"
        Spades -> "Spades"
    typeText =
      case typeOfCard card of
        Ace -> "A"
        King -> "K"
        Queen -> "Q"
        Jack -> "J"
        Ten -> "10"
        Nine -> "9"
        Eight -> "8"
        Seven -> "7"
        Six -> "6"
        Five -> "5"
        Four -> "4"
        Three -> "3"
        Two -> "2"
  in
    typeText ++ " " ++ suitText


dateToString : Date -> String
dateToString date =
  let
    month =
      case Date.month date of
        Jan -> "Jan"
        Feb -> "Feb"
        Mar -> "Mar"
        Apr -> "Apr"
        May -> "May"
        Jun -> "Jun"
        Jul -> "Jul"
        Aug -> "Aug"
        Sep -> "Sep"
        Oct -> "Oct"
        Nov -> "Nov"
        Dec -> "Dec"
  in
    month ++ " " ++ (toString <| Date.day date)


metaDataView : Model -> Html Msg
metaDataView model =
  case model.metaData of
    Nothing -> span [] []
    Just metaData ->
      div []
        [ h4 []
            [ text "Name: "
            , text metaData.username
            ]
        , h4 []
            [ text "Last Played: "
            , text <| dateToString metaData.lastPlayedAt
            ]
        ]


mainView : Model -> Html Msg
mainView model =
  let
    blank = span [] []
    cardLabel = (\c -> label [] [text <| cardToText c])
    x =
      case model.activeAnimation of
        Nothing -> 0
        Just a -> Animation.animate model.currentTick a
    cardView =
      case model.card of
        Nothing -> blank
        Just card ->
          div [class "card"] [cardLabel card]
    previousCardView =
      case model.previousCard of
        Nothing -> blank
        Just card ->
          div [class "card", style [("left", (toString x) ++ "px")]] [cardLabel card]
    discardedViews =
      List.reverse <|
        List.map
          (\c -> div [class "card discarded"] [cardLabel c])
          model.discardedCards
  in
    div [class "container"]
      [ div [class "row card-row"] (cardView :: (discardedViews ++ [previousCardView]))
      , div [class "row"]
          [ div [class "one-third column"]
              [ button [onClick FetchNextCard ] [ text "Next Card" ]
              , metaDataView model
              ]
          ]
      ]
