module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import ViewHelper exposing (..)


homeView : Model -> Html Msg
homeView model =
    div [ class "main container" ]
        [ div [ class "row" ]
            [ div [ class "six columns" ]
                [ pre [] [ text <| "\"" ++ model.rawPersonString ++ "\"" ] ]
            , div [ class "six columns" ]
                [ pre [] [ text <| pp <| toString model.person ] ]
            ]
        ]


mainView : Model -> Html Msg
mainView model =
    div []
        [ homeView model
        ]


pp : String -> String
pp input =
    input
        |> String.split ","
        |> String.join "\n,"
