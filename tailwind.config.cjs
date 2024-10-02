/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./index.html", "./src/**/*.res.mjs"],
  theme: {
    extend: {
      colors: {
        'ground': '#121212',
        'surface': '#1e1e1e',
        'accent': '#353535',
        'primary': '#ffbd5a',
        'secondary': '#ffad33',
        'highlight': '#ffcc80',
        'dark': '#212529',
        'grey': '#7e7e7e',
        'error': '#d3543c'
      },
    },
  },
  plugins: [],
};
