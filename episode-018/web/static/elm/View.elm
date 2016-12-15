module View exposing (..)

import Animation
import Blackjack exposing (Card, CardType(..), CardSuit(..), suitOfCard, typeOfCard, bestScore, newHand, addCardToHand)
import Date exposing (Date, Month(..))
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Json
import Model exposing (..)
import Routes exposing (Page(..))


mainView : Model -> Html Msg
mainView model =
    div [ class "container " ]
        [ div [ class "row" ]
            [ div [ class "one-third column" ]
                [ button [ onClick DealHand ] [ text "Deal" ]
                ]
            ]
        ]
