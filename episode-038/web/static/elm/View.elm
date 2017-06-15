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
                [ h3 [] [ text "Sign In" ]
                , Html.form [ onSubmit Signin ]
                    [ div []
                        [ input [ type_ "text", placeholder "Username", onInput UsernameUpdated ] []
                        ]
                    , div []
                        [ input [ type_ "password", placeholder "Password", onInput PasswordUpdated ] []
                        ]
                    , div []
                        [ button [] [ text "Sign In" ]
                        ]
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
