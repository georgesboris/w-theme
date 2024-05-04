import colors from "./w/colors.js"

/**
 * @typedef Theme {
 *   id: string | null
 *   fontFamilies: FontFamilies
 *   spacing: SpacingAndBorderRadius
 *   borderRadius: SpacingAndBorderRadius
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

const DEFAULT_SANS_SERIF = `ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, "Noto Sans", sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji"`

/**
 * Generates a theme record.
 *
 * @param {{
 *   useDarkColorScheme?: bool
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
function theme(config) {
  const colorScheme = config.useDarkColorScheme ? "dark" : "light";
  const id = config.id || colorScheme;

  const fontFamilies = {
    heading: config.fontFamilies?.heading || DEFAULT_SANS_SERIF,
    text: config.fontFamilies?.text || DEFAULT_SANS_SERIF,
    code: config.fontFamilies?.code || "monospace",
  }

  const palettes = {
    base: toThemeColor(config.base || "slate", colorScheme),
    primary: toThemeColor(config.primary || "blue", colorScheme),
    secondary: toThemeColor(config.secondary || "pink", colorScheme),
    success: toThemeColor(config.success || "green", colorScheme),
    warning: toThemeColor(config.warning || "yellow", colorScheme),
    danger: toThemeColor(config.danger || "red", colorScheme),
  }

  return {
    id,
    fontFamilies,
    spacing: toThemeSpacing(config.spacing, config.spacingScale),
    radius: toThemeRadius(config.radius, config.radiusScale),
    colors: {
      light: palette.map((variant) => palettes[variant].light),
      dark: palette.map((variant) => palettes[variant].dark)
    }
  }
}

/**
 * Returns theme to the body of the document or to a specific class.
 * @param {string | ColorScale} color
 * @param {"light" | "dark"} colorScheme
 * @returns ColorScale
 */
function toThemeColor(color, colorScheme) {
  if (typeof color === "string") {
    if (!colors[color]) throw new Error("color must be a valid color name or a color scale object.")

    return colors[color][colorScheme];
  }

  return color;
}

/**
 * Returns a size scale with default spacing values and applied scale factor.
 */
function toThemeSpacing(spacing, scaleFactor) {
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
function toThemeRadius(radius, scaleFactor) {
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
 * Applies theme to the body of the document or to a specific class.
 * @param {Theme} theme
 * @param {?{
 *   class?: bool
 *   darkModeTheme?: theme
 *   darkModeClass?: bool
 *   baseStyles?: bool
 *   baseSelectors?: bool
 *   baseClassPrefix?: string
 *   baseDataPrefix?: string
 * }} options
 */
function setTheme(theme, options) {
  throw new Error("not implemented")
}

/**
 * Applies theme base styles.
 * @param {?{
 *   baseSelectors?: bool
 *   baseClassPrefix?: string
 *   baseDataPrefix?: string
 * }} options
 */
function setBaseStyles(options) {
  throw new Error("not implemented")
}

/**
 * Get the CSS definitions for a given theme.
 * @param {Theme} theme
 */
function getCSSVariables(theme) {
  throw new Error("not implemented")
}

/**
 * Get the CSS definitions for the base styles of a theme.
 * @param {?{
 *   baseSelectors?: bool
 *   baseClassPrefix?: string
 *   baseDataPrefix?: string
 * }} options
 */
function getCSSBaseStyles(options) {
  throw new Error("not implemented")
}

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
const colorSet = [
  "bg",
  "bg-subtle",
  "tint",
  "tint-subtle",
  "tint-strong",
  "accent",
  "accent-subtle",
  "accent-strong",
  "solid",
  "solid-subtle",
  "solid-strong",
  "solid-text",
  "text-subtle",
  "text",
]

/**
 * @type {{ variant: string, id: string, css: string}[]}
 */
const colorValues =
  palette.flatMap(variant =>
    colorSet.map(
      id => ({
        variant,
        id,
        css: varId(`${variant}-${id}`)
      })
    )
  )

/**
 * @type {{id: string, css: string}[]}
 */
const fontValues =
  ["heading", "text", "code"].map(id => ({
    id,
    css: varId(`font-${id}`)
  }))

/**
 * @type {{id: string, css: string}[]}
 */
const radiusValues =
  ["xs", "sm", "md", "lg", "xl", "2xl", "3xl"].map(id => ({
    id,
    css: varId(`radius-${id}`)
  }))


/**
 * @type {{id: string, css: string}[]}
 */
const spacingValues =
  ["xs", "sm", "md", "lg", "xl", "2xl", "3xl"].map(id => ({
    id,
    css: varId(`spacing-${id}`)
  }))

/**
 * Helpers
 */

function varId(id) {
  return `--w-${id}`;
}

/**
 * Exports
 */

export default {
  theme,
  setTheme,
  setBaseStyles,
  getCSSVariables,
  getCSSBaseStyles,
  colorSet,
  colorValues,
  fontValues,
  palette,
  radiusValues,
  spacingValues,
};

