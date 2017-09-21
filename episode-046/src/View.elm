module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)


view : Model -> Html Msg
view model =
    div [ class "container mw6" ]
        [ h1 [] [ text "GraphQL" ]
        , pre [] [ code [] [ text model.query ] ]
        ]
