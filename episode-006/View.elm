module View exposing (..)

import Animation
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)


cardToText : Card -> String
cardToText card =
  case card of
    Ace suit -> "A " ++ (suitToText suit)
    King suit -> "K " ++ (suitToText suit)
    Queen suit -> "Q " ++ (suitToText suit)
    Jack suit -> "J " ++ (suitToText suit)
    Ten suit -> "10 " ++ (suitToText suit)
    Nine suit -> "9 " ++ (suitToText suit)
    Eight suit -> "8 " ++ (suitToText suit)
    Seven suit -> "7 " ++ (suitToText suit)
    Six suit -> "6 " ++ (suitToText suit)
    Five suit -> "5 " ++ (suitToText suit)
    Four suit -> "4 " ++ (suitToText suit)
    Three suit -> "3 " ++ (suitToText suit)
    Two suit -> "2 " ++ (suitToText suit)
    _ -> ""


suitToText : CardSuit -> String
suitToText suit =
  case suit of
    Clubs -> "Clubs"
    Diamonds -> "Diamonds"
    Hearts -> "Hearts"
    Spades -> "Spades"


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
              [ button [onClick FetchNextCard ] [ text "Next Card" ] ]
          ]
      ]
