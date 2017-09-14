module Main exposing (..)

import GraphQL exposing (..)
import GraphQLDebug
import Html
import Model exposing (Model, Msg(..))
import View


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , view = View.view
        , subscriptions = (\_ -> Sub.none)
        }


init : ( Model, Cmd Msg )
init =
    let
        query =
            GraphQL.query "GetUser" [ Int "$id" ]
                |> node "user"
                    [ Param "id" "$id" ]
                    (\user ->
                        user
                            |> prop "id"
                            |> prop "email"
                            |> prop "name"
                            |> node "address"
                                []
                                (\address ->
                                    address
                                        |> prop "city"
                                        |> prop "state"
                                )
                    )

        _ =
            Debug.log "query" <| GraphQLDebug.toString query
    in
        ( {}, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )
