module ViewHelper exposing (..)

import Blackjack exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Decode


onLinkClick : msg -> Attribute msg
onLinkClick msg =
    onWithOptions "click"
        { stopPropagation = True
        , preventDefault = True
        }
        (Decode.succeed msg)


isRedSuit : Card -> Bool
isRedSuit card =
    case suitOfCard card of
        Clubs ->
            False

        Spades ->
            False

        _ ->
            True


suitText : Card -> String
suitText card =
    case suitOfCard card of
        Clubs ->
            "C"

        Diamonds ->
            "D"

        Hearts ->
            "H"

        Spades ->
            "S"


cardTypeText : Card -> String
cardTypeText card =
    case typeOfCard card of
        Ace ->
            "A"

        King ->
            "K"

        Queen ->
            "Q"

        Jack ->
            "J"

        Ten ->
            "10"

        Nine ->
            "9"

        Eight ->
            "8"

        Seven ->
            "7"

        Six ->
            "6"

        Five ->
            "5"

        Four ->
            "4"

        Three ->
            "3"

        Two ->
            "2"
