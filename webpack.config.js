module.exports = {
  mode: 'development',
  entry: [
    './src/index.js'
  ],
  devtool: 'inline-source-map',
  devServer: {
    contentBase: './public',
  },
  output: {
    path: __dirname + '/public',
    filename: "app.bundle.js"
  },
  module: {
    rules: [
      {
        test: /\.coffee$/,
        loader: 'coffee-loader',
      },
      {
        test: /\.s[ac]ss$/i,
        use: [ "style-loader", "css-loader", "sass-loader"],
      },
      {
        test: /\.(png|svg|jpg|jpeg|gif)$/i,
        type: 'asset/resource',
      },
      // {
      //   test: /\.js$/,
      //   exclude: /node_modules/,
      //   use: {
      //     loader: "babel-loader"
      //   }
      // }
    ]
  },
  // plugins: []
};
