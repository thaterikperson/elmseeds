---
layout: post
title:  "Update.Extra"
date:   2017-03-31 16:14:00 -0400
categories:
label: ep-030
number: 30
tiny_description: Prevent subtle bugs in your update functions.
---

Because `model` is such a common name to use in your update function, it can be tricky to ensure you're always using the most updated version. Whether it is `model_`, `model2`, or `updatedModel`, subtle bugs can work their way into your code if you use the wrong one.

You can almost completely eliminate that problem if you use the pipe operator `|>` and never bind anything. The [Update.Extra module](http://package.elm-lang.org/packages/ccapndave/elm-update-extra/latest) makes that easy.

### Examples

**Main.elm**

```elm
update : MsgDetail -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Edit listId id name ->
            Lists.update (Create listId) model
                |> Tuple.mapFirst (updateDetail id name)
                |> Update.addCmd (writeToLocalStorage name)
                |> andThen Server.update Save


andThen : (msg -> model -> ( model, Cmd a )) -> msg -> ( model, Cmd a ) -> ( model, Cmd a )
andThen update msg ( model, cmd ) =
    let
        ( model_, cmd_ ) =
            update msg model
    in
        ( model_, Cmd.batch [ cmd, cmd_ ] )
```

#### Links

* [ccapndave/elm-update-extra](http://package.elm-lang.org/packages/ccapndave/elm-update-extra/latest)
