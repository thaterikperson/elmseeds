---
layout: post
title:  "Elm-Multiselect"
date:   2017-08-03 14:09:00 -0400
categories:
label: ep-043
number: 43
tiny_description: Easily create a tokenizing search input with elm-multiselect.
---

[Elm-Multiselect](http://package.elm-lang.org/packages/inkuzmin/elm-multiselect/latest) is a simple package for creating tokenizing search inputs. These inputs are pefect for the "To" field of a multi-user messaging application, or anytime you want to allow searching for and selecting multiple results.

### Examples

**Main.elm**

```elm
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MultiselectMsg msg ->
            Multiselect.update msg model.multiselect
                |> Tuple.mapFirst (\m -> { model | multiselect = m })
                |> Tuple.mapSecond (Cmd.map MultiselectMsg)
```

**View.elm**

```elm
view : Model -> Html Msg
view model =
    div []
        [ label [ for "multiselectInputto_field" ] [ text "To:" ]
        , Html.map MultiselectMsg <| Multiselect.view model.multiselect
        ]
```

#### Links

* [inkuzmin/elm-multiselect](http://package.elm-lang.org/packages/inkuzmin/elm-multiselect/latest)
* [multiselect stylesheet](https://github.com/inkuzmin/elm-multiselect/blob/master/docs/app.css)
