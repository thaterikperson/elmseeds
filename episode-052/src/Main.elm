module Main exposing (main)

import Html exposing (Html, h1, text)


type Msg
    = NoOp


type alias Model =
    {}


main : Program Never Model Msg
main =
    Html.program
        { init = ( {}, Cmd.none )
        , update = update
        , view = view
        , subscriptions = (\_ -> Sub.none)
        }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


view : Model -> Html Msg
view model =
    h1 [] [ text "👩\x200D💻 Newsss" ]
