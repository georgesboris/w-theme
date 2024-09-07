/**
 * Constants
 */

function cssVar(id) {
  return `var(--w-${id})`;
}

function cssColor(id) {
  return `rgb(${cssVar(id)})`;
}

function twCssVar(id) {
  return `rgb(${cssVar(id)} / <alpha-value>)`;
}

/**
 * Fonts
 */

const fontFamily = {
  heading: cssVar("font-heading"),
  base: cssVar("font-base"),
  code: cssVar("font-code"),
};

/**
 * Border Radius
 */

const borderRadius = {
  none: "0",
  sm: cssVar("radius-xs"),
  DEFAULT: cssVar("radius-sm"),
  md: cssVar("radius-md"),
  lg: cssVar("radius-lg"),
  xl: cssVar("radius-xl"),
  "2xl": cssVar("radius-2xl"),
  "3xl": cssVar("radius-3xl"),
  full: "9999px",
};

/**
 * Border Radius
 */

const spacings = {
  none: "0",
  "0": "0",
  px: "1px",
  xs: cssVar("spacing-xs"),
  sm: cssVar("spacing-sm"),
  md: cssVar("spacing-md"),
  lg: cssVar("spacing-lg"),
  xl: cssVar("spacing-xl"),
  "2xl": cssVar("spacing-2xl"),
  "3xl": cssVar("spacing-3xl"),
};

/**
 * Colors
 */

const colors = {
  "bg-color": twCssVar("bg"),
  "bg-subtle": twCssVar("bg-subtle"),
  "tint": twCssVar("tint"),
  "tint-subtle": twCssVar("tint-subtle"),
  "tint-strong": twCssVar("tint-strong"),
  "accent": twCssVar("accent"),
  "accent-subtle": twCssVar("accent-subtle"),
  "accent-strong": twCssVar("accent-strong"),
  "solid-default": twCssVar("solid"),
  "solid-subtle": twCssVar("solid-subtle"),
  "solid-strong": twCssVar("solid-strong"),
  "solid-text": twCssVar("solid-text"),
  "text-subtle": twCssVar("text-subtle"),
  "text": twCssVar("text"),
  "shadow": twCssVar("shadow"),
};

/**
 * Text Colors
 */

const textColors = {
  "default": twCssVar("text"),
  "subtle": twCssVar("text-subtle"),
  "solid": twCssVar("solid-text")
}

/**
 * Text Components (default color inside backgrounds)
 */

const colorVariables = [
  "base",
  "primary",
  "secondary",
  "success",
  "warning",
  "danger"
];

const colorComponents = colorVariables.reduce((acc, variant) => {
  acc[`.w\\/${variant}`] =
  {
    "--w-color": variant,
    "--w-bg": `var(--w-${variant}-bg)`,
    "--w-bg-subtle": `var(--w-${variant}-bg-subtle)`,
    "--w-tint": `var(--w-${variant}-tint)`,
    "--w-tint-subtle": `var(--w-${variant}-tint-subtle)`,
    "--w-tint-strong": `var(--w-${variant}-tint-strong)`,
    "--w-accent": `var(--w-${variant}-accent)`,
    "--w-accent-subtle": `var(--w-${variant}-accent-subtle)`,
    "--w-accent-strong": `var(--w-${variant}-accent-strong)`,
    "--w-solid": `var(--w-${variant}-solid)`,
    "--w-solid-subtle": `var(--w-${variant}-solid-subtle)`,
    "--w-solid-strong": `var(--w-${variant}-solid-strong)`,
    "--w-solid-text": `var(--w-${variant}-solid-text)`,
    "--w-text": `var(--w-${variant}-text)`,
    "--w-text-subtle": `var(--w-${variant}-text-subtle)`,
    "--w-shadow": `var(--w-${variant}-shadow)`,
    "color": cssColor("text"),
  };
  return acc;
}, {
  ".w\\/tint": {
    backgroundColor: "rgb(var(--w-tint))",
    color: "rgb(var(--w-text))",
  },
  ".w\\/tint:is(a,button):is(:hover)": {
    backgroundColor: "rgb(var(--w-tint-strong))",
  },
  ".w\\/tint:is(a,button):is(:active)": {
    backgroundColor: "rgb(var(--w-tint-subtle))",
  },
  ".w\\/solid": {
    backgroundColor: "rgb(var(--w-solid))",
    color: "rgb(var(--w-solid-text)) !important",
  },
  ".w\\/solid:is(a,button):is(:hover)": {
    backgroundColor: "rgb(var(--w-solid-strong))",
  },
  ".w\\/solid:is(a,button):is(:active)": {
    backgroundColor: "rgb(var(--w-solid-subtle))",
  },
  ".w\\/tint:is(a,button):is(:focus-visible)": {
    outline: "2px solid transparent !important",
    outlineOffset: "2px !important",
    boxShadow: `0 0 0 1px rgb(var(--w-bg)), 0 0 0 4px rgb(var(--w-accent-subtle)) !important`
  },
  ".w\\/solid:is(a,button):is(:focus-visible)": {
    outline: "2px solid transparent !important",
    outlineOffset: "2px !important",
    boxShadow: `0 0 0 1px rgb(var(--w-bg)), 0 0 0 4px rgb(var(--w-accent-subtle)) !important`
  },
  ".w\\/focus:is(:focus-visible)": {
    outline: "2px solid transparent !important",
    outlineOffset: "2px !important",
    boxShadow: `0 0 0 1px rgb(var(--w-bg)), 0 0 0 4px rgb(var(--w-accent-subtle)) !important`
  },
});

/**
 * Export
 */

module.exports = {
  optionsHandler: (options = {}) => {
    return ({ addBase, addComponents }) => {
      addComponents({
        ".bg": {
          backgroundColor: cssColor("bg")
        },
        ".bg-subtle": {
          backgroundColor: cssColor("bg-subtle")
        },
      })

      if (options.colorComponents ?? false) {
        addBase(colorComponents);
      }
    };
  },
  themeHandler: (options = {}) => {
    const extraColors = options.extraColors || {};
    const strictTextColors = options.strictTextColors ?? true;
    const strictSpacing = options.strictSpacing ?? false;
    const useSpacing = options.useSpacing ?? false;

    const textColor = strictTextColors ? { textColor: textColors } : {};
    const textColorExtended = strictTextColors ? {} : { textColor: textColors };

    const spacing = !useSpacing ? {} : strictSpacing ? { spacing: spacings } : {};
    const spacingExtended = !useSpacing ? {} : strictSpacing ? {} : { spacing: spacings };

    const values = {
      fontFamily,
      borderRadius,
      colors: {
        black: "#000000",
        white: "#ffffff",
        inherit: "inherit",
        current: "currentColor",
        transparent: "transparent",
        ...extraColors,
        ...colors,
      },
      ...textColor,
      ...spacing
    };

    return options.strict
      ? { theme: { ...values, extend: { ...textColorExtended, ...spacingExtended } } }
      : { theme: { extend: { ...values, ...textColorExtended, ...spacingExtended }, ...textColor, ...spacing } };
  }
};
