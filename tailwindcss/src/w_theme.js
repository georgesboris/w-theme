/**
 * Constants
 */

const NAMESPACE = "w";

function cssVar(id) {
  return `var(--${NAMESPACE}-${id})`;
}

function rawColorCssVarWithAlpha(id, alpha) {
  return `rgb(${cssVar(id)} / ${alpha})`;
}

function rawColorCssVar(id) {
  return `rgb(${cssVar(id)} / 1.0)`;
}

function colorCssVar(id) {
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

const colorVariants = [
  ["DEFAULT", "bg"],
  ["bg", "bg"],
  ["subtle", "bg-subtle"],
  ["tint", "tint"],
  ["tint-subtle", "tint-subtle"],
  ["tint-strong", "tint-strong"],
  ["accent", "accent"],
  ["accent-subtle", "accent-subtle"],
  ["accent-strong", "accent-strong"],
  ["solid", "solid"],
  ["solid-subtle", "solid-subtle"],
  ["solid-strong", "solid-strong"],
  ["shadow", "shadow"],
];

const colorVariables = [
  "base",
  "primary",
  "secondary",
  "success",
  "warning",
  "danger"
];

const colors = colorVariables.reduce((acc, variable) => {
  acc[variable] = colorVariants.reduce((accum, [k, v]) => {
    accum[k] = colorCssVar(`${variable}-${v}`);
    return accum;
  }, {});

  return acc;
}, {});

/**
 * Text Colors
 */

const textColorVariants = [
  ["DEFAULT", "text"],
  ["text", "text"],
  ["subtle", "text-subtle"],
  ["solid", "solid-text"]
];

const textColors = colorVariables.reduce((acc, variable) => {
  if (variable !== "base") {
    acc[variable] = textColorVariants.reduce((accum, [k, v]) => {
      accum[k] = colorCssVar(`${variable}-${v}`);
      return accum;
    }, {});
  }

  return acc;
}, {
  DEFAULT: colorCssVar("base-text"),
  subtle: colorCssVar("base-text-subtle"),
  solid: colorCssVar("base-solid-text")
});

/**
 * Text Components (default color inside backgrounds)
 */

const colorComponents = colorVariables.reduce((acc, variant) => {

  acc[`.${NAMESPACE}\\/${variant}`] = {
    backgroundColor: rawColorCssVar(`${variant}-tint`),
    borderColor: rawColorCssVar(`${variant}-accent`),
    color: rawColorCssVar(`${variant}-text`),
  };
  acc[`.${NAMESPACE}\\/${variant}:is(a,button):is(:hover)`] = {
    backgroundColor: rawColorCssVar(`${variant}-tint-strong`),
    borderColor: rawColorCssVar(`${variant}-accent-strong`),
  };
  acc[`.${NAMESPACE}\\/${variant}:is(a,button):is(:active)`] = {
    backgroundColor: rawColorCssVar(`${variant}-tint-subtle`),
    borderColor: rawColorCssVar(`${variant}-accent-subtle`),
    color: rawColorCssVar(`${variant}-text-subtle`),
  };

  acc[`.${NAMESPACE}\\/${variant}.${NAMESPACE}\\/solid`] = {
    backgroundColor: rawColorCssVar(`${variant}-solid`),
    color: rawColorCssVar(`${variant}-solid-text`),
  };
  acc[`.${NAMESPACE}\\/${variant}.${NAMESPACE}\\/solid:is(a,button):is(:hover)`] = {
    backgroundColor: rawColorCssVar(`${variant}-solid-strong`),
  };
  acc[`.${NAMESPACE}\\/${variant}.${NAMESPACE}\\/solid:is(a,button):is(:active)`] = {
    backgroundColor: rawColorCssVar(`${variant}-solid-subtle`),
    color: rawColorCssVarWithAlpha(`${variant}-solid-text`, 0.8),
  };

  acc[`.${NAMESPACE}\\/${variant}:is(a,button):is(:focus-visible)`] = {
    outline: "2px solid transparent",
    outlineOffset: "2px",
    boxShadow: `0 0 0 1px ${rawColorCssVar("base-bg")}, 0 0 0 calc(9px) ${rawColorCssVar(`${variant}-solid-subtle`)}`
  };

  acc[`.${NAMESPACE}-bg-${variant}-solid, .${NAMESPACE}-bg-${variant}-solid-subtle, .${NAMESPACE}-bg-${variant}-solid-strong`] = {
    color: rawColorCssVar(`${variant}-solid-text`)
  };

  acc[`.${NAMESPACE}-bg-${variant}, .${NAMESPACE}-bg-${variant}-subtle, .${NAMESPACE}-bg-${variant}-tint, .${NAMESPACE}-bg-${variant}-tint-subtle, .${NAMESPACE}-bg-${variant}-tint-strong`] = {
    color: rawColorCssVar(`${variant}-text`)
  };

  return acc;
}, {});

/**
 * Export
 */

module.exports = {
  optionsHandler: (options = {}) => {
    return ({ addComponents }) => {
      if (options.colorComponents ?? true) {
        addComponents(colorComponents);
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
