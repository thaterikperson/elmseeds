module Model exposing (..)

import Animation exposing (deg)
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


type Casino
    = Unknown
    | Belagio
    | Ceasars


type alias Model =
    { card : Maybe Card
    , previousCard : Maybe Card
    , remainingCards : List Card
    , counter : Int
    , error : Maybe String
    , numberOfHands : Int
    , numberOfWins : Int
    , favoriteCasino : Casino
    , page : Page
    , isMenuOpen : Bool
    , menuStyle : Animation.State
    }


initialModel : Model
initialModel =
    { card = Nothing
    , previousCard = Nothing
    , remainingCards = shuffledDeck 0
    , counter = 0
    , error = Nothing
    , numberOfHands = 0
    , numberOfWins = 0
    , favoriteCasino = Unknown
    , page = Home
    , isMenuOpen = False
    , menuStyle =
        Animation.style
            [ Animation.top (Animation.rem -4)
            , Animation.opacity 0.0
            ]
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
