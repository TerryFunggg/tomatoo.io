const { merge }  = require('webpack-merge');
const common = require('./webpack.common.js');

module.exports = merge(common, {
  optimization: {
    minimize: true,
  },
  mode: 'production',
  devtool: 'source-map',
})
