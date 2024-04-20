/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./dist/**/*.html"],
  plugins: [require("../tailwindcss")({ strict: true, useSpacing: true, strictSpacing: true })],
}

