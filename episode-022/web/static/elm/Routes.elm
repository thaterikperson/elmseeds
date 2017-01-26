module Routes exposing (..)

import Navigation
import UrlParser exposing (Parser, (</>), oneOf, map, s, string)


type Page
    = Home
    | About
    | Theme String


pageToPath : Page -> String
pageToPath page =
    case page of
        Home ->
            "/"

        About ->
            "/about"

        Theme color ->
            "/theme/" ++ color


pageParser : Parser (Page -> Page) Page
pageParser =
    oneOf
        [ map Home (s "")
        , map About (s "about")
        , map Theme (s "theme" </> string)
        ]


pathParser : Navigation.Location -> Maybe Page
pathParser location =
    UrlParser.parsePath pageParser location
