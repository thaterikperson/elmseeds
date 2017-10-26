module Styles exposing (Classes(..), css)

import Css
import Css.Colors as Colors
import Css.Elements exposing (..)
import Css.Namespace


type Classes
    = GreenBg
    | White
    | Yellow


css : Css.Stylesheet
css =
    Css.stylesheet <|
        Css.Namespace.namespace "main"
            [ Css.class GreenBg
                [ Css.height (Css.px 300), Css.backgroundColor (Css.rgb 51 153 51) ]
            , Css.class White
                [ Css.color Colors.white ]
            , Css.class Yellow
                [ Css.color (Css.rgb 244 208 107) ]
            ]
