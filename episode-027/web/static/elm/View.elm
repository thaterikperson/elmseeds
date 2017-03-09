module View exposing (..)

import Basics as B
import Blackjack exposing (Card, CardType(..), CardSuit(..), suitOfCard, typeOfCard, bestScore, newHand, addCardToHand)
import Date exposing (Date, Month(..))
import Collage
import Color exposing (rgba)
import Element
import FileReader exposing (parseSelectedFiles, parseDroppedFiles)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Json
import Model exposing (..)
import Routes exposing (Page(..))
import ViewHelper exposing (..)


aboutView : Model -> Html Msg
aboutView model =
    div [ class "main container" ]
        [ div [ class "row" ]
            [ div [ class "eight columns offset-by-two" ]
                [ h1 [] [ text "Blackjack by Elmseeds" ]
                , p []
                    [ text "A work in progress Blackjack game."
                    ]
                , p []
                    [ text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus egestas augue porttitor est cursus, non interdum diam luctus. Duis ac auctor quam, eget auctor erat. In porttitor turpis et libero iaculis vestibulum. Cras interdum mi in arcu sagittis dapibus. Suspendisse potenti. Duis id lectus luctus lorem tristique interdum ornare eu lorem. Vivamus eleifend aliquet vulputate. Quisque pretium semper elementum. Vivamus at purus eleifend, viverra nibh nec, euismod felis. Nullam condimentum venenatis elit, id vestibulum leo accumsan at. Nulla sit amet turpis ipsum. Quisque placerat interdum erat a pulvinar. Sed tristique, nisl quis aliquam commodo, metus lectus blandit erat, non porttitor sapien eros eu enim. Sed hendrerit turpis nec risus congue, in lacinia ipsum pretium. Suspendisse a ultricies diam, sit amet ornare augue. Aenean mollis sapien sit amet ligula vestibulum rhoncus. In eget ipsum mollis, consectetur libero nec, venenatis odio. Etiam semper quam vel imperdiet varius."
                    ]
                , p []
                    [ a [ href "/", onLinkClick (NavigateTo About) ] [ text "Home" ]
                    ]
                ]
            ]
        ]


onLinkClick : msg -> Attribute msg
onLinkClick msg =
    onWithOptions "click"
        { stopPropagation = True
        , preventDefault = True
        }
        (Json.succeed msg)


homeView : Model -> Html Msg
homeView model =
    let
        canvasWidth =
            523

        half =
            canvasWidth / 2

        forms =
            case ( model.mouseDownPosition, model.encodedFile ) of
                ( _, Nothing ) ->
                    []

                ( Nothing, Just src ) ->
                    let
                        img_ =
                            Element.image canvasWidth canvasWidth src
                                |> Collage.toForm
                    in
                        [ img_ ]

                ( Just mouseDownPosition, Just src ) ->
                    let
                        img_ =
                            Element.image canvasWidth canvasWidth src
                                |> Collage.toForm

                        ( ( x, y ), ( bottomRightX, bottomRightY ) ) =
                            let
                                ( x1, y1 ) =
                                    mouseDownPosition

                                ( x2, y2 ) =
                                    case model.mouseMovePosition of
                                        Just p ->
                                            p

                                        Nothing ->
                                            model.mouseUpPosition
                                                |> Maybe.withDefault mouseDownPosition

                                minX =
                                    B.min x1 x2

                                minY =
                                    B.min y1 y2

                                diff =
                                    B.max ((B.max x1 x2) - minX) ((B.max y1 y2) - minY)
                            in
                                ( ( minX, minY ), ( minX + diff, minY + diff ) )

                        top =
                            Collage.rect canvasWidth y
                                |> Collage.filled (rgba 0 0 0 0.8)
                                |> Collage.move ( 0, half - (y / 2) )

                        left =
                            Collage.rect x (canvasWidth - y)
                                |> Collage.filled (rgba 0 0 0 0.8)
                                |> Collage.move ( -1 * (half - (x / 2)), half - ((canvasWidth - y) / 2) - y )

                        right =
                            Collage.rect (canvasWidth - bottomRightX) (canvasWidth - y)
                                |> Collage.filled (rgba 0 0 0 0.8)
                                |> Collage.move ( half - ((canvasWidth - bottomRightX) / 2), half - ((canvasWidth - y) / 2) - y )

                        bottom =
                            Collage.rect (bottomRightX - x) (canvasWidth - bottomRightY)
                                |> Collage.filled (rgba 0 0 0 0.8)
                                |> Collage.move ( (((bottomRightX - x) / 2) - (half - x)), (-1 * (half - ((canvasWidth - bottomRightY) / 2))) )
                    in
                        [ img_, top, left, right, bottom ]

        collage =
            Collage.collage canvasWidth canvasWidth forms
                |> Element.toHtml

        mouseDown =
            onWithOptions "mousedown" { preventDefault = True, stopPropagation = True } (Json.map MouseDown decodeClickLocation)

        onHandlers =
            if model.isMovingMouse then
                [ onWithOptions "mouseup" { preventDefault = True, stopPropagation = True } (Json.map MouseUp decodeClickLocation)
                , onWithOptions "mousemove" { preventDefault = True, stopPropagation = True } (Json.map MouseMove decodeClickLocation)
                , mouseDown
                ]
            else
                [ mouseDown ]
    in
        div [ class "main container" ]
            [ div [ class "row" ]
                [ Html.form [ id "file-form", onSubmit UploadImage ]
                    [ div [ class "row" ] [ input [ type_ "file", on "change" (Json.map Files parseSelectedFiles) ] [] ]
                    , div [ class "row" ]
                        [ div
                            [ classList
                                [ ( "drop-form", True )
                                , ( "drop-form-hover", model.isFileHovering )
                                , ( "drop-error", model.isBadFileType )
                                ]
                            , onWithOptions "dragover" { preventDefault = True, stopPropagation = True } (Json.map (\_ -> DragOver) Json.value)
                            , onWithOptions "dragleave" { preventDefault = True, stopPropagation = True } (Json.map (\_ -> DragLeave) Json.value)
                            , onWithOptions "drop" { preventDefault = True, stopPropagation = True } (Json.map DropFiles parseDroppedFiles)
                            ]
                            [ text model.message
                            ]
                        ]
                    , (if model.encodedFile == Nothing then
                        text ""
                       else
                        div [ class "row" ]
                            [ div [ class "six columns" ]
                                [ label [] [ text "Crop Image" ]
                                , div ((class "big-preview") :: onHandlers)
                                    [ collage
                                    ]
                                ]
                            ]
                      )
                    , div [ class "row" ] [ button [] [ text "Upload" ] ]
                    ]
                ]
            ]


decodeClickLocation : Json.Decoder ( Float, Float )
decodeClickLocation =
    Json.map2 (,)
        (Json.at [ "offsetX" ] Json.float)
        (Json.at [ "offsetY" ] Json.float)


mainView : Model -> Html Msg
mainView model =
    let
        bodyView =
            case model.page of
                Home ->
                    homeView model

                About ->
                    aboutView model
    in
        div []
            [ bodyView
            ]
