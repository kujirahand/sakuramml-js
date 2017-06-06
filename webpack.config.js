const path = require('path')
module.exports = {
  entry: path.join(__dirname, 'src/sakura.js'),
  output: {
    path: path.join(__dirname, 'release'),
    filename: 'sakura.js'
  },
  devtool: 'inline-source-map',
  module: {
    rules: [
      {
        test: /.js$/,
        loader: 'babel-loader',
        options: {
          presets: ['es2015']
        }
      }
    ]
  }
}


