module Model exposing (..)

import SelectList exposing (SelectList)


type Msg
    = SelectTab Int


type alias Model =
    { tabs : SelectList User
    }


type alias User =
    { id : Int, name : String, email : String }


initialModel : Model
initialModel =
    { tabs =
        SelectList.fromLists []
            { id = 1, name = "Dwayne Johnson", email = "therock@example.com" }
            [ { id = 2, name = "Ric Flair", email = "natureboy@example.com" }
            , { id = 3, name = "Apollo Crews", email = "sesugh.uhaa@example.com" }
            , { id = 4, name = "Brock Lesnar", email = "brock@example.com" }
            , { id = 5, name = "John Cena", email = "cena@example.com" }
            , { id = 6, name = "Randy Orton", email = "ro@example.com" }
            , { id = 7, name = "Dolph Ziggler", email = "dziggler@example.com" }
            , { id = 8, name = "Mojo Rawley", email = "moj@example.com" }
            ]
    }
