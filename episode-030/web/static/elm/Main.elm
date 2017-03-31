module Main exposing (..)

import Detail.Main as Detail
import Lists.Main as Lists
import Server.Main as Server
import Html
import Model exposing (..)
import View


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
        ServerMsg serverMsg ->
            Server.update serverMsg model

        ListsMsg listsMsg ->
            Lists.update listsMsg model

        DetailMsg detailMsg ->
            Detail.update detailMsg model
