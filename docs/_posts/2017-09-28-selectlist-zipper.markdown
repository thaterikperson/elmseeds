---
layout: post
title:  "SelectList"
date:   2017-09-28 14:00:00 -0400
categories:
label: ep-047
number: 47
tiny_description: The zipper data structure guarantees an item in the list will always be selected.
---

Modeling impossible state is an anti-pattern in Elm, so instead we need to come up with new approaches to model our application. If we want to model a list of items such that one is always selected, we can use the zipper data structure. It enforces that one item is always selected, and is the perfect complement to many UI patterns. In this episode, we use Richard Feldman's [selectlist](http://package.elm-lang.org/packages/rtfeldman/selectlist/latest) to clean up problematic code.

### Examples

**Main.elm**

```elm
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SelectTab id ->
            ( { model | tabs = SelectList.select (\u -> u.id == id) model.tabs }, Cmd.none )
```

**View.elm**

```elm
view : Model -> Html Msg
view model =
    let
        befores =
            model.tabs
                |> SelectList.before
                |> List.map (tabView False)
```

#### Links

* [rtfeldman/selectlist](http://package.elm-lang.org/packages/rtfeldman/selectlist/latest)
* [Zipper Data Structure](https://en.wikipedia.org/wiki/Zipper_(data_structure))
