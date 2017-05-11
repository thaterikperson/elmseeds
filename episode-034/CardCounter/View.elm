module View exposing (view)

import FormatNumber exposing (format)
import FormatNumber.Locales exposing (Locale)
import Model exposing (..)
import NativeUi as Ui exposing (Node)
import NativeUi.Style as Style exposing (defaultTransform)
import NativeUi.Elements as Elements exposing (..)
import NativeUi.Events exposing (..)


myLocale : Locale
myLocale =
    { decimals = 1
    , thousandSeparator = ""
    , decimalSeparator = "."
    }


view : Model -> Node Msg
view model =
    Elements.view
        []
        [ Elements.view
            [ Ui.style
                [ Style.flexDirection "row"
                , Style.marginVertical 30
                , Style.alignSelf "stretch"
                , Style.justifyContent "space-between"
                , Style.marginHorizontal 20
                ]
            ]
            [ Elements.view
                []
                [ text
                    [ Ui.style
                        [ Style.fontSize 72
                        ]
                    ]
                    [ Ui.string (toString model.runningCount) ]
                , text [] [ Ui.string "Running" ]
                ]
            , Elements.view
                []
                [ text
                    [ Ui.style
                        [ Style.alignSelf "flex-end"
                        , Style.fontSize 10
                        ]
                    ]
                    [ Ui.string (model |> trueCount |> format myLocale) ]
                , text
                    [ Ui.style
                        [ Style.alignSelf "flex-end"
                        ]
                    ]
                    [ Ui.string "True" ]
                ]
            ]
        , Elements.view
            [ Ui.style
                [ Style.flexDirection "row"
                , Style.justifyContent "space-between"
                , Style.alignSelf "stretch"
                ]
            ]
            [ button Low "#333" "Low"
            , button Mid "#333" "Mid"
            , button High "#333" "High"
            ]
        , button Reset "#333" "Reset"
        ]


button : Msg -> String -> String -> Node Msg
button msg color content =
    text
        [ Ui.style
            [ Style.color "white"
            , Style.alignSelf "stretch"
            , Style.textAlign "center"
            , Style.backgroundColor color
            , Style.padding 20
            , Style.margin 20
            , Style.fontWeight "bold"
            , Style.shadowColor "#000"
            , Style.shadowOpacity 0.25
            , Style.shadowOffset 1 1
            , Style.shadowRadius 5
            , Style.transform { defaultTransform | rotate = Just "0deg" }
            ]
        , onPress msg
        ]
        [ Ui.string content ]
