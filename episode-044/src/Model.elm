module Model exposing (..)

import SortedDict as Dict exposing (Dict)


type Msg
    = NoOp


type alias Model =
    { dict : Dict Int User
    }


type alias User =
    { id : Int, name : String, email : String }


initialModel : Model
initialModel =
    { dict =
        Dict.empty (\x y -> compare x.name y.name)
            |> Dict.insert 1 { id = 1, name = "Dwayne Johnson", email = "therock@example.com" }
            |> Dict.insert 2 { id = 2, name = "Ric Flair", email = "natureboy@example.com" }
            |> Dict.insert 3 { id = 3, name = "Apollo Crews", email = "sesugh.uhaa@example.com" }
            |> Dict.insert 4 { id = 4, name = "Brock Lesnar", email = "brock@example.com" }
            |> Dict.insert 5 { id = 5, name = "John Cena", email = "cena@example.com" }
            |> Dict.insert 6 { id = 6, name = "Randy Orton", email = "ro@example.com" }
            |> Dict.insert 7 { id = 7, name = "Dolph Ziggler", email = "dziggler@example.com" }
            |> Dict.insert 8 { id = 8, name = "Mojo Rawley", email = "moj@example.com" }
    }
