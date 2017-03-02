module View exposing (..)

import Blackjack exposing (Card, CardType(..), CardSuit(..), suitOfCard, typeOfCard, bestScore, newHand, addCardToHand)
import Date exposing (Date, Month(..))
import FileReader exposing (parseSelectedFiles)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Json
import Model exposing (..)
import Routes exposing (Page(..))
import ViewHelper exposing (..)
import FileReader exposing (parseDroppedFiles)


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
    customThemeView "black" model


customThemeView : String -> Model -> Html Msg
customThemeView theme model =
    let
        deckView =
            div [ class "deck" ] []

        cardRowChildren =
            [ deckView ]
    in
        div [ class ("main container " ++ theme) ]
            [ div [ class "row" ]
                [ Html.form [ id "file-form", onSubmit UploadImage ]
                    [ input [ type_ "file", on "change" (Json.map Files parseSelectedFiles) ] []
                    , div
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
                    , button [] [ text "Upload" ]
                    , model.encodedFile
                        |> Maybe.map (\ref -> img [ src ref ] [])
                        |> Maybe.withDefault (text "")
                    ]
                ]
            ]


mainView : Model -> Html Msg
mainView model =
    let
        bodyView =
            case model.page of
                Home ->
                    homeView model

                About ->
                    aboutView model

                Theme color ->
                    customThemeView color model
    in
        div []
            [ bodyView
            ]
