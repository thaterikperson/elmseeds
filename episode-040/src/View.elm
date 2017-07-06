module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)


mainView : Model -> Html Msg
mainView model =
    div [ class "main container" ]
        [ div [ class "row" ]
            [ div [ class "twelve columns" ]
                [ h1 [] [ text ("Running via Webpack" ++ (String.join "" (List.repeat model.count "!"))) ]
                , Html.form [ onSubmit Signin ]
                    [ div []
                        [ button [] [ text "Click me@" ]
                        ]
                    ]
                ]
            ]
        ]
