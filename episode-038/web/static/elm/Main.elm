module Main exposing (..)

import Http
import HttpBuilder
import Html
import Json.Decode as Decode
import Json.Encode as Encode
import Model exposing (..)
import Task
import View
import Window


main : Program Never Model Msg
main =
    Html.program
        { init = ( initialModel, Cmd.none )
        , update = update
        , view = View.mainView
        , subscriptions = (\_ -> Sub.none)
        }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Signin ->
            let
                jsonBody =
                    Encode.object
                        [ ( "username", Encode.string model.username )
                        , ( "password", Encode.string model.password )
                        ]

                builderCmd =
                    HttpBuilder.post "http://localhost:4000/signin"
                        |> HttpBuilder.withHeader "X-CSRF-TOKEN" model.token
                        |> HttpBuilder.withJsonBody jsonBody
                        |> HttpBuilder.withQueryParams [ ( "timestamp", (toString model.timestamp) ) ]
                        |> HttpBuilder.withExpect (Http.expectJson Decode.int)
                        |> HttpBuilder.send SigninCompleted

                saveCmd =
                    Http.request
                        { method = "POST"
                        , headers = [ Http.header "X-CSRF-TOKEN" model.token ]
                        , url = "http://localhost:4000/signin?timestamp=" ++ (toString model.timestamp)
                        , body = Http.jsonBody jsonBody
                        , expect = Http.expectJson Decode.int
                        , timeout = Nothing
                        , withCredentials = False
                        }
                        |> Http.send SigninCompleted
            in
                model ! [ saveCmd, builderCmd ]

        SigninCompleted (Ok data) ->
            model ! []

        SigninCompleted (Err error) ->
            model ! []

        UsernameUpdated username ->
            { model | username = username } ! []

        PasswordUpdated password ->
            { model | password = password } ! []
