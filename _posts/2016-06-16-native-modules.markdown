---
layout: post
title:  "Native Modules"
date:   2016-06-16 11:00:00 -0500
categories:
label: ep-005
tiny_description: An easier way to distribute code that interfaces with Javascript.
---

Native modules are another way to interact with Javascript through Elm. All interactions are handled through [`Task`](http://package.elm-lang.org/packages/elm-lang/core/4.0.1/Task)s, which enable your Javascript work to be asynchronous.

Check out a good example in [evancz/elm-http's Http.js](https://github.com/evancz/elm-http/blob/3.0.1/src/Native/Http.js)


### Samples

{% highlight js %}
var _user$project$Native = function() {

  function setItem(key, value) {
    return _elm_lang$core$Native_Scheduler.nativeBinding(function(callback) {
      localStorage.setItem(key, value)
      callback(_elm_lang$core$Native_Scheduler.succeed(key));
    });
  }

  return {
    setItem: F2(setItem)
  }
}();
{% endhighlight %}

### Links
* [evancz/elm-http's Http.js](https://github.com/evancz/elm-http/blob/3.0.1/src/Native/Http.js)
