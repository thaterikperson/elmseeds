module Model exposing (..)

import Array exposing (Array)
import Dict exposing (Dict)
import Random exposing (Seed)


type Msg
    = NoOp
    | AddMessage
    | MessageUpdate String
    | KeyUp Int Bool


type alias Model =
    { messages : List String
    , message : String
    }


initialModel : Model
initialModel =
    { messages = []
    , message = ""
    }
