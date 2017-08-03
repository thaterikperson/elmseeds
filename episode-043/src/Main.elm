module Main exposing (..)

import Html
import Model exposing (Model, Msg(..))
import Multiselect
import View


main : Program Never Model Msg
main =
    Html.program
        { init = ( Model.initialModel, Cmd.none )
        , update = update
        , view = View.view
        , subscriptions =
            (\model ->
                Sub.map MultiselectMsg <| Multiselect.subscriptions model.multiselect
            )
        }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SendMessage ->
            let
                _ =
                    Debug.log "send" <| Multiselect.getSelectedValues model.multiselect
            in
                ( model, Cmd.none )

        MessageUpdated message ->
            ( { model | message = message }, Cmd.none )

        MultiselectMsg msg ->
            Multiselect.update msg model.multiselect
                |> Tuple.mapFirst (\m -> { model | multiselect = m })
                |> Tuple.mapSecond (Cmd.map MultiselectMsg)
