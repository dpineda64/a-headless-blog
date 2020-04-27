const { colors } = require('tailwindcss/defaultTheme');

module.exports = {
  theme: {
    colors: {
      ...colors,
      primary: 'var(--color-primary)',
    },
  },
};
