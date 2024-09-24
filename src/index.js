import colors from "./w/colors.js"

/**
 * @typedef Theme {
 *   id: string | null
 *   colorScheme: "light" | "dark"
 *   fontFamilies: FontFamilies
 *   spacing: SizeScale
 *   borderRadius: SizeScale
 *   colors: ColorPalette
 * }
 *
 * @typedef FontFamilies {
 *   heading: string
 *   text: string
 *   code: string
 * }
 *
 * @typedef ColorPalette {
 *    base: ColorScale
 *    primary: ColorScale
 *    secondary: ColorScale
 *    success: ColorScale
 *    warning: ColorScale
 *    danger: ColorScale
 * }
 *
 * @typedef ColorScale {
 *   bg: string
 *   bg-subtle: string
 *   tint: string
 *   tint-subtle: string
 *   tint-strong: string
 *   accent: string
 *   accent-subtle: string
 *   accent-strong: string
 *   solid: string
 *   solid-subtle: string
 *   solid-strong: string
 *   solid-text: string
 *   text-subtle: string
 *   text: string
 *   shadow: string
 * }
 *
 * @typedef SizeScale {
 *    xs: string
 *    sm: string
 *    md: string
 *    lg: string
 *    xl: string
 *    2xl: string
 *    3xl: string
 * }
 *
 */


// ---------------------------------------------------------------------------
// Constants
// ---------------------------------------------------------------------------

const DEFAULT_SANS_SERIF = `ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, "Noto Sans", sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji"`

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

/**
 * @type {{ variant: string, id: string, cssId: string, cssVar: string}[]}
 */
const colorValues =
  palette.flatMap(variant =>
    colorScale.map(
      id => ({
        variant,
        id,
        cssId: varId(`${variant}-${id}`),
        cssVar: cssVar(`${variant}-${id}`)
      })
    )
  )


// ---------------------------------------------------------------------------
// Creating Themes
// ---------------------------------------------------------------------------

/**
 * Generates a theme record.
 *
 * @param {{
 *   dark?: bool
 *   primary?: string | ColorScale
 *   secondary?: string | ColorScale
 *   base?: string | ColorScale
 *   success?: string | ColorScale
 *   warning?: string | ColorScale
 *   danger?: string | ColorScale
 *   fontFamilies?: {
 *     heading?: string
 *     text?: string
 *     code?: string
 *   }
 *   spacingScale?: number
 *   spacing?: {
 *    xs?: string
 *    sm?: string
 *    md?: string
 *    lg?: string
 *    xl?: string
 *    2xl?: string
 *    3xl?: string
 *   }
 *   sizingScale?: number
 *   sizing?: {
 *    xs?: string
 *    sm?: string
 *    md?: string
 *    lg?: string
 *    xl?: string
 *    2xl?: string
 *    3xl?: string
 *   }
 *   borderRadiusScale?: number
 *   borderRadius?: {
 *    xs?: string
 *    sm?: string
 *    md?: string
 *    lg?: string
 *    xl?: string
 *    2xl?: string
 *    3xl?: string
 *   }
 * }} config
 *
 * @returns Theme
 */
function theme(config = {}) {
  const colorScheme = config.dark ? "dark" : "light";
  const id = config.id || colorScheme;

  const fontFamilies = {
    heading: config.fontFamilies?.heading || DEFAULT_SANS_SERIF,
    text: config.fontFamilies?.text || DEFAULT_SANS_SERIF,
    code: config.fontFamilies?.code || "monospace",
  };

  const colors = {
    base: toThemeColor(config.base || "slate", colorScheme),
    primary: toThemeColor(config.primary || "blue", colorScheme),
    secondary: toThemeColor(config.secondary || "pink", colorScheme),
    success: toThemeColor(config.success || "green", colorScheme),
    warning: toThemeColor(config.warning || "yellow", colorScheme),
    danger: toThemeColor(config.danger || "red", colorScheme),
  };

  return {
    id,
    colorScheme,
    fontFamilies,
    sizing: toThemeSizing(config.sizing, config.sizingScale),
    spacing: toThemeSpacing(config.spacing, config.spacingScale),
    borderRadius: toThemeRadius(config.radius, config.radiusScale),
    colors
  };
}

/**
 * Returns theme to the body of the document or to a specific class.
 * @param {string | ColorScale} color
 * @param {"light" | "dark"} colorScheme
 * @returns ColorScale
 */
function toThemeColor(color, colorScheme) {
  if (typeof color === "string") {
    if (!colors[colorScheme][color]) throw new Error("color must be a valid color name or a color scale object.")

    return mapValues(colors[colorScheme][color].channels, (([r, g, b]) => `${r} ${g} ${b}`))
  }

  return color;
}


/**
 * Returns a size scale with default spacing values and applied scale factor.
 */
function toThemeSpacing(spacing = {}, scaleFactor) {
  const scale = scaleFactor ?? 1.0;

  return {
    "xs": spacing.xs || `${0.25 * scale}rem`,
    "sm": spacing.sm || `${0.5 * scale}rem`,
    "md": spacing.md || `${0.75 * scale}rem`,
    "lg": spacing.lg || `${1 * scale}rem`,
    "xl": spacing.xl || `${1.5 * scale}rem`,
    "2xl": spacing["2xl"] || `${2.5 * scale}rem`,
    "3xl": spacing["3xl"] || `${4 * scale}rem`,
  }
}

/**
 * Returns a size scale with default radius values and applied scale factor.
 */
function toThemeRadius(radius = {}, scaleFactor) {
  const scale = scaleFactor ?? 1.0;
  return {
    "xs": radius["xs"] || `${0.125 * scale}rem`,
    "sm": radius["sm"] || `${0.25 * scale}rem`,
    "md": radius["md"] || `${0.375 * scale}rem`,
    "lg": radius["lg"] || `${0.5 * scale}rem`,
    "xl": radius["xl"] || `${0.75 * scale}rem`,
    "2xl": radius["2xl"] || `${1 * scale}rem`,
    "3xl": radius["3xl"] || `${1.5 * scale}rem`,
  }
}

/**
 * Returns a size scale with default spacing values and applied scale factor.
 */
function toThemeSizing(sizing = {}, scaleFactor) {
  const scale = scaleFactor ?? 1.0;
  return {
    "xs": sizing["xs"] || `${16 * scale}rem`,
    "sm": sizing["sm"] || `${20 * scale}rem`,
    "md": sizing["md"] || `${24 * scale}rem`,
    "lg": sizing["lg"] || `${36 * scale}rem`,
    "xl": sizing["xl"] || `${48 * scale}rem`,
    "2xl": sizing["2xl"] || `${64 * scale}rem`,
    "3xl": sizing["3xl"] || `${80 * scale}rem`,
  }
}

// ---------------------------------------------------------------------------
// Using Themes
// ---------------------------------------------------------------------------

/**
 * Applies a theme to the body of the document or to a specific class.
 * Optionally also applies a dark theme based on a class or system preferences.
 * @param {Theme} theme
 * @param {?{
 *   class?: bool
 *   darkModeTheme?: theme
 *   darkModeClass?: bool
 * }} options
 */

function setTheme(theme, options) {
  appendStyleElement(
    getThemeCSS(theme, options),
    (el) => el.setAttribute("data-w-theme", true)
  );
}

/**
 * Gets the CSS definitions for a given theme and its display options.
 * @param {Theme} theme
 * @param {?{
 *   class?: bool
 *   darkModeTheme?: theme
 *   darkModeClass?: bool
 * }} options
 */

function getThemeCSS(theme, options) {
  let styles = "";

  styles +=
    options?.class
      ? getThemeRootCSS(`.${options.class}`)
      : getThemeRootCSS("body");

  styles +=
    options?.class
      ? `.${options.class} { ${getThemeBaseCSS(theme)} ${getThemeColorsCSS(theme)} }`
      : `body { ${getThemeBaseCSS(theme)} ${getThemeColorsCSS(theme)} }`;

  if (options?.darkModeTheme) {
    styles +=
      (options.darkModeClass)
        ? options.class
          ? ` .${options.darkModeClass} .${options.class}, .${options.class}.${options.darkModeClass} { ${getThemeColorsCSS(options.darkModeTheme)} }`
          : `body.${options.darkModeClass} { ${getThemeColorsCSS(options.darkModeTheme)} }`
        : `@media (prefers-color-scheme: dark) { body { ${getThemeColorsCSS(options.darkModeTheme)} } }`
  }

  return styles
}


function getThemeRootCSS(prefix) {
  return `
${prefix} {
  background-color: ${cssRGB("bg")};
  color: ${cssRGB("text")};
  font-family: ${cssVar("font-text")};
}
${prefix} h1,
${prefix} h2,
${prefix} h3,
${prefix} h4,
${prefix} h5,
${prefix} h6 {
  font-family: ${cssVar("font-heading")};
}
${prefix} code,
${prefix} kbd,
${prefix} samp,
${prefix} pre {
  font-family: ${cssVar("font-code")};
}
${prefix} ::selection {
  background: ${cssRGB("text")};
  color: ${cssRGB("bg")};
}
`;
}


/**
 * Get the CSS definitions for a given theme.
 * @param {Theme} theme
 */
function getThemeBaseCSS(theme) {
  return [
    themeIdAndColorSchemeVars(theme),
    toCssVars(fontFamilyValues, theme.fontFamilies),
    toCssVars(spacingValues, theme.spacing),
    toCssVars(sizingValues, theme.sizing),
    toCssVars(borderRadiusValues, theme.borderRadius),
  ]
    .flat()
    .map(([k, v]) => `${k}: ${v};`)
    .join("");
}

/**
 * Get the CSS definitions for a given theme colors.
 * @param {Theme} theme
 */
function getThemeColorsCSS(theme) {
  const baseVariant = colorScale.reduce((acc, color) => {
    return `${acc} ${varId(color)}: ${cssVar(`base-${color}`)};`;
  }, "--w-color: base;");

  return colorValues.reduce((acc, { variant, id, cssId }) => {
    return `${acc} ${cssId}: ${theme.colors[variant][id]};`;
  }, baseVariant);
}

function themeIdAndColorSchemeVars(theme) {
  return [
    ["color-scheme", theme.colorScheme],
    [varId("id"), theme.id],
  ];
}

function toCssVars(values, themeValues) {
  return values.map(({ id, cssId }) => [cssId, themeValues[id]]);
}

/**
 * Applies theme components styles.
 * @param {?{
 *   base?: bool,
 *   selectors?: bool
 * }} options
 */
function setThemeComponents(options) {
  appendStyleElement(getThemeComponentsCSS(options));
}

/**
 * Get the CSS definitions for w-theme components.
 */

function getThemeComponentsCSS() {
  let styles = [];

  /**
   * .w/{variant}
   */

  palette.forEach((variant) => {
    styles = styles.push(`${wClass(variant)} {`);
    styles = styles.push(`--w-color: ${variant};`);
    styles = styles.concat(colorScale.map((color) =>
      `  ${varId(color)}: ${cssVar(`${variant}-${color}`)};`,
    ))
    styles = styles.push(`color: ${cssRGB("text")};`);
    styles = styles.push("}");
  });

  /**
   * .w/tint
   */

  styles = styles.concat([
    `${wClass("tint")} {`,
    `  background-color: ${cssRGB("tint")};`,
    "}"
      `${wClass("tint")}:is(a,button):is(:hover) {`,
    `  background-color: ${cssRGB("tint-strong")};`,
    "}"
      `${wClass("tint")}:is(a,button):is(:active) {`,
    `  background-color: ${cssRGB("tint-subtle")};`,
    "}"
  ])

  /**
   * .w/solid
   */

  styles = styles.concat([
    `${wClass("solid")} {`,
    `  background-color: ${cssRGB("solid")};`,
    `  color: ${cssRGB("solid-text")} !important;`,
    "}"
      `${wClass("solid")}:is(a,button):is(:hover) {`,
    `  background-color: ${cssRGB("solid-strong")};`,
    "}"
      `${wClass("solid")}:is(a,button):is(:active) {`,
    `  background-color: ${cssRGB("solid-subtle")};`,
    "}"
  ])

  /**
   * .w/focus
   */

  styles = styles.concat([
    `${wClass("tint")}:is(a,button):is(:focus-visible), `,
    `${wClass("solid")}:is(a,button):is(:focus-visible), `,
    `${wClass("focus")}:is(:focus-visible) {`,
    `  outline: 2px solid transparent;`,
    `  outline-offset: 2px;`,
    `  box-shadow: 0 0 0 1px ${cssRGB("bg")}, 0 0 0 4px ${cssRGB(`accent-subtle`)};`,
    "}"
  ])

  return styles.join("");
}


/**
 * Helpers
 */

function wClass(v) {
  `.${NAMESPACE}\/${v}`
}

function varId(id) {
  return `--w-${id}`;
}

function cssVar(id) {
  return `var(${varId(id)})`;
}

function cssRGB(id) {
  return `rgb(var(${varId(id)}))`;
}

/**
 * Append a `style` element to the body of the document.
 *
 * @param {string} content - the inner text of the style element.
 * @param {function} mapper - a mapping function that can be used to mutate the element before appending.
 */
function appendStyleElement(content, mapper) {
  let styleEl = document.createElement("style")
  styleEl.innerText = content;
  if (mapper) { mapper(styleEl); }
  document.body.appendChild(styleEl);
}

function mapValues(obj, fn) {
  const entries = Object.entries(obj)
    .map(([k, v]) => [k, fn(v, k)])

  return Object.fromEntries(entries);
}

/**
 * Exports
 */

export default {
  theme,
  setTheme,
  getThemeCSS,
  setThemeComponents,
  getThemeComponentsCSS,
  colorScale,
  colorValues,
  fontFamilyValues,
  palette,
  borderRadiusValues,
  spacingValues,
  sizingValues,
};

