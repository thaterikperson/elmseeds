module Model exposing (..)

import Http
import Window exposing (Size)


type Msg
    = Signin
    | SigninCompleted (Result Http.Error Int)
    | UsernameUpdated String
    | PasswordUpdated String


type alias Model =
    { token : String
    , username : String
    , password : String
    , timestamp : Int
    }


initialModel : Model
initialModel =
    { token = "4d643d8a-2986-4c5f-8ad1-8739c1de16b1"
    , username = ""
    , password = ""
    , timestamp = 33795112
    }
