const fs = require("node:fs");
const prettier = require("@prettier/sync");
const radixLightColors = require("./radix/light.js");
const radixDarkColors = require("./radix/dark.js");
const radixConverter = require("./radix_converter.js");
const utils = require("./utils.js");

// - [ ] Save colors to JSON files "/colors/dark/green/rgb.json" "/colors/dark/green/channels.json"

/**
 * This command re-generates everything under `/colors` directory.
 * So we also create a README.md file to explain this behavior.
 */

fs.rmSync("../colors", { force: true, recursive: true });
fs.mkdirSync("../colors");
fs.writeFileSync(`../colors/README.md`, `## Important!

This whole directory is code generated so don't write anything here manually or it will be whiped by the next color generation action.
`);

/**
 * Here we are genereating both individual files for each color.
 */

const colorsAsChannels = {
  light: radixConverter.fromObject(radixLightColors),
  dark: radixConverter.fromObject(radixDarkColors, "dark")
};

const colorsAsRGB = {
  light: radixConverter.fromObjectAsRGB(radixLightColors),
  dark: radixConverter.fromObjectAsRGB(radixDarkColors, "dark")
};

const colors = {
  light: utils.mergeKeys({ rgb: colorsAsRGB.light, channels: colorsAsChannels.light }),
  dark: utils.mergeKeys({ rgb: colorsAsRGB.dark, channels: colorsAsChannels.dark }),
};

Object.entries(colors).forEach(([colorScheme, colorSchemeColors]) => {
  Object.entries(colorSchemeColors).forEach(([name, values]) => {
    fs.mkdirSync(`../colors/${colorScheme}/${name}`, { recursive: true });
    fs.writeFileSync(`../colors/${colorScheme}/${name}/rgb.json`, JSON.stringify(values.rgb));
    fs.writeFileSync(`../colors/${colorScheme}/${name}/channels.json`, JSON.stringify(values.channels));
  });
})

/**
 * Now we generate the JS file itself that can be used to access colors programatically.
 */

const colorsFileColors =
  Object.entries(colors)
    .map(([colorScheme, colorSchemeColors]) =>

      `${colorScheme}: {
      ${Object.keys(colorSchemeColors)
        .map((name) =>
          `${name}: {
              rgb: require("./${colorScheme}/${name}/rgb.json"),
              channels: require("./${colorScheme}/${name}/channels.json"),
            }`
        )
        .join(",")
      }}`)
    .join(",");

const colorsFileContent = prettier.format(`module.exports = { ${colorsFileColors} };`, { parser: "babel" });

fs.writeFileSync(`../colors/index.js`, colorsFileContent);

/**
 * Now we generate the JS file itself that can be used to access colors programatically.
 */

const colorsGleamHeader = `
import gleam_cummunity/colour

type ColorScale {
  ColorScale(
    bg: colour.Color,
    bg_subtle: colour.Color,
    tint: colour.Color,
    tint_subtle: colour.Color,
    tint_strong: colour.Color,
    accent: colour.Color,
    accent_subtle: colour.Color,
    accent_strong: colour.Color,
    solid: colour.Color,
    solid_subtle: colour.Color,
    solid_strong: colour.Color,
    solid_text: colour.Color,
    text: colour.Color,
    text_subtle: colour.Color,
  )
}

`;

const colorsGleam =
  Object.entries(colors).reduce((acc, [colorScheme, colorSchemeColors]) => {
    return Object.entries(colorSchemeColors).reduce((acc, [name, values]) => {
      return `${acc}
      pub const ${toGleamColorName(name, colorScheme)} = ${toGleamColorScale(values)})
      `;
    }, acc);
  }, colorsGleamHeader);

function toGleamColorName(name, colorScheme) {
  return colorScheme === "light" ? name : `${name}_${colorScheme}`;
}

function toGleamColorScale(values) {
  const valuesString = Object.entries(values.channels).reduce((acc, [name, value]) => {
    return `${acc}
      ${name.replace("-", "_")}: ${toGleamColor(value)},
    `;
  }, "");

  return `ColorScale(
    ${valuesString}
  )`;
}

function toGleamColor([r, g, b]) {
  return `colour.from_rgb(${r}, ${g}, ${b})`;
}


fs.writeFileSync("../colors/colors.gleam", colorsGleam);

