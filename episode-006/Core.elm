module Core exposing (..)

import AnimationFrame
import Animation exposing (animation, from, to, ease)
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


update : Msg -> Model -> (Model, Cmd msg)
update msg model =
  let
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
