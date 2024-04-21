/**
 * @typedef Theme {
 *   id: string | null
 *   fontFamilies: FontFamilies
 *   spacing: SpacingAndBorderRadius
 *   borderRadius: SpacingAndBorderRadius
 *   colors: {
 *     light: ColorPalette
 *     dark: ColorPalette
 *   }
 * }
 *
 * @typedef FontFamilies {
 *   heading: string
 *   text: string
 *   code: string
 * }
 *
 *
 * @typedef ColorPalette {
 *    base: ColorSpec
 *    primary: ColorSpec
 *    secondary: ColorSpec
 *    success: ColorSpec
 *    warning: ColorSpec
 *    danger: ColorSpec
 * }
 *
 * @typedef ColorSpec {
 *   bg: string
 *   bg-subtle: string
 *   tint: string
 *   tint-subtle: string
 *   tint-strong: string
 *   detail: string
 *   detail-subtle: string
 *   detail-strong: string
 *   solid: string
 *   solid-subtle: string
 *   solid-strong: string
 *   solid-text: string
 *   text-subtle: string
 *   text: string
 * }
 *
 * @typedef SpacingAndBorderRadius {
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

/**
 * Generates a theme record.
 *
 * @param {{
 *   primary: string | ColorSpec
 *   secondary?: string | ColorSpec
 *   base?: string | ColorSpec
 *   success?: string | ColorSpec
 *   warning?: string | ColorSpec
 *   danger?: string | ColorSpec
 *   fontFamilies?: {
 *     heading?: string
 *     text?: string
 *     code?: string
 *   }
 *   spacingScale?: string
 *   spacing?: {
 *    xs?: string
 *    sm?: string
 *    md?: string
 *    lg?: string
 *    xl?: string
 *    2xl?: string
 *    3xl?: string
 *   }
 *   borderRadiusScale?: string
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
  const palettes = {
    base: toThemeColor(config.base || "slate"),
    primary: toThemeColor(config.primary),
    secondary: toThemeColor(config.secondary || config.primary),
    success: toThemeColor(config.success || "green"),
    warning: toThemeColor(config.warning || "yellow"),
    danger: toThemeColor(config.danger || "red"),
  }

  return {
    id: config.id || null,
    fonts: {
      heading: config.fontFamilies?.heading || HEADING_DEFAULT_FONT_FAMILY,
      text: config.fontFamilies?.text || TEXT_DEFAULT_FONT_FAMILY,
      code: config.fontFamilies?.code || CODE_DEFAULT_FONT_FAMILY,
    },
    spacing: toThemeSpacing(config.spacing, config.spacingScale),
    radius: toThemeRadius(config.radius, config.radiusScale),
    colors: {
      light: palette.map((variant) => palettes[variant].light),
      dark: palette.map((variant) => palettes[variant].dark)
    }
  }
}

/**
 * Applies theme to the body of the document or to a specific class.
 * @param {Theme} theme
 * @param {?{
 *   darkModeClass?: bool
 *   class?: bool
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
  "detail",
  "detail-subtle",
  "detail-strong",
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

