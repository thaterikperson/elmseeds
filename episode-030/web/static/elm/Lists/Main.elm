module Lists.Main exposing (update)

import Dict
import Model exposing (..)


update : MsgLists -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Create name ->
            let
                list =
                    model.lists
                        |> Dict.values
                        |> List.filter (\n -> n == name)
                        |> List.head
            in
                case list of
                    Nothing ->
                        { model
                            | lists = Dict.insert (toString model.nextId) name model.lists
                            , nextId = model.nextId + 1
                        }
                            ! []

                    Just _ ->
                        model ! []

        Delete id ->
            { model | lists = Dict.remove id model.lists } ! []
