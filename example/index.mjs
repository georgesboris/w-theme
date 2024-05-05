import wTheme from "/w-theme.js";

const lightTheme = wTheme.theme();
const darkTheme = wTheme.theme({ dark: true });

wTheme.setTheme(lightTheme, {darkModeTheme: darkTheme});
