module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Process
import Task
import Time exposing (Time)


type Msg
    = Signin
    | EmailUpdated String
    | PasswordUpdated String
    | Timeout Int


type Input
    = NotStarted
    | Valid
    | Invalid String


type alias Model =
    { email : String
    , password : String
    , passwordInput : Input
    , debouncer : Debouncer String Input
    }


main : Program Never Model Msg
main =
    Html.program
        { init = ( initialModel, Cmd.none )
        , update = update
        , view = mainView
        , subscriptions = (\_ -> Sub.none)
        }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Signin ->
            ( model, Cmd.none )

        EmailUpdated email ->
            ( { model | email = email }, Cmd.none )

        PasswordUpdated password ->
            let
                ( debouncer, cmd ) =
                    call password model.debouncer
            in
                ( { model | password = password, debouncer = debouncer }
                , cmd
                )

        Timeout tag ->
            let
                input =
                    if tag == model.debouncer.tag then
                        model.debouncer.function (Debug.log "param" model.debouncer.parameter)
                    else
                        model.passwordInput
            in
                ( { model | passwordInput = input }, Cmd.none )


call : a -> Debouncer a b -> ( Debouncer a b, Cmd Msg )
call parameter debouncer =
    ( { debouncer | parameter = parameter, tag = debouncer.tag + 1 }
    , Process.sleep debouncer.timeout
        |> Task.perform (\_ -> (Timeout (debouncer.tag + 1)))
    )


type alias Debouncer a b =
    { function : a -> b
    , parameter : a
    , timeout : Time
    , tag : Int
    }


initialModel : Model
initialModel =
    { email = ""
    , password = ""
    , passwordInput = NotStarted
    , debouncer =
        { function = validate
        , parameter = ""
        , timeout = Time.second
        , tag = 0
        }
    }


validate : String -> Input
validate password =
    -- Or some other very expensive function
    if (String.length password) < 5 then
        Invalid "Password is too short"
    else if (String.contains "a" password) then
        Invalid "Password cannot contain letter 'a'"
    else
        Valid


mainView : Model -> Html Msg
mainView model =
    div [ class "main container" ]
        [ div [ class "row" ]
            [ div [ class "twelve columns" ]
                [ h1 [] [ text "Sign Up" ]
                , Html.form [ onSubmit Signin ]
                    [ div [ class "mb2" ]
                        [ input [ class "f3", type_ "text", onInput EmailUpdated, placeholder "Email" ] []
                        ]
                    , div [ class "mb2" ]
                        [ input [ class "f3", type_ "password", onInput PasswordUpdated, placeholder "Password" ] []
                        , (case model.passwordInput of
                            Invalid message ->
                                div [ class "dark-red" ]
                                    [ text message
                                    ]

                            _ ->
                                text ""
                          )
                        ]
                    , div []
                        [ button [] [ text "Submit" ]
                        ]
                    ]
                ]
            ]
        ]
