port module Detail.Main exposing (update)

import Dict
import Update.Extra as Update
import Lists.Main as Lists
import Server.Main as Server
import Model exposing (..)


port writeToLocalStorage : String -> Cmd msg


update : MsgDetail -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Show listId id ->
            model ! []

        Edit listId id name ->
            Lists.update (Create listId) model
                |> Tuple.mapFirst (updateDetail id name)
                |> Update.addCmd (writeToLocalStorage name)
                |> andThen Server.update Save


andThen : (msg -> model -> ( model, Cmd a )) -> msg -> ( model, Cmd a ) -> ( model, Cmd a )
andThen update msg ( model, cmd ) =
    let
        ( model_, cmd_ ) =
            update msg model
    in
        ( model_, Cmd.batch [ cmd, cmd_ ] )


updateDetail : String -> String -> Model -> Model
updateDetail id name model =
    let
        detail =
            model.details
                |> Dict.get id
                |> Maybe.map (\d -> { d | name = name })
                |> Maybe.withDefault (Detail id name 0)
    in
        { model | details = Dict.insert id detail model.details }
