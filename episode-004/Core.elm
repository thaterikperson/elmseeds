port module Core exposing (..)

import Array exposing (Array)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.App as Html
import Model exposing (..)
import Random exposing (Seed)
import String
import Task exposing (Task)


main =
  Html.program
    { init = (initialModel, Cmd.none)
    , update = update
    , view = view
    , subscriptions = (\_ -> dealOne DealOneCard)
    }

port dealOne : (Bool -> msg) -> Sub msg


port sendToJs : Int -> Cmd msg


type Msg
  = FetchNextCard
  | DealOneCard Bool


type alias Model = { card: Maybe Card, remainingCards: List Card }


initialModel : Model
initialModel =
  { card = Nothing, remainingCards = shuffledDeck 0 }


view : Model -> Html Msg
view model =
  div [class "container"]
    [ div [class "row"]
        [ div [class "twelve columns"]
            [ h2 [class "card-desc"] [text (toString model.card)]
            ]
        ]
    , div [class "row"]
        [ div [class "one-third column"]
            [ button [onClick FetchNextCard ] [ text "Next Card" ] ]
        ]
    ]


update : Msg -> Model -> (Model, Cmd msg)
update msg model =
  let
    newCard = List.head model.remainingCards
    remainingCards = Maybe.withDefault [] (List.tail model.remainingCards)
  in
    case msg of
      FetchNextCard ->
        ( { model | card = newCard, remainingCards = remainingCards }
        , sendToJs <| List.length remainingCards )
      DealOneCard _ ->
        ( { model | card = newCard, remainingCards = remainingCards }, Cmd.none )


shuffledDeck : Int -> List Card
shuffledDeck time =
  let
    suits = [Clubs, Diamonds, Hearts, Spades]
    cardsWithSuit s =
      List.map (\c -> c s)
        [Ace, King, Queen, Jack, Ten, Nine, Eight, Seven, Six, Five, Four, Three, Two]
    fullDeck = Array.fromList (List.concatMap cardsWithSuit suits)
    seed = Random.initialSeed time
  in
    Array.toList (shuffle fullDeck 0 seed)


shuffle : Array Card -> Int -> Seed -> Array Card
shuffle unshuffled i seed =
  let
    g = Random.int 0 ((Array.length unshuffled) - i - 1)
    (j, nextSeed) = Random.step g seed
    atI = Maybe.withDefault InvalidCard (Array.get i unshuffled)
    atIJ = Maybe.withDefault InvalidCard (Array.get (i + j) unshuffled)
    shuffled = Array.set i atIJ unshuffled |> Array.set (i + j) atI
  in
    if i > (Array.length shuffled) - 2 then
      shuffled
    else
      shuffle shuffled (i + 1) nextSeed
