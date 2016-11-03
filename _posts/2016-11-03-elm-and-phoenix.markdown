---
layout: post
title:  "Elm & Phoenix"
date:   2016-11-03 11:42:00 -0400
categories:
label: ep-013
tiny_description: Incorporate Elm into your Phoenix application.
---

Elm and [Phoenix](http://www.phoenixframework.org) go together like peanut butter and jelly. Phoenix is a web framework written in [Elixir](http://elixir-lang.org). Combining the two allows you to write functional code on the front-end and the back-end.

### Examples

```sh
npm install --save-dev elm-brunch
```

**brunch-config.js**

```js
elmBrunch: {
  mainModules: ['web/static/elm/Main.elm'],
  outputFolder: 'web/static/js/'
}
```

**app.js**

```js
import Elm from './main'
const div = document.getElementById('main')
Elm.Main.embed(div)
```
