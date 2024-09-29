/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./index.html", "./src/**/*.res.mjs"],
  theme: {
    extend: {
      colors: {
        'ground': '#121212',
        'surface': '#1e1e1e',
        'accent': '#353535',
      },
    },
  },
  plugins: [],
};
