---
layout: post
title: SPA - Navigation
date: 2018-02-15 13:43:00 -0500
categories:
label: ep-053
number: 53
tiny_description: Add navigation and url routing to your SPA.
---

The next step in our Single Page Application series is to add url routing and navigation. There are two packages we'll need for this. The first, [Navigation](http://package.elm-lang.org/packages/elm-lang/navigation/latest),
will allow us to handle navigation events and starting the application on a page other than the home page.

The second package, [Url-Parser](http://package.elm-lang.org/packages/evancz/url-parser/latest), helps us parse our url's path into an Elm sum type
which we can use to determine which page to render in the view.

### Examples

**shell**
```sh
# Force the server to render index.html on 404s
./node_modules/.bin/webpack-dev-server --history-fallback-api
```

**Main.elm**
```elm
setRoute : Location -> Model -> Model
setRoute location model =
    let
        route =
            UrlParser.parsePath Route.route location
                |> Maybe.withDefault Route.Home
    in
        case route of
            Route.Home ->
                { model | page = Home }

            Route.Newest ->
                { model | page = Newest }

```

### Links

* [elm-lang/navigation](http://package.elm-lang.org/packages/elm-lang/navigation/latest)
* [evancz/url-parser](http://package.elm-lang.org/packages/evancz/url-parser/latest)

