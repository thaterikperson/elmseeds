module Model exposing (..)


type alias Board = List Card


type alias HoleCards = (Card, Card)


type Hand
  = StraightFlush
  | FourOfAKind
  | FullHouse
  | Flush
  | Straight
  | ThreeOfAKind
  | TwoPair
  | OnePair
  | HighCard


type Winner
  = Player1Winner
  | Player2Winner
  | NoWinner


type Card
  = InvalidCard
  | Ace CardSuit
  | King CardSuit
  | Queen CardSuit
  | Jack CardSuit
  | Ten CardSuit
  | Nine CardSuit
  | Eight CardSuit
  | Seven CardSuit
  | Six CardSuit
  | Five CardSuit
  | Four CardSuit
  | Three CardSuit
  | Two CardSuit


type CardSuit
  = Clubs
  | Diamonds
  | Hearts
  | Spades


whichHandWins : Board -> HoleCards -> HoleCards -> Winner
whichHandWins board holes1 holes2 =
  let
    hand1 = handFromCards board holes1
    hand2 = handFromCards board holes2
  in
    NoWinner


handFromCards : Board -> HoleCards -> Hand
handFromCards board holes =
  if hasStraightFlush board holes then StraightFlush
  else if hasFourOfAKind board holes then FourOfAKind
  else if hasFullHouse board holes then FullHouse
  else if hasFlush board holes then Flush
  else if hasStraight board holes then Straight
  else if hasThreeOfAKind board holes then ThreeOfAKind
  else if hasTwoPair board holes then TwoPair
  else if hasOnePair board holes then OnePair
  else HighCard


isValueEqual : Card -> Card -> Bool
isValueEqual card1 card2 =
  case (card1, card2) of
    (Ace _, Ace _) -> True
    (King _, King _) -> True
    (Queen _, Queen _) -> True
    (Jack _, Jack _) -> True
    (Ten _, Ten _) -> True
    (Nine _, Nine _) -> True
    (Eight _, Eight _) -> True
    (Seven _, Seven _) -> True
    (Six _, Six _) -> True
    (Five _, Five _) -> True
    (Four _, Four _) -> True
    (Three _, Three _) -> True
    (Two _, Two _) -> True
    (_, _) -> False


hasOnePair : Board -> HoleCards -> Bool
hasOnePair board holes =
  let
    (c1, c2) = holes
    full = board ++ [c1, c2]
    func init accum =
      if accum then
        True
      else
        let
          oneValue = List.filter (\c -> isValueEqual c init) full
        in
          (List.length oneValue) > 1
  in
    List.foldl func False full


hasTwoPair : Board -> HoleCards -> Bool
hasTwoPair board holes =
  False


hasThreeOfAKind : Board -> HoleCards -> Bool
hasThreeOfAKind board holes =
  False


hasStraight : Board -> HoleCards -> Bool
hasStraight board holes =
  False


hasFlush : Board -> HoleCards -> Bool
hasFlush board holes =
  False


hasFullHouse : Board -> HoleCards -> Bool
hasFullHouse board holes =
  False


hasFourOfAKind : Board -> HoleCards -> Bool
hasFourOfAKind board holes =
  False


hasStraightFlush : Board -> HoleCards -> Bool
hasStraightFlush board holes =
  False
