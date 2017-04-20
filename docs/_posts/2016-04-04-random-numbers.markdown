---
layout: post
title:  "Random Numbers"
date:   2016-04-04 09:00:00 -0500
categories:
label: ep-002
number: 2
tiny_description: Learn how to incorporate basic random numbers.
---

Getting random numbers in Elm requires basing your initial seed on the current time. The simplest way to get the current time in your app is to use a `port` that is initialized when the app starts.

### Samples

##### Main module
```
port currentTime : Int
```

##### index.html
```
<script>
Elm.embed(Elm.Core, div, { currentTime: new Date().getTime() });
</script>
```

### Links
* [Elm's Random Library Docs](http://package.elm-lang.org/packages/elm-lang/core/3.0.0/Random)
