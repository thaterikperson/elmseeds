---
layout: post
title:  "Http.Progress"
date:   2017-02-02 16:15:00 -0500
categories:
label: ep-023
number: 23
tiny_description: Track the progress of an HTTP request.
---

If you're ever going to be requesting large amounts of data via HTTP, show your users the state of the request by tracking its progress. [Http.Progress](http://package.elm-lang.org/packages/elm-lang/http/1.0.0/Http-Progress)' `track` function replaces `send` from the `Http` module, and when you include the resulting `Platform.Sub` in your program's `subscriptions` function, you'll receive updates on the progress.


### Examples

**Main.elm**

```elm
main =
    Navigation.program
        UrlChange
        { subscriptions =
            (\model ->
                case model.currentRequest of
                    Nothing ->
                        Sub.none

                    Just req ->
                        Http.Progress.track (toString model.currentRequestNumber) FetchedBytesProgress req
            )
        }

update msg model =
    case msg of
        FetchedBytesProgress progress ->
          case progress of
              Http.Progress.None ->
                  model ! []

              Http.Progress.Some { bytes, bytesExpected } ->
                  let
                      percent =
                          100
                              * (toFloat bytes)
                              / (toFloat bytesExpected)
                              |> toString
                              |> flip (++) "%"
                  in
                      { model | base64Text = percent } ! []

              Http.Progress.Done txt ->
                  { model | base64Text = txt } ! []

              Http.Progress.Fail error ->
                  { model | base64Text = "Error" } ! []
```

#### Links

* [elm-lang/http](http://package.elm-lang.org/packages/elm-lang/http/latest)
