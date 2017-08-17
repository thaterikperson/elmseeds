module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import SortedDict as Dict


view : Model -> Html Msg
view model =
    div [ class "container mw6" ]
        [ h1 [] [ text "SortedDict" ]
        , div []
            [ text <| toString <| List.map .name <| Dict.values model.dict
            ]
        ]
