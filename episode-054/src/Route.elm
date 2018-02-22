module Route exposing (Route(..), route)

import UrlParser exposing (Parser, map, oneOf, top, s)


type Route
    = Home
    | Newest


route : Parser (Route -> Route) Route
route =
    oneOf
        [ map Home top
        , map Newest (s "newest")
        ]
