import ElmTest exposing (..)
import Graphics.Element as El exposing (Element)
import Model exposing (..)

board0 = [Ace Diamonds, King Diamonds, Jack Hearts, Ten Hearts, Nine Clubs]
board1 = [King Diamonds, King Clubs, Jack Hearts, Ten Hearts, Nine Clubs]

hand0 = (Ace Clubs, Five Hearts)
hand1 = (Two Spades, Two Clubs)

hasOnePairTests : Test
hasOnePairTests =
  suite "One Pair"
    [ test "One pair on the board" <| assert <| hasOnePair board1 hand0
    , test "One pair in hand" <| assert <| hasOnePair board0 hand1
    , test "One pair between" <| assert <| hasOnePair board0 hand0
    ]

hasTwoPairTests : Test
hasTwoPairTests =
  suite "Two Pair"
    [ test "Two pair on board" <| fail "not implemented"
    , test "One pair on board" <| fail "not implemented"
    ]

allTests : Test
allTests =
  suite "All"
    [ hasOnePairTests
    , hasTwoPairTests
    ]

main : Element
main =
  elementRunner allTests
