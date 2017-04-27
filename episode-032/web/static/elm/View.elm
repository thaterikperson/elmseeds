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
                [ h3 [] [ text "Messages" ]
                , ul [] <|
                    (model.messages
                        |> List.reverse
                        |> List.map
                            (\msg ->
                                li [] (List.intersperse (br [] []) (List.map text (String.lines msg)))
                            )
                    )
                ]
            ]
        , Html.form [ onSubmit AddMessage ]
            [ div [ class "row" ]
                [ div [ class "twelve columns" ]
                    [ textarea
                        [ on "keyup" keyCodeAndShiftDecoder
                        , placeholder "Your message…"
                        , value model.message
                        , onInput MessageUpdate
                        ]
                        []
                    ]
                ]
            , div [ class "row" ]
                [ div [ class "twelve columns" ]
                    [ button [] [ text "Send" ]
                    ]
                ]
            ]
        ]


keyCodeAndShiftDecoder : Decoder Msg
keyCodeAndShiftDecoder =
    Json.Decode.map2 KeyUp
        keyCode
        (Json.Decode.at [ "shiftKey" ] Json.Decode.bool)
