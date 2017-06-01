module Model exposing (..)

import Window exposing (Size)


type Msg
    = SizeUpdated Size


type alias Model =
    { windowSize : Size
    }


initialModel : Model
initialModel =
    { windowSize = Size 0 0
    }
