module Model exposing (..)

import Array exposing (Array)
import Blackjack exposing (..)
import Date exposing (Date)
import Json.Decode
import Http exposing (Request)
import Http.Progress exposing (Progress)
import Navigation exposing (Location)
import Random exposing (Seed)


type Msg
    = ToggleMenu
    | PersonRequestCompleted (Result Http.Error String)


type alias Person =
    { username : String
    , url : String
    , bank : Float
    , lastBetSize : Float
    , handsPlayed : Int
    , handsWon : Int
    , averageBet : Float
    , lastPlayedAt :
        String
    , favoriteCasino : String
    }


type alias Model =
    { hand : List Card
    , remainingCards : List Card
    , numberOfHands : Int
    , numberOfWins : Int
    , isMenuOpen : Bool
    , dealerHand : List Card
    , rawPersonString : String
    , person : Maybe Person
    }


initialModel : Model
initialModel =
    { hand = []
    , remainingCards = shuffledDeck 0
    , numberOfHands = 0
    , numberOfWins = 0
    , isMenuOpen = False
    , dealerHand = []
    , rawPersonString = ""
    , person = Nothing
    }


shuffledDeck : Int -> List Card
shuffledDeck time =
    let
        suits =
            [ Clubs, Diamonds, Hearts, Spades ]

        types =
            [ Ace, King, Queen, Jack, Ten, Nine, Eight, Seven, Six, Five, Four, Three, Two ]

        cardsWithSuits =
            List.concatMap (\type_ -> List.map (newCard type_) suits) types

        fullDeck =
            Array.fromList cardsWithSuits

        seed =
            Random.initialSeed time
    in
        Array.toList (shuffle fullDeck 0 seed)


shuffle : Array Card -> Int -> Seed -> Array Card
shuffle unshuffled i seed =
    let
        g =
            Random.int 0 ((Array.length unshuffled) - i - 1)

        ( j, nextSeed ) =
            Random.step g seed

        mAtI =
            Array.get i unshuffled

        mAtIJ =
            Array.get (i + j) unshuffled

        shuffled =
            case ( mAtI, mAtIJ ) of
                ( Just atI, Just atIJ ) ->
                    Array.set i atIJ unshuffled |> Array.set (i + j) atI

                _ ->
                    unshuffled
    in
        if i > (Array.length shuffled) - 2 then
            shuffled
        else
            shuffle shuffled (i + 1) nextSeed
