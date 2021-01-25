const path = require('path');

module.exports = {
   entry: {
     app: './src/index.js',
   },
   plugins: [],
  output: {
    path: path.resolve(__dirname, 'public'),
    filename: "app.bundle.js"
  },
  optimization: {
    minimize: true,
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
    ]
  },
};
