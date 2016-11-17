---
layout: post
title:  "Upgrade to Elm 0.18"
date:   2016-11-17 15:52:00 -0400
categories:
label: ep-015
tiny_description: Upgrade your project from Elm 0.17 to Elm 0.18.
---

Elm 0.18 is out and provides a [Migration Guide](https://github.com/elm-lang/elm-platform/blob/master/upgrade-docs/0.18.md) to help get you started. There are many changes to the API, especially in the [Task](http://package.elm-lang.org/packages/elm-lang/core/5.0.0/Task) module and the new [elm-lang/http](http://package.elm-lang.org/packages/elm-lang/http/latest) library (formerly the [evancz/elm-http](http://package.elm-lang.org/packages/evancz/elm-http/latest) library). Follow along this week as we upgrade an existing Elm 0.17 project to Elm 0.18.

### Examples

```sh
$ npm install -g elm-upgrade
$ npm install -g elm
$ elm-upgrade
```

```elm
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    DealHand ->
      let
        localTask =
          locallyStore updated
            |> mapError LocallyStoreError
        remoteTask value =
          remotelyStore value model
            |> mapError (RemotelyStoreError << httpErrorToString)
        cmd =
          localTask
            |> andThen remoteTask
            |> Task.attempt Storage
      in
        model ! [cmd]
    Storage (Err error) ->
      let
        updated = updateModelFromErrorType error model
      in
        updated ! []
    Storage (Ok serverResponse) ->
      let
        updated = updateModelFromServerResponse serverResponse model
      in
        updated ! []
```

#### Links

* [elm-upgrade](https://www.npmjs.com/package/elm-upgrade)
* [Migration Guide](https://github.com/elm-lang/elm-platform/blob/master/upgrade-docs/0.18.md)
