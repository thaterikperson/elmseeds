module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import Multiselect


view : Model -> Html Msg
view model =
    div [ class "container mw6" ]
        [ h1 [] [ text "Sign Up" ]
        , div []
            [ label [ for "multiselectInputto_field" ] [ text "To:" ]
            , Html.map MultiselectMsg <| Multiselect.view model.multiselect
            ]
        , div []
            [ label [ for "message" ] [ text "Message:" ]
            , br [] []
            , textarea [ id "message", onInput MessageUpdated ] [ text model.message ]
            ]
        , div []
            [ input [ type_ "submit", value "Submit", onClick SendMessage ] []
            ]
        ]
