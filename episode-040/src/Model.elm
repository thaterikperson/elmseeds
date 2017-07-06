module Model exposing (..)


type Msg
    = Signin


type alias Model =
    { count : Int
    }


initialModel : Model
initialModel =
    { count = 0
    }
