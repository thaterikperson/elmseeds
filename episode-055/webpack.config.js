const path = require('path')

module.exports = function(env) {
  return {
    entry: './js/app.js',
    output: {
      path: path.resolve(__dirname),
      filename: 'dist/bundle.js'
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
