---
layout: post
title:  "Webpack HMR and Production"
date:   2017-07-06 14:18:00 -0400
categories:
label: ep-040
number: 40
tiny_description: Use Webpack Hot Module Reload and compile for production.
---

Hot module reloading (HMR) allows Webpack to update the code of your Elm application without losing the state. If you have a complex model and have to walk through several steps to get the state exactly as you want it, HMR will save you a significant amount of development time. Use [elm-hot-loader](https://github.com/fluxxu/elm-hot-loader) to enable it in your Webpack and Elm application.

Once you're ready to deploy your Elm application to production, Webpack can help you compile the app without the debugger, and minify the final file.


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
        use: [{
          loader: 'elm-hot-loader'
        },{
          loader: 'elm-webpack-loader',
          options: (env && env.production) ? {} : {debug: true, warn: true}
        }]
      }]
    }
  }
}

```

#### Links

* [elm-hot-loader](https://github.com/fluxxu/elm-hot-loader)
