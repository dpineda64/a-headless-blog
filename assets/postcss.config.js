const postcssSass = require('@csstools/postcss-sass');

module.exports = {
  syntax: 'postcss-scss',
  plugins: [
    require('postcss-import'),
    require('tailwindcss'),
    require('autoprefixer'),
    postcssSass(),
  ],
};
