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
