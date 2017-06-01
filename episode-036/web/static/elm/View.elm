module View exposing (..)

import Array
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode exposing (Decoder)
import Model exposing (..)


mainView : Model -> Html Msg
mainView model =
    div [ class "main container" ]
        [ div [ class "row" ]
            [ div [ class "twelve columns" ]
                [ h3 [] [ text "Window Size" ]
                , div []
                    [ label [] [ text "Width:" ]
                    , text (toString model.windowSize.width)
                    , label [] [ text "Height:" ]
                    , text (toString model.windowSize.height)
                    ]
                ]
            ]
        ]
