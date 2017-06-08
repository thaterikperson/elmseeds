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
                [ h3 [] [ text "Stats" ]
                , div [ class "row loading" ]
                    [ div [ class "six columns" ]
                        [ h2 [] [ text "Wins" ]
                        , (case model.wins of
                            NotAsked ->
                                text ""

                            Loading ->
                                div [ class "throbber" ] []

                            Failure e ->
                                div [ class "error" ] [ text "error" ]

                            Success wins ->
                                h4 [] [ text <| toString wins ]
                          )
                        ]
                    , div [ class "six columns" ]
                        [ h2 [] [ text "Games" ]
                        , (case model.games of
                            NotAsked ->
                                text ""

                            Loading ->
                                div [ class "throbber" ] []

                            Failure e ->
                                div [ class "error" ] [ text "error" ]

                            Success games ->
                                h4 [] [ text <| toString games ]
                          )
                        ]
                    ]
                , div []
                    [ button [ onClick FetchData ] [ text "Fetch Wins & Games" ]
                    ]
                ]
            ]
        ]


loadingOr : Bool -> Html Msg -> Html Msg
loadingOr isLoading html =
    if isLoading then
        div [ class "throbber" ] []
    else
        html
