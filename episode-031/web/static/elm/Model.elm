module Model exposing (..)

import Array exposing (Array)
import Blackjack exposing (Card)
import Dict exposing (Dict)
import Random exposing (Seed)


type Msg
    = NoOp


type alias Model =
    {}


initialModel : Model
initialModel =
    {}


deckOfCards : List Card
deckOfCards =
    List.foldl
        (\suit cards ->
            List.foldl
                (\type_ cards ->
                    (Blackjack.deserializeCard type_ suit) :: cards
                )
                cards
                [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 ]
        )
        []
        [ 0, 1, 2, 3 ]


naiveShuffledDeck : Int -> List Card
naiveShuffledDeck time =
    Random.initialSeed time
        |> naiveShuffle deckOfCards 0


naiveShuffle : List Card -> Int -> Seed -> List Card
naiveShuffle unshuffled i seed =
    if i > ((List.length unshuffled) - 1) then
        unshuffled
    else
        let
            generator =
                Random.int 0 ((List.length unshuffled) - 1)

            ( j, nextSeed ) =
                Random.step generator seed

            minIndex =
                min i j

            maxIndex =
                max i j

            leftPart =
                List.take minIndex unshuffled

            middleAndRightParts =
                List.drop minIndex unshuffled

            maybeAtI =
                List.head middleAndRightParts

            middlePart =
                middleAndRightParts
                    |> List.drop 1
                    |> List.take (maxIndex - minIndex - 1)

            ( maybeAtJ, rightPart ) =
                case List.drop (maxIndex - minIndex) middleAndRightParts of
                    atJ :: rest ->
                        ( Just atJ, rest )

                    _ ->
                        ( Nothing, [] )

            shuffled =
                Maybe.map2
                    (\atI atJ -> leftPart ++ (atJ :: middlePart) ++ (atI :: rightPart))
                    maybeAtI
                    maybeAtJ
                    |> Maybe.withDefault unshuffled
        in
            naiveShuffle shuffled (i + 1) nextSeed


shuffledDeck : Int -> List Card
shuffledDeck time =
    let
        fullDeck =
            Array.fromList deckOfCards

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
            Maybe.map2
                (\atI atIJ -> Array.set i atIJ unshuffled |> Array.set (i + j) atI)
                mAtI
                mAtIJ
                |> Maybe.withDefault unshuffled
    in
        if i > (Array.length shuffled) - 2 then
            shuffled
        else
            shuffle shuffled (i + 1) nextSeed
