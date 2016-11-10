---
layout: post
title:  "Advanced Tasks"
date:   2016-11-10 14:55:00 -0500
categories:
label: ep-014
tiny_description: Combine and manipulate tasks with these advanced functions.
---

Elm's [Task](http://package.elm-lang.org/packages/elm-lang/core/4.0.5/Task) library gives you lots of options to combine `Task`s of different types, execute them in a specific order, and change their result and error types. Mastering this library makes `Task`s a pleasure to use.

### Examples

```elm
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    DealHand ->
      let
        localTask =
          locallyStore updated
            |> Task.mapError LocallyStoreError
        remoteTask value =
          remotelyStore value model
            |> Task.mapError (RemotelyStoreError << httpErrorToString)
        cmd =
          localTask `andThen` remoteTask
            |> Task.perform StorageFail StorageSucceed
      in
        model ! [cmd]
    StorageFail error ->
      let
        updated = updateModelFromErrorType error model
      in
        updated ! []
    StorageSucceed value->
      model ! []
```
