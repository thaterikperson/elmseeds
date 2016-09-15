module Main exposing (..)

import AnimationFrame
import Animation exposing (animation, from, to, ease)
import Blackjack as Bj
import Ease
import Html.App as Html
import Http
import Json.Decode as JD exposing (Decoder, (:=))
import Json.Decode.Extra as Extra exposing ((|:))
import Model exposing (..)
import String
import Task exposing (Task)
import Time exposing (second)
import View


main =
  Html.program
    { init = initialState
    , update = update
    , view = View.mainView
    , subscriptions = (\_ -> AnimationFrame.times CurrentTick)
    }


initialState : (Model, Cmd Msg)
initialState =
  let
    cmd =
      Http.get initialStateDecoder "data.json"
      |> Task.perform InitialStateFetchFail InitialStateFetchSucceed
  in
    initialModel ! [cmd]


initialStateDecoder : Decoder MetaData
initialStateDecoder =
  JD.map MetaData ("username" := JD.string)
    |: ("lastPlayedAt" := Extra.date)
    |: ("url" := JD.string)
    |: ("bank" := JD.float)
    |: ("lastBetSize" := JD.float)
    |: ("handsPlayed" := JD.int)
    |: ("handsWon" := JD.int)
    |: ("averageBet" := JD.float)
    |: ("favoriteCasino" := casinoDecoder)


casinoDecoder : Decoder (Maybe { name: String, zipcode: String })
casinoDecoder =
  JD.object2 (\n z -> Just { name = n, zipcode = z })
      ("name" := JD.string)
      ("zipcode" := JD.string)
    |> Extra.withDefault Nothing


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
      InitialStateFetchFail error ->
        let _ = Debug.log "InitialStateFetchFail" error
        in model ! []
      InitialStateFetchSucceed metaData ->
        let
          _ = Debug.log "meta" metaData
        in
          { model | metaData = Just metaData } ! []
