module Model exposing (..)

import Animation exposing (deg)
import Animation.Messenger exposing (State)
import Array exposing (Array)
import Blackjack exposing (Card, CardSuit(..), CardType(..), newCard)
import Navigation exposing (Location)
import Random exposing (Seed)
import Routes exposing (Page(..))


type Msg
    = DealHand
    | UrlChange Location
    | NavigateTo Page
    | ToggleMenu
    | Animate Animation.Msg
    | FirstCardDealt


type alias CardStyle =
    { front : State Msg
    , back : State Msg
    }


type alias Model =
    { hand : List Card
    , remainingCards : List Card
    , numberOfHands : Int
    , numberOfWins : Int
    , page : Page
    , isMenuOpen : Bool
    , menuStyle : State Msg
    , cardStyles : List CardStyle
    , dealerHand : List Card
    , dealerCardStyles : List CardStyle
    }


initialCardStyle =
    { front =
        Animation.style
            [ Animation.rotate3d (deg 0) (deg 180) (deg 0)
            , Animation.left (Animation.rem 0)
            , Animation.top (Animation.rem 0)
            ]
    , back =
        Animation.style
            [ Animation.rotate3d (deg 0) (deg 0) (deg 0)
            , Animation.left (Animation.rem 0)
            , Animation.top (Animation.rem 0)
            ]
    }


initialModel : Model
initialModel =
    { hand = []
    , remainingCards = shuffledDeck 0
    , numberOfHands = 0
    , numberOfWins = 0
    , page = Home
    , isMenuOpen = False
    , menuStyle =
        Animation.style
            [ Animation.top (Animation.rem -4)
            , Animation.opacity 0.0
            ]
    , cardStyles = []
    , dealerHand = []
    , dealerCardStyles = []
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
