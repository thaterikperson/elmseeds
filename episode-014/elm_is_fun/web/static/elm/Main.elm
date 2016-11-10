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
import Task exposing (Task, andThen, mapError)
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
  initialModel ! []


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  let
    (leftCard, rightCard, remainingCards) =
      case model.remainingCards of
        h :: h' :: t -> (Just h, Just h', t)
        _ -> (Nothing, Nothing, [])
  in
    case msg of
      DealHand ->
        let
          updated =
            { model
            | card = rightCard
            , previousCard = leftCard
            , counter = model.counter + 1
            , error = Nothing
            , remainingCards = remainingCards
            , activeAnimation = Just (Animation.animation model.currentTick |> from 0 |> to 220 |> ease Ease.outQuart)
            }
          localTask =
            locallyStore updated
              |> mapError LocallyStoreError
          remoteTask value =
            remotelyStore value model
              |> mapError (RemotelyStoreError << httpErrorToString)
          cmd =
            localTask `andThen` remoteTask
              |> Task.perform StorageFail StorageSucceed
        in
          updated ! [cmd]
      CurrentTick time ->
        { model | currentTick = time } ! []
      StorageFail error ->
        let
          updated = updateModelFromErrorType error model
        in
          updated ! []
      StorageSucceed value ->
        model ! []


locallyStore : Model -> Task String Int
locallyStore model =
  Model.locallyStore model


remotelyStore : Int -> Model -> Task Http.Error Bool
remotelyStore counter model =
  Model.remotelyStore counter model


httpErrorToString : Http.Error -> String
httpErrorToString error =
  case error of
    Http.Timeout -> "Timeout"
    Http.NetworkError -> "Network error"
    Http.UnexpectedPayload string -> string
    Http.BadResponse _ string -> string
