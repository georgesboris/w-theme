/**
 * Constants
 */

const NAMESPACE = "w";

function cssVar(id) {
  return `var(--${NAMESPACE}-${id})`;
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
  text: cssVar("font-text"),
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
  subtle: colorCssVar("base-text-subtle"),
  solid: colorCssVar("base-solid-text")
});

/**
 * Text Components (default color inside backgrounds)
 */

const colorComponents = colorVariables.reduce((acc, variable) => {
  acc[`.bg-${variable}-solid, .bg-${variable}-solid-subtle, .bg-${variable}-solid-strong`] = {
    color: rawColorCssVar(`${variable}-solid-text`)
  };

  acc[`.bg-${variable}, .bg-${variable}-subtle, .bg-${variable}-tint, .bg-${variable}-tint-subtle, .bg-${variable}-tint-strong`] = {
    color: rawColorCssVar(`${variable}-text`)
  };

  return acc;
}, {});

/**
 * Export
 */

module.exports = {
  optionsHandler: (options = {}) => {
    return ({ addBase, addComponents }) => {
      if (options.strict) {
        addBase({
          body: {
            background: colors["base-bg"],
            color: textColors.default,
            fontFamily: fontFamily.text,
          },
          button: {
            fontFamily: fontFamily.text,
          },
          h1: {
            fontFamily: fontFamily.heading,
          },
          h2: {
            fontFamily: fontFamily.heading,
          },
          h3: {
            fontFamily: fontFamily.heading,
          },
          h4: {
            fontFamily: fontFamily.heading,
          },
          h5: {
            fontFamily: fontFamily.heading,
          },
          h6: {
            fontFamily: fontFamily.heading,
          },
          code: {
            fontFamily: fontFamily.code,
          },
        });
      }

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
