/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./dist/**/*.html"],
  plugins: [
    require("w-theme/tailwindcss")({
      strict: true,
      useSpacing: true,
      strictSpacing: true,
      colorComponents: true
    })
  ],
}

