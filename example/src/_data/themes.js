const wTheme = require("../../../src/theme.js");

module.exports =
  [
    {
      name: "light-theme",
      styles: wTheme.cssVariablesFromTheme({
        id: "my-light-theme",
        primary: "blue",
        secondary: "pink",
        base: "slate"
      })
    },
    {
      name: "dark-theme",
      styles: wTheme.cssVariablesFromTheme({
        id: "my-dark-theme",
        dark: true,
        primary: "blue",
        secondary: "pink",
        base: "slate"
      })
    }
  ]
