const path = require("path");

module.exports = {
  entry: {
    app: "./src/index.js",
  },
  plugins: [],
  output: {
    path: path.resolve(__dirname, "public"),
    filename: "app.bundle.js",
  },
  module: {
    rules: [
      {
        test: /\.coffee$/,
        loader: "coffee-loader",
      },
      {
        test: /\.s[ac]ss$/i,
        use: ["style-loader", "css-loader", "sass-loader"],
      },
      {
        test: /\.(png|svg|jpg|jpeg|gif)$/i,
        type: "asset/resource",
      },
      {
        test: /\.(mp3|wav|mpe?g|ogg)$/i,
        loader: "file-loader",
        options: {
          name: "[path][name].[ext]",
        },
      },
    ],
  },
};
