---
layout: post
title:  "Debugging"
date:   2016-03-27 20:00:00 -0500
categories:
full_preview_src: https://s3.amazonaws.com/elmseeds/ep-001/cover-art-960.png
thumb_preview_src: https://s3.amazonaws.com/elmseeds/ep-001/cover-art-294.png
video_src: https://s3.amazonaws.com/elmseeds/ep-001/ep-001.mp4
tiny_description: Learn to use the two basic functions in the Debug module.
---

Basic debugging in Elm uses two methods. `Debug.log` and `Debug.crash`. Use `log` to print to the web console, and `crash` when you want to halt execution of your app. Usage of either method should be removed before deploying your code to production.

### Samples

{% highlight elm linenos %}
Array.toList (Debug.log "shuffled" (shuffle fullDeck 0 seed))

case Array.get i deck of
  Nothing -> Debug.crash "index out of bounds"
  Just c -> c
{% endhighlight %}

### Links
* [Debug Elm Docs](http://package.elm-lang.org/packages/elm-lang/core/3.0.0/Debug)
* [Fisher-Yates Shuffling Algorithm](https://en.wikipedia.org/wiki/Fisher–Yates_shuffle)
