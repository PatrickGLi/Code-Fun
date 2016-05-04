// module.exports = {
//   context: __dirname,
//   entry: "./js/main.js",
  // output: {
  //   path: "./js",
  //   publicPath: "/js/",
  //   filename: "bundle.js",
  //   devtoolModuleFilenameTemplate: '[resourcePath]',
  //   devtoolFallbackModuleFilenameTemplate: '[resourcePath]?[hash]'
  // },
//   devtool: 'source-maps'
// };


module.exports = {
  context: __dirname,
  entry: "./js/main.js",
  output: {
    path: "./js",
    filename: "bundle.js",
    devtoolModuleFilenameTemplate: '[resourcePath]',
    devtoolFallbackModuleFilenameTemplate: '[resourcePath]?[hash]'
  },
  module: {
    loaders: [
      {
        test: /\.jsx?$/,
        exclude: /node_modules/,
        loader: 'babel',
        query: {
          presets: ['react']
        }
      }
    ]
  },
  devtool: 'source-map',
  resolve: {
    extensions: ["", ".js", ".jsx"]
  }
};
