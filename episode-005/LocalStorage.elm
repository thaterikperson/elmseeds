module LocalStorage exposing (getItem, setItem)

import Native.LocalStorage as Native
import Platform exposing (Task)
import Task exposing (andThen, succeed, fail)

getItem : String -> Task String String
getItem key =
  Native.getItem key

setItem : String -> String -> Task String String
setItem key value =
  Native.setItem key value
