module Model exposing (..)

import Http
import Window exposing (Size)


type Msg
    = FetchData
    | WinsFetched (Result Http.Error Int)
    | GamesFetched (Result Http.Error Int)


type alias Model =
    { wins : RemoteData Http.Error Int
    , games : RemoteData Http.Error Int
    }


initialModel : Model
initialModel =
    { wins = NotAsked
    , games = NotAsked
    }


type RemoteData e a
    = NotAsked
    | Loading
    | Failure e
    | Success a
