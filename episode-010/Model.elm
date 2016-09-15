module Model exposing (..)

import Animation exposing (Animation)
import Array exposing (Array)
import Blackjack exposing (Card, CardSuit (..), CardType (..), newCard)
import Date exposing (Date)
import Http
import Random exposing (Seed)
import Time exposing (Time)

type Msg
  = FetchNextCard
  | CurrentTick Time
  | InitialStateFetchFail Http.Error
  | InitialStateFetchSucceed MetaData


type alias MetaData =
  { username: String
  , lastPlayedAt: Date
  , url: String
  , bank: Float
  , lastBetSize: Float
  , handPlayed: Int
  , handsWon: Int
  , averageBet: Float
  , favoriteCasino: Maybe { name: String, zipcode: String }
  }


type alias Model =
  { card: Maybe Card
  , previousCard: Maybe Card
  , remainingCards: List Card
  , discardedCards: List Card
  , currentTick: Time
  , activeAnimation: Maybe Animation
  , metaData: Maybe MetaData
  }


initialModel : Model
initialModel =
  { card = Nothing
  , previousCard = Nothing
  , remainingCards = shuffledDeck 0
  , discardedCards = []
  , currentTick = 0
  , activeAnimation = Nothing
  , metaData = Nothing
  }


shuffledDeck : Int -> List Card
shuffledDeck time =
  let
    suits = [Clubs, Diamonds, Hearts, Spades]
    types = [Ace, King, Queen, Jack, Ten, Nine, Eight, Seven, Six, Five, Four, Three, Two]
    cardsWithSuits = List.concatMap (\type' -> List.map (newCard type') suits) types
    fullDeck = Array.fromList cardsWithSuits
    seed = Random.initialSeed time
  in
    Array.toList (shuffle fullDeck 0 seed)


shuffle : Array Card -> Int -> Seed -> Array Card
shuffle unshuffled i seed =
  let
    g = Random.int 0 ((Array.length unshuffled) - i - 1)
    (j, nextSeed) = Random.step g seed
    mAtI = Array.get i unshuffled
    mAtIJ = Array.get (i + j) unshuffled
    shuffled =
      case (mAtI, mAtIJ) of
        (Just atI, Just atIJ) ->
          Array.set i atIJ unshuffled |> Array.set (i + j) atI
        _ -> unshuffled
  in
    if i > (Array.length shuffled) - 2 then
      shuffled
    else
      shuffle shuffled (i + 1) nextSeed
