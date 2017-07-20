module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import Validate


validate : Model -> List String
validate model =
    Validate.all
        [ .password >> Validate.ifBlank "Password cannot be blank"
        , .email >> Validate.ifInvalidEmail "Email address is invalid"
        , .password >> isLengthLessThan 8 "Password must be 8+ characters"
        ]
        model


isLengthLessThan : Int -> error -> Validate.Validator error String
isLengthLessThan minLength err =
    Validate.ifInvalid
        (\string ->
            (String.length string) < minLength
        )
        err


view : Model -> Html Msg
view model =
    let
        errorDivs =
            model
                |> validate
                |> List.map
                    (\error ->
                        div [ class "black bg-light-red pa2 mt2 w-50" ]
                            [ text error ]
                    )
    in
        div [ class "main container" ]
            [ div [ class "row" ]
                [ div [ class "twelve columns" ]
                    [ h1 [] [ text "Sign Up" ]
                    , Html.form [ onSubmit Signin ]
                        ([ div [ class "mb2" ]
                            [ input [ class "f3 w-50", type_ "text", onInput EmailUpdated, placeholder "Email" ] []
                            ]
                         , div [ class "mb2" ]
                            [ input [ class "f3 w-50", type_ "password", onInput PasswordUpdated, placeholder "Password" ] []
                            ]
                         , div [ class "mb2" ]
                            [ input [ class "f3 w-50", type_ "text", onInput AgeUpdated, placeholder "Age" ] []
                            ]
                         , div []
                            [ button [ class "mb3 f4" ] [ text "Submit" ]
                            ]
                         ]
                            ++ errorDivs
                        )
                    ]
                ]
            ]
