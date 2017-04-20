module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (..)


mainView : Model -> Html Msg
mainView model =
    div [ class "main container" ]
        [ div [ class "row" ]
            [ div [ class "twelve columns" ]
                [ text ""
                ]
            ]
        ]
