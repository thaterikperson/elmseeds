module View exposing (view)

import Array
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Model exposing (..)
import SelectList


view : Model -> Html Msg
view model =
    let
        befores =
            model.tabs
                |> SelectList.before
                |> List.map (tabView False)

        afters =
            model.tabs
                |> SelectList.after
                |> List.map (tabView False)

        selected =
            model.tabs
                |> SelectList.selected

        selectedTab =
            tabView True selected
    in
        div [ class "container mw6" ]
            [ h1 [] [ text "SelectList" ]
            , div [ class "flex flex-row" ]
                [ ul [ class "list mr4 ml0 pl0" ] (befores ++ (selectedTab :: afters))
                , div []
                    [ h2 [] [ text "User Details" ]
                    , p []
                        [ b [] [ text "Name" ]
                        , br [] []
                        , text selected.name
                        ]
                    , p []
                        [ b [] [ text "Email" ]
                        , br [] []
                        , text selected.email
                        ]
                    ]
                ]
            ]


tabView : Bool -> User -> Html Msg
tabView isSelected user =
    li [ onClick (SelectTab user.id), classList [ ( "bg-red white ph3 pv2 pointer hover-black", True ), ( "bg-light-red", isSelected ) ] ]
        [ text user.name ]
