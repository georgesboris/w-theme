import w from "./index.js";
import * as css from "./w/css.js";

/**
 * Page Themes
 * Look for theme variables on data-w-theme style elements.
 */

const themes = getThemes();

function getThemes() {
  let cssRulesets = [];

  for (let s of document.styleSheets) {
    const isTheme = "wTheme" in s.ownerNode.dataset;
    if (isTheme) { cssRulesets = cssRulesets.concat(findRulesets(s)); };
  }

  return cssRulesets.map(toThemeRecord);
}

function findRulesets(parent) {
  let acc = [];

  for (let ruleset of parent.cssRules) {
    if (ruleset.type == 1 && ruleset.style.getPropertyValue("--w-base-text")) {
      acc = acc.concat(ruleset)
    } else if (ruleset.type == 4) {
      acc = acc.concat(findRulesets(ruleset))
    }
  }

  return acc;
}

function getSelectorClass(ruleset) {
  const selectorClassRegex = /\.((\w|\d|-|_)+)($|\,|\s|\{)/;
  return selectorClassRegex.exec(ruleset.selectorText)?.[1] || "";
}

function toThemeRecord(ruleset) {
  const selectorClass = getSelectorClass(ruleset);

  const title = ruleset.style.getPropertyValue("--w-theme-id") || ruleset.selectorText;

  const colors = Object.fromEntries(
    w.colorValues.map((c) =>
      ([ruleset.style.getPropertyValue(c.css), c])
    )
  )

  const radius = Object.fromEntries(
    w.borderRadiusValues.map((c) => {
      const remValue = ruleset.style.getPropertyValue(c.css);
      const pxValue = css.remToPx(remValue);

      return [pxValue, { ...c, remValue }]
    })
  )

  const spacing = Object.fromEntries(
    w.spacingValues.map((c) => {
      const remValue = ruleset.style.getPropertyValue(c.css);
      const pxValue = css.remToPx(remValue);

      return [pxValue, { ...c, remValue }]
    })
  )

  const fonts = Object.fromEntries(
    w.fontFamilyValues.map((c) =>
      ([ruleset.style.getPropertyValue(c.css), c])
    )
  )

  return {
    selectorClass,
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

const debuggerElement = document.createElement("article");

debuggerElement.className = "w-debugger";
debuggerElement.innerHTML = `<h1 class="w-debugger-title">w-theme debugger</h1>`;

const debuggerTokenElement = document.createElement("div");
debuggerTokenElement.classList.add("w-debugger-token");

[
  ["theme", "theme"],
  ["font variant", "font"],
  ["text color", "text-color"],
  ["background", "background"],
  ["border color", "border-color"],
  ["border-radius", "border-radius"],
  ["padding", "padding"],
  ["margin", "margin"]
].forEach(([tokenLabel, token]) => {
  const tokenEl = debuggerTokenElement.cloneNode();
  tokenEl.classList.add(`w-debugger-${token}`);
  tokenEl.innerHTML = `<p>${tokenLabel}</p>`;
  debuggerElement.appendChild(tokenEl);
})

document.body.appendChild(debuggerElement);

/**
 * Debugger : Stylesheet - Base
 */

const debuggerStylesheet = document.createElement("style");

const debuggerTokensContentStyles = ["theme", "font", "text-color", "background", "border-color", "border-radius", "padding", "margin"].map(token => {
  return `.w-debugger .w-debugger-${token}::after { content: var(--w-debugger-${token}); }`
}).join(" ");

debuggerStylesheet.innerHTML = `
.w-debugger {
  visibility: var(--w-debugger-visibility, hidden);
  pointer-events: none;
  z-index: 9999;
  position: fixed;
  top: var(--w-debugger-top);
  bottom: var(--w-debugger-bottom);
  left: var(--w-debugger-left);
  right: var(--w-debugger-right);
  background: rgb(var(--w-base-bg));
  box-shadow: 0 0 8px rgba(0, 0, 0, 0.1);
  font-size: 0.8rem;
  color: rgb(var(--w-base-text));
  line-height: 1.2em;
  padding: 0;
  margin: 0.5rem;
  border-radius: var(--w-radius-sm);
}
.w-debugger-title {
  text-transform: uppercase;
  font-size: 0.6rem;
  letter-spacing: 0.1em;
  padding: 0.25rem 0.5rem;
}
.w-debugger-token { display: flex; justify-content: space-between; gap: 0.5rem; padding: 0.25rem 0.5rem; font-weight: 700; border-top: 1px solid rgb(var(--w-base-accent-subtle)); }
.w-debugger-token::after { display: block; font-weight: 400; color: rgb(var(--w-base-text-subtle)); }
${debuggerTokensContentStyles}
`;

document.body.appendChild(debuggerStylesheet);

/**
 * Debugger : Stylesheet - Variables
 */

const debuggerVariablesStylesheet = document.createElement("style");
document.body.appendChild(debuggerVariablesStylesheet);

function setDebuggerStyles(cssVars) {
  debuggerVariablesStylesheet.innerHTML = `:root{${cssVars.join(";")}}`
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

  if (theme) {
    debuggerElement.className = `w-debugger ${theme.selectorClass}`;

    debuggerStyles.push(`--w-debugger-visibility: visible`);

    const alignTop = e.clientY / window.innerHeight < 0.5;
    const alignLeft = e.clientX / window.innerWidth > 0.5;

    if (alignTop) {
      debuggerStyles.push(`--w-debugger-top: 0`);
      debuggerStyles.push(`--w-debugger-bottom: auto`);
    } else {
      debuggerStyles.push(`--w-debugger-top: auto`);
      debuggerStyles.push(`--w-debugger-bottom: 0`);
    }

    if (alignLeft) {
      debuggerStyles.push(`--w-debugger-right: auto`);
      debuggerStyles.push(`--w-debugger-left: 0`);
    } else {
      debuggerStyles.push(`--w-debugger-right: 0`);
      debuggerStyles.push(`--w-debugger-left: auto`);
    }

    debuggerStyles.push(`--w-debugger-y: ${e.clientY}px`);

    debuggerStyles.push(`--w-debugger-theme: "${theme.title}"`);
    debuggerStyles.push(`--w-debugger-font: "${theme.fonts[fontFamily]?.id || ""}"`);

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

    debuggerStyles.push(`--w-debugger-visibility: hidden`);
  }

  setDebuggerStyles(debuggerStyles);
});

function toColorDebugValue(color) {
  return color ? `${color.variant} ${color.id}` : "";
}

