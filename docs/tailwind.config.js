/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./index.html", "./src/**/*.gleam"],
  plugins: [
    require("w-theme/tailwindcss")({
      strict: true,
      useSpacing: true,
      strictSpacing: true,
      colorComponents: true
    })
  ],
}

