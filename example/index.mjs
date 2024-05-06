import wTheme from "/w-theme.js";

const lightTheme = wTheme.theme();
const darkTheme = wTheme.theme({ dark: true });

wTheme.setBaseStyles();
wTheme.setTheme(lightTheme, {
  class: "theme",
  darkModeTheme: darkTheme,
  darkModeClass: "dark"
});
