module Main exposing (main)

import Html exposing (Html, div, h1, ol, li, text)
import Http
import Json.Decode as Decode exposing (Decoder)
import Navigation exposing (Location)
import Route
import UrlParser


type Msg
    = SetRoute Location
    | TopStoriesFetched (Result Http.Error (List StoryId))


type Page
    = Home
    | Newest


type alias Model =
    { page : Page
    , topStories : List StoryId
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
    setRoute location { page = Home, topStories = [] }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetRoute location ->
            setRoute location model

        TopStoriesFetched (Ok storyIds) ->
            ( { model | topStories = storyIds }, Cmd.none )

        TopStoriesFetched (Err error) ->
            let
                _ =
                    Debug.log "error" error
            in
                ( model, Cmd.none )


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
                        Http.send TopStoriesFetched topStories
                in
                    ( { model | page = Home }, cmd )

            Route.Newest ->
                ( { model | page = Newest }, Cmd.none )


view : Model -> Html Msg
view model =
    case model.page of
        Home ->
            div []
                [ h1 [] [ text "👩\x200D💻 News" ]
                , ol [] (List.map storyIdToHtml model.topStories)
                ]

        Newest ->
            h1 [] [ text "Newest" ]


storyIdToHtml : StoryId -> Html Msg
storyIdToHtml storyId =
    li [] [ text <| toString storyId ]


type StoryId
    = StoryId String


storyIdDecoder : Decoder StoryId
storyIdDecoder =
    Decode.map (StoryId << toString) Decode.int


topStories : Http.Request (List StoryId)
topStories =
    Http.get "https://hacker-news.firebaseio.com/v0/topstories.json" (Decode.list storyIdDecoder)
