module Core exposing (..)

import Array exposing (Array)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.App as Html
import Model exposing (..)
import LocalStorage
import Random exposing (Seed)
import String
import Task exposing (Task)


main =
  Html.program
    { init = init
    , update = update
    , view = view
    , subscriptions = (\_ -> Sub.none)
    }


type Msg
  = FetchNextCard
  | ChangeTheme
  | ChangeBgTaskFailed String
  | ChangeBgTaskSucceeded String
  | LoadBgTaskFailed String
  | LoadBgTaskSucceeded String

type alias Model = { card: Maybe Card, remainingCards: List Card, theme: String }

init : (Model, Cmd Msg)
init =
  let
    cmd = LocalStorage.getItem "bg-color"
      |> Task.perform LoadBgTaskFailed  LoadBgTaskSucceeded
  in
    initialModel ! [cmd]


initialModel : Model
initialModel =
  { card = Nothing, remainingCards = shuffledDeck 0, theme = "#eeeeee" }


view : Model -> Html Msg
view model =
  div [class "container"]
    [ div [class "row"]
        [ div [class "twelve columns"]
            [ h2 [class "card-desc", style [("color", model.theme)]] [text (toString model.card)]
            ]
        ]
    , div [class "row"]
        [ div [class "one-third column"]
            [ button
              [ onClick FetchNextCard
              , style [("backgroundColor", model.theme)]
              ]
              [text "Next Cards"]
            ]
        ]
    , div [class "row"]
        [ div [class "one-third column"]
            [ button [onClick ChangeTheme] [text "Change Color"]
            ]
          ]
    ]


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  let
    newCard = List.head model.remainingCards
    remainingCards = Maybe.withDefault [] (List.tail model.remainingCards)
  in
    case msg of
      FetchNextCard ->
        { model | card = newCard, remainingCards = remainingCards } ! []
      ChangeTheme ->
        let
          updatedModel = { model | theme = (getNextColor model.theme) }
          cmd = LocalStorage.setItem "bg-color" updatedModel.theme
            |> Task.perform ChangeBgTaskFailed ChangeBgTaskSucceeded
        in
          updatedModel ! [cmd]
      ChangeBgTaskFailed reason ->
          model ! []
      ChangeBgTaskSucceeded value ->
          model ! []
      LoadBgTaskFailed reason ->
        model ! []
      LoadBgTaskSucceeded value ->
        let
          updatedModel = { model | theme = value }
        in
          updatedModel ! []



getNextColor : String -> String
getNextColor current =
  case current of
    "#eeeeee" -> "#3498db"
    "#3498db" -> "#8e44ad"
    "#8e44ad" -> "#e74c3c"
    "#e74c3c" -> "#f1c40f"
    "#f1c40f" -> "#eeeeee"
    _ -> "#eeeeee"



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
