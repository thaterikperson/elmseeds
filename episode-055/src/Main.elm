module Main exposing (main)

import Html exposing (Html, div, h1, h2, p, ol, li, text)
import Http
import Json.Decode as Decode exposing (Decoder)
import Navigation exposing (Location)
import RemoteData exposing (WebData)
import Route
import UrlParser


type Msg
    = SetRoute Location
    | TopStoriesFetched (WebData HomeModel)


type Page
    = Home (WebData HomeModel)
    | Newest


type alias HomeModel =
    { topStories : List StoryId }


type alias Model =
    { page : Page
    }


main : Program Never Model Msg
main =
    Navigation.program SetRoute
        { init = init
        , update = update
        , view = view
        , subscriptions = (\_ -> Sub.none)
        }


init : Location -> ( Model, Cmd Msg )
init location =
    setRoute location { page = Home RemoteData.NotAsked }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetRoute location ->
            setRoute location model

        TopStoriesFetched webData ->
            ( { model | page = Home webData }, Cmd.none )


setRoute : Location -> Model -> ( Model, Cmd Msg )
setRoute location model =
    let
        route =
            UrlParser.parsePath Route.route location
                |> Maybe.withDefault Route.Home
    in
        case route of
            Route.Home ->
                let
                    cmd =
                        topStories
                            |> RemoteData.sendRequest
                            |> Cmd.map TopStoriesFetched
                in
                    ( { model | page = Home RemoteData.Loading }, cmd )

            Route.Newest ->
                ( { model | page = Newest }, Cmd.none )


view : Model -> Html Msg
view model =
    case model.page of
        Home webData ->
            homeView webData

        Newest ->
            h1 [] [ text "Newest" ]


homeView : WebData HomeModel -> Html Msg
homeView webData =
    case webData of
        RemoteData.Success model ->
            div []
                [ h1 [] [ text "👩\x200D💻 News" ]
                , ol [] (List.map storyIdToHtml model.topStories)
                ]

        RemoteData.Failure error ->
            div []
                [ h1 [] [ text "👩\x200D💻 News" ]
                , h2 [] [ text "Failed to load Top Stories" ]
                , p [] [ text <| toString error ]
                ]

        _ ->
            div []
                [ h1 [] [ text "👩\x200D💻 News" ]
                , h2 [] [ text "Loading…" ]
                ]


storyIdToHtml : StoryId -> Html Msg
storyIdToHtml storyId =
    li [] [ text <| toString storyId ]


type StoryId
    = StoryId String


storyIdDecoder : Decoder StoryId
storyIdDecoder =
    Decode.map (StoryId << toString) Decode.int


topStories : Http.Request HomeModel
topStories =
    storyIdDecoder
        |> Decode.list
        |> Decode.map HomeModel
        |> Http.get "https://hacker-news.firebaseio.com/v0/topstories.json"
