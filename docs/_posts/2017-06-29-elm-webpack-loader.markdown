---
layout: post
title:  "Elm & Webpack"
date:   2017-06-29 14:03:00 -0400
categories:
label: ep-039
number: 39
tiny_description: Compile Elm with Webpack.
---

[Webpack](https://webpack.js.org/) is an asset compiling and bundling tool. It works great with Elm thanks to the [elm-webpack-loader](https://github.com/elm-community/elm-webpack-loader), and requires very little configuration to get started.


### Examples

**webpack.config.js**

```js
const path = require('path')

module.exports = function(env) {
  return {
    entry: './js/app.js',
    output: {
      path: path.resolve(__dirname, 'dist'),
      filename: 'bundle.js'
    },
    module: {
      loaders: [{
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        use: {
          loader: 'elm-webpack-loader',
          options: {debug: true, warn: true}
        }
      }]
    }
  }
}

```

#### Links

* [Webpack](https://webpack.js.org/)
* [elm-community/elm-webpack-loader](https://github.com/elm-community/elm-webpack-loader)
