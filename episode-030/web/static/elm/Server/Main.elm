module Server.Main exposing (update)

import Model exposing (..)


update : MsgServer -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Save ->
            -- perform HTTP POST request
            model ! []
