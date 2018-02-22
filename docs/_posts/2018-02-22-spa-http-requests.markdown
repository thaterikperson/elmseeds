---
layout: post
title: SPA - HTTP Requests
date: 2018-02-22 13:42:00 -0500
categories:
label: ep-054
number: 54
tiny_description: Add basic HTTP requests to your SPA.
---

It's time to add some data to our Single Page Application. Because we're building a Hacker News clone, we'll use the official Hacker News API to
fetch data. We can do this with some simple HTTP requests using [elm-lang/http](http://package.elm-lang.org/packages/elm-lang/http). In this episode
we'll setup our application to automatically load the Top Stories whenever the user launches the application on the home page, or navigates to it 
from within the app.

### Examples

**Main.elm**
```elm
type StoryId
    = StoryId String


storyIdDecoder : Decoder StoryId
storyIdDecoder =
    Decode.map (StoryId << toString) Decode.int


topStories : Http.Request (List StoryId)
topStories =
    Http.get "https://hacker-news.firebaseio.com/v0/topstories.json" (Decode.list storyIdDecoder)


setRoute : Location -> Model -> ( Model, Cmd Msg )
setRoute location model =
    let
        -- …
    in
        case route of
            Route.Home ->
                let
                    cmd =
                        Http.send TopStoriesFetched topStories
                in
                    ( { model | page = Home }, cmd )
```

### Links

* [Official Hacker News API](https://github.com/HackerNews/API)
