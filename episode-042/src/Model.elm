module Model exposing (..)


type Msg
    = Signin
    | EmailUpdated String
    | PasswordUpdated String
    | AgeUpdated String


type alias Model =
    { email : String
    , password : String
    , age : String
    }


initialModel : Model
initialModel =
    { email = ""
    , password = ""
    , age = ""
    }
