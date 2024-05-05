const colors = require("../colors");

module.exports = {
  cssVariablesFromTheme
};

/**
 * @param {{
 *   id?: string
 *   dark?: boolean
 *   primary: string
 *   secondary: string
 *   base?: string
 *   success?: string
 *   warning?: string
 *   danger?: string
 *   fontHeading?: string
 *   fontText?: string
 *   fontCode?: string
 *   radiusScale?: number
 *   spacingScale?: number
 *   radius?: {
 *    xs: number
 *    sm: number
 *    md: number
 *    lg: number
 *    xl: number
 *    2xl: number
 *    3xl: number
 *  }
 *  spacing?: {
 *    xs: number
 *    sm: number
 *    md: number
 *    lg: number
 *    xl: number
 *    2xl: number
 *    3xl: number
 *  }
 * }} theme
 *
 * @returns string[]
 */
function cssVariablesFromTheme(theme) {
  const colorScheme = theme.dark ? "dark" : "light";

  return [
    toIdVariable(theme),
    toColorVariables("primary", theme.primary, colorScheme),
    toColorVariables("secondary", theme.secondary, colorScheme),
    toColorVariables("base", theme.base || "slate", colorScheme),
    toColorVariables("success", theme.success || "green", colorScheme),
    toColorVariables("warning", theme.warning || "yellow", colorScheme),
    toColorVariables("danger", theme.danger || "red", colorScheme),
    toFontVariables(theme),
    toRadiusVariables(theme),
    toSpacingVariables(theme)
  ]
    .flat()
    .join(";")
}

function toIdVariable(theme) {
  return [`--w-theme-id:${theme.id || ""}`];
}

function toRadiusVariables(theme) {
  const scale = theme.radiusScale || 1;

  return [
    ["xs", theme.xs || `${0.125 * scale}rem`],
    ["sm", theme.sm || `${0.25 * scale}rem`],
    ["md", theme.md || `${0.375 * scale}rem`],
    ["lg", theme.lg || `${0.5 * scale}rem`],
    ["xl", theme.xl || `${0.75 * scale}rem`],
    ["2xl", theme["2xl"] || `${1 * scale}rem`],
    ["3xl", theme["3xl"] || `${1.5 * scale}rem`],
  ]
    .map(([k, v]) => `--w-radius-${k}:${v}`)
}

function toSpacingVariables(theme) {
  const scale = theme.spacingScale || 1;

  return [
    ["xs", theme.xs || `${0.25 * scale}rem`],
    ["sm", theme.sm || `${0.5 * scale}rem`],
    ["md", theme.md || `${0.75 * scale}rem`],
    ["lg", theme.lg || `${1 * scale}rem`],
    ["xl", theme.xl || `${1.5 * scale}rem`],
    ["2xl", theme["2xl"] || `${2.5 * scale}rem`],
    ["3xl", theme["3xl"] || `${4 * scale}rem`],
  ]
    .map(([k, v]) => `--w-spacing-${k}:${v}`)
}

function toFontVariables(theme) {
  return [
    ["heading", theme.fontHeading || "system-ui, sans-serif"],
    ["text", theme.fontText || "system-ui, sans-serif"],
    ["code", theme.fontCode || "monospace"],
  ]
    .map(([k, v]) => `--w-font-${k}:${v}`)
}

function toColorVariables(variant, colorName, colorScheme) {
  return colorToCSSVariablesChannels(
    variant,
    getColorByName(colorName)[colorScheme]
  );
}

function getColorByName(colorName) {
  if (!!colors.dark[colorName] && !!colors.light[colorName]) {
    return {
      dark: colors.dark[colorName],
      light: colors.light[colorName],
    };
  } else {
    throw new Error(`w-theme: Unknown color "${colorName}"`);
  }
}

function colorToCSSVariablesChannels(variant, color) {
  return [
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
  ].map((c) => {
    const [r, g, b] = color.channels[c];
    return `--w-${variant}-${c}: ${r} ${g} ${b}`;
  })
};

function colorToCSSVariablesRGB(variant, color) {
  return [
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
  ].map((c) => {
    return `--w-${variant}-${c}: ${color.rgb}`;
  })
};

