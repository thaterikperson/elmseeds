module View exposing (..)

import Dict
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import Plot
import Svg exposing (Svg)
import Svg.Attributes as Sa
import ViewHelper exposing (..)


mainView : Model -> Html Msg
mainView model =
    div [ class "main container" ]
        [ div [ class "row" ]
            [ div [ class "twelve columns" ]
                [ plot model
                ]
            ]
        ]


plot : Model -> Html Msg
plot model =
    let
        ( _, cumulativeGains ) =
            model.days
                |> List.foldl (\day ( sum, accum ) -> ( day.gain + sum, (day.gain + sum) :: accum )) ( 0, [] )

        gains =
            cumulativeGains
                |> List.reverse
                |> List.indexedMap (\index pair -> ( index, pair ))
                |> Dict.fromList
    in
        Plot.viewSeries
            [ Plot.line (List.map (\{ index, gain } -> Plot.triangle (toFloat index) gain))
            , Plot.line
                (List.map
                    (\{ index } ->
                        let
                            gain =
                                Dict.get index gains
                                    |> Maybe.withDefault 0

                            color =
                                if gain > 0 then
                                    "black"
                                else
                                    "red"
                        in
                            Plot.dot (spade color) (toFloat index) gain
                    )
                )
            ]
            model.days


spade : String -> Svg Msg
spade fill =
    Svg.path [ Sa.fill fill, Sa.d "M 5.7,4.88 C 4.05,6.46 1.42,6.48 -0.24,4.92 -0.27,4.9 -0.3,4.87 -0.32,4.84 -2,6.49 -4.71,6.49 -6.39,4.84 -8.06,3.2 -8.06,0.53 -6.39,-1.11 L -0.32,-7.07 5.74,-1.11 C 7.41,0.52 7.42,3.16 5.78,4.81 L 5.74,4.84 5.7,4.88 Z M -0.33,5.79 L 2.16,8 -2.82,8 -0.33,5.79 Z M -0.33,5.79" ] []
