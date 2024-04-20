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
 * Exports
 */

export default {
  colorSet,
  colorValues,
  fontValues,
  palette,
  radiusValues,
  spacingValues,
};

/**
 * Helpers
 */

function varId(id) {
  return `--w-${id}`;
}

