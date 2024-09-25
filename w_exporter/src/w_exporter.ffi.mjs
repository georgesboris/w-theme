// ----------------------------------------------------------------------------

export function debugJson(input) {
  console.log(JSON.parse(input))
}

// ----------------------------------------------------------------------------

export function queryThemes() {
  const themes = getThemes();

  console.log(themes);

  return themes;
}

// ----------------------------------------------------------------------------

export function downloadJson(filename, data) {
  // const bytes = new TextEncoder().encode(data);
  const blob = new Blob([data], { type: "application/json" })
  const url = URL.createObjectURL(blob);
  const a = document.createElement("a");

  a.href = url;
  a.download = `${filename}.json`;
  a.click();

  setTimeout(() => { URL.revokeObjectURL(url); });
}

// ----------------------------------------------------------------------------

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
    if (ruleset.type == 1 && ruleset.style.getPropertyValue("--w-id")) {
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
  const id = ruleset.style.getPropertyValue("--w-theme-id") || "theme";

  const colors =
    palette.map(variant =>
    ({
      variant: variant,
      colorScale: colorScale.map(color => ({
        color: color,
        value: ruleset.style.getPropertyValue(varId(`${variant}-${color}`))
      }))
    }))

  const radius = borderRadiusValues.map((c) => {
    const remValue = ruleset.style.getPropertyValue(c.cssId);
    return { radius: c.id, value: remToPx(remValue) };
  })

  const spacing = spacingValues.map((c) => {
    const remValue = ruleset.style.getPropertyValue(c.cssId);
    return { spacing: c.id, value: remToPx(remValue) };
  })
  const sizing = sizingValues.map((c) => {
    const remValue = ruleset.style.getPropertyValue(c.cssId);
    return { sizing: c.id, value: remToPx(remValue) };
  })

  const fonts = fontFamilyValues.map((c) => ({
    font: c.id,
    value: ruleset.style.getPropertyValue(c.cssId)
  }))

  return {
    id,
    colors,
    radius,
    spacing,
    sizing,
    fonts
  }
}

// ---------------------------------------------------------------------------
// Constants
// ---------------------------------------------------------------------------

const FONT_FAMILIES = ["heading", "text", "code"];

const SIZE_SCALE = ["xs", "sm", "md", "lg", "xl", "2xl", "3xl"]


// ---------------------------------------------------------------------------
// Tokens
// ---------------------------------------------------------------------------

/**
 * ```
 *   [
 *     {id: "heading", cssId: "--w-font-heading", cssVar: "var(--w-font-heading)"},
 *     ...
 *   ]
 * ```
 *
 * @type {{id: string, cssId: string, cssVar: string}[]}
 */
const fontFamilyValues = FONT_FAMILIES.map(id => ({ id, cssId: varId(`font-${id}`), cssVar: cssVar(`font-${id}`) }))


/**
 * ```
 *   [
 *     {id: "xs", cssId: "--w-radius-xs", cssVar: "var(--w-radius-xs)"},
 *     ...
 *   ]
 * ```
 *
 * @type {{id: string, cssId: string, cssVar: string}[]}
 */
const borderRadiusValues = SIZE_SCALE.map(id => ({ id, cssId: varId(`radius-${id}`), cssVar: cssVar(`radius-${id}`) }))


/**
 * ```
 *   [
 *     {id: "xs", cssId: "--w-spacing-xs", cssVar: "var(--w-spacing-xs)"},
 *     ...
 *   ]
 * ```
 *
 * @type {{id: string, cssId: string, cssVar: string}[]}
 */
const spacingValues = SIZE_SCALE.map(id => ({ id, cssId: varId(`spacing-${id}`), cssVar: cssVar(`spacing-${id}`) }))

/**
 * ```
 *   [
 *     {id: "xs", cssId: "--w-sizing-xs", cssVar: "var(--w-sizing-xs)"},
 *     ...
 *   ]
 * ```
 *
 * @type {{id: string, cssId: string, cssVar: string}[]}
 */
const sizingValues = SIZE_SCALE.map(id => ({ id, cssId: varId(`sizing-${id}`), cssVar: cssVar(`sizing-${id}`) }))

/**
 * @type {string[]}
 */
const palette = [
  "base",
  "primary",
  "secondary",
  "success",
  "warning",
  "danger"
];

/**
 * @type {string[]}
 */
const colorScale = [
  "shadow",
  "bg",
  "bg-subtle",
  "tint-subtle",
  "tint",
  "tint-strong",
  "accent-subtle",
  "accent",
  "accent-strong",
  "solid-subtle",
  "solid",
  "solid-strong",
  "solid-text",
  "text-subtle",
  "text",
]

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

/**
 * Turns a rem string "1.25rem" into a px string "20px"
 */

function remToPx(remString) {
  const remSize = getRemSize();
  const pxValue = parseFloat(remString) * remSize;

  return `${pxValue}px`;
}

/**
 * Helpers
 */

function varId(id) {
  return `--w-${id}`;
}

function cssVar(id) {
  return `var(${varId(id)})`;
}
