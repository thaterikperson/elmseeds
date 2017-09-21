module Main exposing (..)

import GraphQL exposing (..)
import Html
import Model exposing (Model, Msg(..))
import View


init : ( Model, Cmd Msg )
init =
    let
        query =
            GraphQL.query "GetUser" [ Int "$id" ]
                |> node "user" [ Param "id" "$id" ] user
                |> GraphQL.toString
    in
        ( { query = query }, Cmd.none )


addressFragment : Fragment
addressFragment =
    fragment "Address" address


addressFields : Node -> Node
addressFields node =
    fields addressFragment node


user : Node -> Node
user user =
    user
        |> prop "id"
        |> prop "email"
        |> prop "name"
        |> node "address" [] addressFields


address : Node -> Node
address node =
    node
        |> prop "city"
        |> prop "state"


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , view = View.view
        , subscriptions = (\_ -> Sub.none)
        }
