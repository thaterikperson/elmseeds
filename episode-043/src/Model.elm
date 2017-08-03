module Model exposing (..)

import Multiselect


type Msg
    = SendMessage
    | MessageUpdated String
    | MultiselectMsg Multiselect.Msg


type alias Model =
    { message : String
    , multiselect : Multiselect.Model
    }


initialModel : Model
initialModel =
    { message = ""
    , multiselect =
        Multiselect.initModel
            (List.map (\u -> ( (toString u.id), userToContact u )) users)
            "to_field"
    }


userToContact : { id : Int, name : String, email : String } -> String
userToContact user =
    user.name ++ " (" ++ user.email ++ ")"


users =
    [ { id = 1, name = "Dwayne Johnson", email = "therock@example.com" }
    , { id = 2, name = "Ric Flair", email = "natureboy@example.com" }
    , { id = 3, name = "Apollo Crews", email = "sesugh.uhaa@example.com" }
    , { id = 4, name = "Brock Lesnar", email = "brock@example.com" }
    , { id = 5, name = "John Cena", email = "cena@example.com" }
    , { id = 6, name = "Randy Orton", email = "ro@example.com" }
    , { id = 7, name = "Dolph Ziggler", email = "dziggler@example.com" }
    , { id = 8, name = "Mojo Rawley", email = "moj@example.com" }
    , { id = 9, name = "Hunter Hearst Helmsley", email = "tripleh@example.com" }
    , { id = 10, name = "Hulk Hogan", email = "hh@example.com" }
    ]
