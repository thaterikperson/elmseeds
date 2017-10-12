---
layout: post
title:  "Style Elements"
date:   2017-10-12 14:00:00 -0400
categories:
label: ep-048
number: 48
tiny_description: Build your web interface in a safer, more maintainable way.
---

If you've written CSS for more than a week, you know how difficult it is to refactor without breaking something. [Style Elements](http://package.elm-lang.org/packages/mdgriffith/style-elements/latest) gives you the same safety and peace of mind in your view as you're used to in the rest of your Elm application.

### Examples

**View.elm**

```elm
type Styles
    = GreenBg
    | None

view : Model -> Html msg
view model =
    El.layout styleSheet body


body : Element Styles v msg
body =
    El.column GreenBg
        [ height (px 300) ]
        [ header ]


header : Element Styles v msg
header =
    El.row None
        [ width fill, alignBottom ]
        [ El.link "/"
            (El.row None
                []
                [ El.el None [] (El.text "Elm")
                , El.el None [] (El.text "seeds")
                ]
            )
        ]


styleSheet : StyleSheet Styles v
styleSheet =
    Style.styleSheet
        [ Style.style GreenBg
            [ Style.Color.background (Color.rgb 51 153 51)
            ]
        ]
```

#### Links

* [mdgriffith/style-elements](http://package.elm-lang.org/packages/mdgriffith/style-elements/latest)
* [An Introduction to Style Elements for Elm](https://mdgriffith.gitbooks.io/style-elements/content/)
