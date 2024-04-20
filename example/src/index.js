import w from "/w-theme.js";

/**
 * Helpers : Rem Size
 */

let remSizeCache;

function getRemSize() {
  if (!remSizeCache) {
    const htmlElement = document.querySelector("html");
    const htmlStyles = window.getComputedStyle(htmlElement);
    const pxSize = htmlStyles.getPropertyValue("font-size");
    remSizeCache = parseFloat(pxSize);
  }

  return remSizeCache;
}

function remToPx(remString) {
  const remSize = getRemSize();
  const pxValue = parseFloat(remString) * remSize;

  return `${pxValue}px`;
}

/**
 * Page Themes
 * Look for theme variables on data-w-theme style elements.
 */

const themes = getThemes();

function getThemes() {
  let cssRulesets = [];

  for (let s of document.styleSheets) {
    const isTheme = "wTheme" in s.ownerNode.dataset;

    if (!isTheme) continue;

    for (let ruleset of s.cssRules) {
      if (ruleset.style.getPropertyValue("--w-base-text")) {
        cssRulesets.push(ruleset)
      }
    }
  }

  return cssRulesets.map(toThemeRecord);
}

function toThemeRecord(ruleset) {
  const title = ruleset.selectorText;

  const colors = Object.fromEntries(
    w.colorValues.map((c) =>
      ([ruleset.style.getPropertyValue(c.css), c])
    )
  )

  const radius = Object.fromEntries(
    w.radiusValues.map((c) => {
        const remValue = ruleset.style.getPropertyValue(c.css);
        const pxValue = remToPx(remValue);

        return [pxValue, { ...c, remValue }]
    })
  )

  const spacing = Object.fromEntries(
    w.spacingValues.map((c) => {
      const remValue = ruleset.style.getPropertyValue(c.css);
      const pxValue = remToPx(remValue);

      return [pxValue, { ...c, remValue }]
    })
  )

  const fonts = Object.fromEntries(
    w.fontValues.map((c) =>
      ([ruleset.style.getPropertyValue(c.css), c])
    )
  )

  return {
    title,
    colors,
    radius,
    spacing,
    fonts
  }
}

/**
 * Helpers : Color Channels
 */

const colorChannelsRegex = /^rgba?\((?<r>\d{1,3})\,\s*(?<g>\d{1,3})\,\s*(?<b>\d{1,3})/;

function toColorChannels(value) {
  const channels = colorChannelsRegex.exec(value)?.groups;

  if (channels) {
    return `${channels.r} ${channels.g} ${channels.b}`;
  } else {
    return ""
  }
}

/**
 * Debugger : Setup
 */

const debuggerElement = document.createElement("div");

debuggerElement.className = "w-debugger";
debuggerElement.style.display = "var(--w-debugger-display, hidden)";
debuggerElement.style.position = "fixed";
debuggerElement.style.pointerEvents = "none";
debuggerElement.style.top = "var(--w-debugger-y)";
debuggerElement.style.left = "var(--w-debugger-x)";
debuggerElement.style.transform = "translateX(-50%)";
debuggerElement.style.overflow = "visible";

const debuggerTokenElement = document.createElement("div");
debuggerTokenElement.classList.add("w-debugger-token");

[
  "theme",
  "font-family",
  "text-color",
  "background",
  "border-color",
  "border-radius",
  "padding",
  "margin"
].forEach(token => {
  const tokenEl = debuggerTokenElement.cloneNode();
  tokenEl.classList.add(`w-debugger-${token}`);
  tokenEl.innerHTML = `${token}: `;
  debuggerElement.appendChild(tokenEl);
})

document.body.appendChild(debuggerElement);

/**
 * Debugger : Stylesheet
 */

const debuggerStylesheet = document.createElement("style");

debuggerStylesheet.id = "w-debugger-styles";

document.body.appendChild(debuggerStylesheet);

function setDebuggerStyles(cssVars) {
  const baseStyles = `
    .w-debugger { padding: 8px; z-index: 9999; background: #fff; box-shadow: 0 0 8px rgba(0, 0, 0, 0.1); font-size: 0.8rem; }
    .w-debugger-token { font-weight: 700; }
    .w-debugger-token::after { display: inline-block; font-weight: 400; }
  `;

  const cssVarStyles = `:root{${cssVars.join(";")}}`;

  const contentStyles = [
    "theme",
    "font-family",
    "text-color",
    "background",
    "border-color",
    "border-radius",
    "padding",
    "margin"
  ].map(token => {
    return `.w-debugger .w-debugger-${token}::after { content: var(--w-debugger-${token}); }`
  }).join(" ")

  console.log(contentStyles)

  debuggerStylesheet.innerHTML = `${cssVarStyles} ${contentStyles} ${baseStyles}`
}

/**
 * Debugger : Element Hover
 */

window.addEventListener("mouseover", function(e) {
  const elementStyles = window.getComputedStyle(e.target);

  /**
   * For each known attribute, check if value matches any of the themes, if so we can assume we're using that theme.
   * For each known attribute we verify if the chosen theme is in fact valid, if any property mismatches we can decide based on amount of matches.
   *  e.g. If we're using 5 matching values of theme A and only 1 value matching theme B we're probably using theme A and using a color from themeB in a custom way.
   */

  const fontFamily = elementStyles.getPropertyValue("font-family");

  const textColor = elementStyles.getPropertyValue("color");
  const textColorChannels = textColor && toColorChannels(textColor);

  const background = elementStyles.getPropertyValue("background");
  const backgroundChannels = background && toColorChannels(background);

  const borderColor = elementStyles.getPropertyValue("border-color");
  const borderColorChannels = background && toColorChannels(borderColor);

  const borderRadius = elementStyles.getPropertyValue("border-radius");

  const paddingTop = elementStyles.getPropertyValue("padding-top");
  const paddingLeft = elementStyles.getPropertyValue("padding-left");
  const paddingRight = elementStyles.getPropertyValue("padding-right");
  const paddingBottom = elementStyles.getPropertyValue("padding-bottom");

  const marginTop = elementStyles.getPropertyValue("margin-top");
  const marginLeft = elementStyles.getPropertyValue("margin-left");
  const marginRight = elementStyles.getPropertyValue("margin-right");
  const marginBottom = elementStyles.getPropertyValue("margin-bottom");

  let debuggerStyles = [];

  /**
   * Set debugger position based on e.target client position and size.
   * --w-debugger-x
   * --w-debugger-y
   */


  /**
   * Set debugger values and show them all through CSS variables
   * TODO: We should choose a theme based on a more holistic logistic, instead of just checking for text color.
   *
   * --w-debugger-theme
   * --w-debugger-font-family
   * --w-debugger-text-color-variant
   * --w-debugger-background-variant
   * --w-debugger-border-color-variant
   * --w-debugger-border-radius-id
   * --w-debugger-padding-top
   * --w-debugger-padding-left
   * --w-debugger-padding-right
   * --w-debugger-padding-bottom
   * --w-debugger-margin-top
   * --w-debugger-margin-left
   * --w-debugger-margin-right
   * --w-debugger-margin-bottom
   */

  const theme = themes.find(t => t.colors[textColorChannels]);

  console.log(e)

  if (theme) {
    debuggerStyles.push(`--w-debugger-display: block`);
    debuggerStyles.push(`--w-debugger-x: ${e.clientX}px`);
    debuggerStyles.push(`--w-debugger-y: ${e.clientY}px`);

    debuggerStyles.push(`--w-debugger-theme: "${theme.title}"`);
    debuggerStyles.push(`--w-debugger-font-family: "${theme.fonts[fontFamily]?.id || ""}"`);

    debuggerStyles.push(`--w-debugger-text-color: "${toColorDebugValue(theme.colors[textColorChannels])}"`);
    debuggerStyles.push(`--w-debugger-background: "${toColorDebugValue(theme.colors[backgroundChannels])}"`);
    debuggerStyles.push(`--w-debugger-border-color: "${toColorDebugValue(theme.colors[borderColorChannels])}"`);

    debuggerStyles.push(`--w-debugger-border-radius: "${theme.spacing[borderRadius]?.id || ""}"`);

    const themePadding =
      [paddingTop, paddingLeft, paddingRight, paddingBottom]
        .map(v => theme.spacing[v]?.id || "")
        .join(" ")

    
    const themeMargin =
      [marginTop, marginLeft, marginRight, marginBottom]
        .map(v => theme.spacing[v]?.id || "")
        .join(" ")

    debuggerStyles.push(`--w-debugger-padding: "${themePadding}"`);
    debuggerStyles.push(`--w-debugger-margin: "${themeMargin}"`);
  } else {

    debuggerStyles.push(`--w-debugger-display: hidden`);
  }

  setDebuggerStyles(debuggerStyles);
});

function toColorDebugValue(color) {
  return color ? `${color.variant} ${color.id}` : "";
}

