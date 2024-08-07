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
 *   base: string
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

const FONT_FAMILIES = ["heading", "base", "code"];

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
 *     base?: string
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
    base: config.fontFamilies?.base || DEFAULT_SANS_SERIF,
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

// ---------------------------------------------------------------------------
// Using Themes
// ---------------------------------------------------------------------------

/**
 * Applies theme to the body of the document or to a specific class.
 * @param {Theme} theme
 * @param {?{
 *   class?: bool
 *   darkModeTheme?: theme
 *   darkModeClass?: bool
 * }} options
 */
function setTheme(theme, options) {
  let styles = "";

  styles +=
    options?.class
      ? `.${options.class} { ${getCSSDefinitions(theme)} }`
      : `body { ${getCSSDefinitions(theme)} }`;

  styles +=
    options?.class
      ? getThemeBaseStyles(`.${options.class}`)
      : getThemeBaseStyles("body");

  if (options?.darkModeTheme) {
    styles +=
      (options.darkModeClass)
        ? options.class
          ? ` .${options.darkModeClass} .${options.class}, .${options.class}.${options.darkModeClass} { ${getCSSDefinitions(options.darkModeTheme)} }`
          : `body.${options.darkModeClass} { ${getCSSDefinitions(options.darkModeTheme)} }`
        : `@media (prefers-color-scheme: dark) { body { ${getCSSDefinitions(options.darkModeTheme)} } }`
  }

  appendStyleElement(styles, (el) => el.setAttribute("data-w-theme", true));
}


function getThemeBaseStyles(prefix) {
 return `
${prefix} {
  background-color: ${cssRGB("base-bg")};
  color: ${cssRGB("base-text")};
  font-family: ${cssVar("font-base")};
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
  background: ${cssRGB("base-text")};
  color: ${cssRGB("base-bg")};
}
`;
}

/**
 * Applies theme base styles.
 * @param {?{
 *   base?: bool,
 *   selectors?: bool
 * }} options
 */
function setBaseStyles(options) {
  appendStyleElement(getCSSBaseStyles(options));
}

/**
 * Get the CSS definitions for a given theme.
 * @param {Theme} theme
 */
function getCSSDefinitions(theme) {
  return [
    themeIdAndColorSchemeVars(theme),
    toCssVars(fontFamilyValues, theme.fontFamilies),
    toCssVars(spacingValues, theme.spacing),
    toCssVars(borderRadiusValues, theme.borderRadius),
    toCssVarsWithVariants(colorValues, theme.colors)
  ]
    .flat()
    .map(([k, v]) => k + ":" + v)
    .join(";")
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

function toCssVarsWithVariants(values, themeValues) {
  return values.map(({ variant, id, cssId }) => {
    return [cssId, themeValues[variant][id]];
  });
}

/**
 * Get the CSS definitions for the base styles of a theme.
 * @param {?{
 *   base?: bool,
 *   selectors?: bool
 * }} options
 */
function getCSSBaseStyles(options) {
  const setBase = options?.base ?? true;
  const setSelectors = options?.selectors ?? true;

  let styles = [];

  if (setBase) {
    styles = styles.concat(
      [
        "body {",
        `  background: ${cssRGB("base-bg")};`,
        `  color: ${cssRGB("base-text")};`,
        `  font-family: ${cssVar("font-base")};`,
        "}",
        "h1, h2, h3, h4, h5, h6 {",
        `  font-family: ${cssVar("font-heading")};`,
        "}",
        "code {",
        `  font-family: ${cssVar("font-code")};`,
        "}"
      ]
    )
  }

  if (setSelectors) {
    palette.forEach((variant) => {
      styles = styles.concat([
        `.${NAMESPACE}\\/${variant} {`,
        `  backgroundColor: ${rawColorCssVar(`${variant}-tint`)};`,
        `  borderColor: ${rawColorCssVar(`${variant}-nt`)};`,
        `  color: ${rawColorCssVar(`${variant}-text`)};`,
        "}",
        `.${NAMESPACE}\\/${variant}:is(a,button):is(:hover) {`,
        `  backgroundColor: ${rawColorCssVar(`${variant}-tint-strong`)};`,
        `  borderColor: ${rawColorCssVar(`${variant}-nt-strong`)};`,
        "}",
        `.${NAMESPACE}\\/${variant}:is(a,button):is(:active) {`,
        `  backgroundColor: ${rawColorCssVar(`${variant}-tint-subtle`)};`,
        `  borderColor: ${rawColorCssVar(`${variant}-nt-subtle`)};`,
        `  color: ${rawColorCssVar(`${variant}-text-subtle`)};`,
        "}",
        `.${NAMESPACE}\\/${variant}.${NAMESPACE}\\/solid {`,
        `  backgroundColor: ${rawColorCssVar(`${variant}-solid`)};`,
        `  color: ${rawColorCssVar(`${variant}-solid-text`)};`,
        "}",
        `.${NAMESPACE}\\/${variant}.${NAMESPACE}\\/solid:is(a,button):is(:hover) {`,
        `  backgroundColor: ${rawColorCssVar(`${variant}-solid-strong`)}`,
        "}",
        `.${NAMESPACE}\\/${variant}.${NAMESPACE}\\/solid:is(a,button):is(:active) {`,
        `  backgroundColor: ${rawColorCssVar(`${variant}-solid-subtle`)};`,
        `  color: ${rawColorCssVarWithAlpha(`${variant}-solid-text`, 0.8)};`,
        "}",
        `.${NAMESPACE}\\/${variant}:is(a,button):is(:focus-visible) {`,
        `  outline: 2px solid transparent;`,
        `  outlineOffset: 2px;`,
        `  boxShadow: 0 0 0 1px ${rawColorCssVar("base-bg")}, 0 0 0 calc(9px) ${rawColorCssVar(`${variant}-solid-subtle`)};`,
        `}`
      ]);
    });
  }

  return styles.join("");
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
  setBaseStyles,
  getCSSDefinitions,
  getCSSBaseStyles,
  colorScale,
  colorValues,
  fontFamilyValues,
  palette,
  borderRadiusValues,
  spacingValues,
};

