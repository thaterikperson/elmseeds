---
layout: post
title: SPA - WebData Page Model
date: 2018-02-28 02:38:00 -0500
categories:
label: ep-055
number: 55
tiny_description: Making impossible state impossible in our application's model.
---

As we add new pages to our application, and data to our model, the complexity and maintainability
of our application increases. Using the [RemoteData](http://package.elm-lang.org/packages/krisajenkins/remotedata/latest) pattern, we can modify our
page type to represent only the current, valid state of the app.

### Examples

**Main.elm**
```elm
type Msg
    = TopStoriesFetched (WebData HomeModel)


type Page
    = Home (WebData HomeModel)


type alias HomeModel =
    { topStories : List StoryId }


type alias Model =
    { page : Page
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TopStoriesFetched webData ->
            ( { model | page = Home webData }, Cmd.none )
```

### Links

* [Elmseeds Episode 37: RemoteData](https://elmseeds.thaterikperson.com/remotedata)
