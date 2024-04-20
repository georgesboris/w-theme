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
    ["xs", theme.xs || 0.125],
    ["sm", theme.sm || 0.25],
    ["md", theme.md || 0.375],
    ["lg", theme.lg || 0.5],
    ["xl", theme.xl || 0.75],
    ["2xl", theme["2xl"] || 1],
    ["3xl", theme["3xl"] || 1.5],
  ]
    .map(([k, v]) => `--w-radius-${k}:${v * scale}rem`)
}

function toSpacingVariables(theme) {
  const scale = theme.spacingScale || 1;

  return [
    ["xs", theme.xs || 0.25],
    ["sm", theme.sm || 0.5],
    ["md", theme.md || 0.75],
    ["lg", theme.lg || 1],
    ["xl", theme.xl || 1.5],
    ["2xl", theme["2xl"] || 2.5],
    ["3xl", theme["3xl"] || 4],
  ]
    .map(([k, v]) => `--w-spacing-${k}:${v * scale}rem`)
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
    ["bg", "bg"],
    ["bgSubtle", "bg-subtle"],
    ["tint", "tint"],
    ["tintSubtle", "tint-subtle"],
    ["tintStrong", "tint-strong"],
    ["detail", "detail"],
    ["detailSubtle", "detail-subtle"],
    ["detailStrong", "detail-strong"],
    ["solid", "solid"],
    ["solidSubtle", "solid-subtle"],
    ["solidStrong", "solid-strong"],
    ["solidText", "solid-text"],
    ["textSubtle", "text-subtle"],
    ["text", "text"],
  ].map(([k, v]) => {
    const [r, g, b] = color.channels[k];
    return `--w-${variant}-${v}: ${r} ${g} ${b}`;
  })
};

function colorToCSSVariablesRGB(variant, color) {
  return [
    ["bg", "bg"],
    ["bgSubtle", "bg-subtle"],
    ["tint", "tint"],
    ["tintSubtle", "tint-subtle"],
    ["tintStrong", "tint-strong"],
    ["detail", "detail"],
    ["detailSubtle", "detail-subtle"],
    ["detailStrong", "detail-strong"],
    ["solid", "solid"],
    ["solidSubtle", "solid-subtle"],
    ["solidStrong", "solid-strong"],
    ["solidText", "solid-text"],
    ["textSubtle", "text-subtle"],
    ["text", "text"],
  ].map(([k, v]) => {
    return `--w-${variant}-${v}: ${color.rgb}`;
  })
};

