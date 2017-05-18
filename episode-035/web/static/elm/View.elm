module View exposing (..)

import Array
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode exposing (Decoder)
import Model exposing (..)


mainView : Model -> Html Msg
mainView model =
    let
        locationDiv =
            case model.location of
                Nothing ->
                    text ""

                Just loc ->
                    div [ class "location" ]
                        [ p []
                            [ label [] [ text "Latitude" ]
                            , text (toString loc.latitude)
                            ]
                        , p []
                            [ label [] [ text "Longitude" ]
                            , text (toString loc.longitude)
                            ]
                        ]
    in
        div [ class "main container" ]
            [ div [ class "row" ]
                [ div [ class "twelve columns" ]
                    [ h3 [] [ text "Find My Location" ]
                    , button [ onClick FetchLocation ] [ text "Get It" ]
                    , locationDiv
                    ]
                ]
            ]
