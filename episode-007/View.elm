module View exposing (..)

import Animation
import Blackjack exposing (Card, CardType (..), CardSuit (..), suitOfCard, typeOfCard, bestScore, newHand, addCardToHand)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)


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
    isBlackjackView =
      case (model.card, model.previousCard) of
        (Just c1, Just c2) ->
            h3 [] [text <| "Score: " ++ (toString (bestScore (newHand |> addCardToHand c1 |> addCardToHand c2)))]
        _ -> span [] []
  in
    div [class "container"]
      [ div [class "row card-row"] (cardView :: (discardedViews ++ [previousCardView]))
      , div [class "row"]
          [ div [class "one-third column"]
              [ button [onClick FetchNextCard ] [ text "Next Card" ]
              , isBlackjackView
              ]
          ]
      ]
