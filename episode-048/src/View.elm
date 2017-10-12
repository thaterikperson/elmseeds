module View exposing (view)

import Html exposing (Html, div, text)
import Model exposing (..)
import Color
import Element as El exposing (Element)
import Element.Attributes exposing (..)
import Style exposing (StyleSheet)
import Style.Font
import Style.Color


type Styles
    = GreenBg
    | None
    | Header
    | Heading
    | HeadingLeft
    | HeadingRight
    | Link
    | HeaderMeta


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
    El.el None [ center ] <|
        El.row Header
            [ width (px 1024), height (px 120) ]
            [ El.row Heading
                [ width fill, alignBottom ]
                [ El.link "/"
                    (El.row None
                        []
                        [ El.el HeadingLeft [] (El.text "Elm")
                        , El.el HeadingRight [] (El.text "seeds")
                        ]
                    )
                ]
            , El.row HeaderMeta
                [ alignBottom ]
                [ El.text "Get updates via "
                , headerLink "Twitter" "https://twitter.com/seedsofelm"
                , El.text ", "
                , headerLink "Github" "https://github.com/thaterikperson/elmseeds"
                , El.text ", "
                , headerLink "RSS" "/feed.xml"
                , El.text " | About"
                ]
            ]


headerLink : String -> String -> Element Styles v msg
headerLink text url =
    El.link url (El.el Link [] (El.text text))


styleSheet : StyleSheet Styles v
styleSheet =
    Style.styleSheet
        [ Style.style GreenBg
            [ Style.Color.background (Color.rgb 51 153 51)
            ]
        , Style.style Heading
            [ Style.Font.size 80
            , Style.hover
                [ Style.Font.underline
                ]
            ]
        , Style.style HeadingLeft
            [ Style.Color.text Color.white
            , Style.Font.weight 200
            ]
        , Style.style HeadingRight
            [ Style.Color.text (Color.rgb 244 208 107)
            ]
        , Style.style Link
            [ Style.Color.text (Color.rgb 244 208 107)
            , Style.Font.underline
            ]
        , Style.style HeaderMeta
            [ Style.Color.text Color.white
            , Style.Font.size 20
            ]
        ]
