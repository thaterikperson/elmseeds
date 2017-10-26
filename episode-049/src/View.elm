module View exposing (view)

import Css
import Html exposing (Html, div, span, a, text)
import Html.Attributes exposing (href)
import Html.CssHelpers
import Model exposing (..)
import Styles exposing (..)


{ id, class, classList } =
    Html.CssHelpers.withNamespace "main"


view : Model -> Html msg
view model =
    Html.header [ class [ GreenBg ] ]
        [ div []
            [ a [ href "/" ]
                [ span [] [ text "Elm" ]
                , span [] [ text "seeds" ]
                ]
            ]
        ]
