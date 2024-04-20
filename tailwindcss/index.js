const plugin = require("tailwindcss/plugin");
const wTheme = require("./src/w_theme.js");

module.exports = plugin.withOptions(
  wTheme.optionsHandler,
  wTheme.themeHandler
);
