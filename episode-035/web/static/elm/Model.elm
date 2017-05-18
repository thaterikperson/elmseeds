module Model exposing (..)

import Geolocation exposing (Location)


type Msg
    = FetchLocation
    | LocationUpdated (Result Geolocation.Error Location)


type alias Model =
    { location : Maybe Location
    }


initialModel : Model
initialModel =
    { location = Nothing
    }
