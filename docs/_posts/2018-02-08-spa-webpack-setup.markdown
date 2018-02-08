---
layout: post
title: SPA - Webpack Setup
date: 2018-02-08 14:00:00 -0500
categories:
label: ep-052
number: 52
tiny_description: Prepare to build a new SPA by setting up Webpack to compile our project automatically.
---

This episode begins a series in which we build a Single Page Application (SPA) clone of [Hacker News](https://news.ycombinator.com). We'll call our version Technologist News.

We begin by setting up the most basic application and supporting infrastructure possible. We'll use Webpack to do our automatic compilation.

### Examples

**app.js**
```js
import Elm from '../src/Main.elm'

const div = document.getElementById('main')
window.main = Elm.Main.embed(div)
```

**index.html**
```html
<!DOCTYPE html>
<html>
<body>
  <main id="main"></main>
  <script src="/dist/bundle.js"></script>
</body>
</html>
```

### Links

* [HackerNews API](https://github.com/HackerNews/API)
* [rtfelman/elm-spa-example](https://github.com/rtfeldman/elm-spa-example)
* [Episode 39: Elm & Webpack](https://elmseeds.thaterikperson.com/elm-webpack-loader)

