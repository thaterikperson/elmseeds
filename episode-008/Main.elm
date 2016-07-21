module Main exposing (..)

import AnimationFrame
import Animation exposing (animation, from, to, ease)
import Blackjack as Bj
import Ease
import Html.App as Html
import Model exposing (..)
import String
import Task exposing (Task)
import Time exposing (second)
import View


main =
  Html.program
    { init = (initialModel, Cmd.none)
    , update = update
    , view = View.mainView
    , subscriptions = (\_ -> AnimationFrame.times CurrentTick)
    }


type MyType
  = AType Int


update : Msg -> Model -> (Model, Cmd msg)
update msg model =
  let
    a = [1, 2, 3]
    _ =
      case a of
        [] -> 1
        h :: h' :: t -> 2
        h :: t -> 3

    b = { record = "r", number = 3, a = "" }
    { record, number } = b

    c = (1, "tuple")
    _ =
      case c of
        (x, "tuple") -> 1
        (_, "other") -> 2
        _ -> 3

    e = AType 3
    (AType x) = e


    card = model.card

    discarded =
      case model.previousCard of
        Nothing -> model.discardedCards
        Just c -> c :: model.discardedCards

    newCard =
      List.head model.remainingCards

    remainingCards =
      Maybe.withDefault [] (List.tail model.remainingCards)
  in
    case msg of
      FetchNextCard ->
        { model
        | card = newCard
        , previousCard = card
        , remainingCards = remainingCards
        , discardedCards = discarded
        , activeAnimation = Just (Animation.animation model.currentTick |> from 0 |> to 220 |> ease Ease.outQuart)
        }
        ! []
      CurrentTick time ->
        { model | currentTick = time } ! []
