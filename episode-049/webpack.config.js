const path = require('path')
const exec = require('child_process').exec;

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
    },
    plugins: [
      new WebpackShellPlugin({
        onBuildEnd: ['/usr/local/bin/elm-css src/Stylesheets.elm']
      })
    ]
  }
}

function puts(error, stdout, stderr) {
    console.log(stdout);
}

function WebpackShellPlugin(options) {
  var defaultOptions = {
    onBuildStart: [],
    onBuildEnd: []
  };

  this.options = Object.assign(defaultOptions, options);
}

WebpackShellPlugin.prototype.apply = function(compiler) {
  const options = this.options;

  compiler.plugin("compilation", compilation => {
    if(options.onBuildStart.length){
        console.log("Executing pre-build scripts");
        options.onBuildStart.forEach(script => exec(script, puts));
    }
  });

  compiler.plugin("emit", (compilation, callback) => {
    if(options.onBuildEnd.length){
        console.log("Executing post-build scripts");
        options.onBuildEnd.forEach(script => exec(script, puts));
    }
    callback();
  });
};
