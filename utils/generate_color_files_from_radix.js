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

