module Model exposing (..)

import Dict exposing (Dict)


type Msg
    = ServerMsg MsgServer
    | ListsMsg MsgLists
    | DetailMsg MsgDetail


type MsgServer
    = Save


type MsgLists
    = Create String
    | Delete String


type MsgDetail
    = Show String String
    | Edit String String String


type alias Model =
    { lists : Dict String String
    , details : Dict String Detail
    , nextId : Int
    }


type alias Detail =
    { id : String
    , name : String
    , count : Int
    }


initialModel : Model
initialModel =
    { lists = Dict.empty
    , details = Dict.empty
    , nextId = 1
    }
