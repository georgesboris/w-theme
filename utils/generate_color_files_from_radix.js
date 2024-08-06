const fs = require("node:fs");
const child_process = require("node:child_process");
const prettier = require("@prettier/sync");
const radixLightColors = require("./radix/light.js");
const radixDarkColors = require("./radix/dark.js");
const radixConverter = require("./radix_converter.js");
const utils = require("./utils.js");

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

// /**
//  * This command re-generates everything under `/colors` directory.
//  * So we also create a README.md file to explain this behavior.
//  */

// const BASE_DIR = "../src/w/colors";

// fs.rmSync(BASE_DIR, { force: true, recursive: true });
// fs.mkdirSync(BASE_DIR);
// fs.writeFileSync(`${BASE_DIR}/README.md`, `## Important!

// This whole directory is code generated so don't write anything here manually or it will be whiped by the next color generation action.
// `);

// Generate JSON files for each color variant
//
// Object.entries(colors).forEach(([colorScheme, colorSchemeColors]) => {
//   Object.entries(colorSchemeColors).forEach(([name, values]) => {
//     fs.mkdirSync(`${BASE_DIR}/${colorScheme}/${name}`, { recursive: true });
//     fs.writeFileSync(`${BASE_DIR}/${colorScheme}/${name}/rgb.json`, JSON.stringify(values.rgb));
//     fs.writeFileSync(`${BASE_DIR}/${colorScheme}/${name}/channels.json`, JSON.stringify(values.channels));
//   });
// })

/**
 * Now we generate the JS file itself that can be used to access colors programatically.
 */

const colorsFileColors =
  Object.entries(colors)
    .map(([colorScheme, colorSchemeColors]) =>

      `${colorScheme}: {
      ${Object.entries(colorSchemeColors)
        .map(([name, values]) =>
          `${name}: {
              rgb: ${JSON.stringify(values.rgb)},
              channels: ${JSON.stringify(values.channels)},
            }`
        )
        .join(",")
      }}`)
    .join(",");

const colorsFileContent = prettier.format(`export default { ${colorsFileColors} };`, { parser: "babel" });

fs.writeFileSync(`../src/w/colors.js`, colorsFileContent);

/**
 * Elm Output
 */

const colorsElmHeader = `
module W.Theme.Colors exposing ($colorNames)

import Color exposing (Color)


type alias ColorScale =
    { bg : Color
    , bgSubtle : Color
    , tint : Color
    , tintSubtle : Color
    , tintStrong : Color
    , accent : Color
    , accentSubtle : Color
    , accentStrong : Color
    , solid : Color
    , solidSubtle : Color
    , solidStrong : Color
    , solidText : Color
    , text : Color
    , textSubtle : Color
    , shadow : Color
    }

`;

const colorsElm =
  Object.entries(colors).reduce((acc, [colorScheme, colorSchemeColors]) => {
    return Object.entries(colorSchemeColors).reduce((acc, [name, values]) => {
      const colorName = toElmColorName(name, colorScheme);

      return `${acc}

${colorName} : ColorScale
${colorName} = 
  ${toElmColorScale(values)}
`;
    }, acc);
  }, colorsElmHeader);

function toElmColorName(name, colorScheme) {
  return colorScheme === "light" ? name : `${name}Dark`;
}

function toElmColorScale(values) {
  const valuesString = Object.entries(values.channels).map(([name, value]) => {
    return `${name.replace("-", "").replace("subtle", "Subtle").replace("strong", "Strong").replace("solidtext", "solidText")} = ${toElmColor(value)}`;
  }).join("\n    , ");

  return `
    { ${valuesString}
    }`;
}

function capitalize(string) {
  return string.charAt(0).toUpperCase() + string.slice(1);
}

function toElmColor([r, g, b]) {
  return `Color.rgb255 ${r} ${g} ${b}`;
}

const colorNamesElm =
  Object.entries(colors).map(([colorScheme, colorSchemeColors]) => {
    return Object.entries(colorSchemeColors).map(([name, values]) => {
      return toElmColorName(name, colorScheme);
    });
  }).concat().join("\n  , ");

const colorsElmWithExports = colorsElm.replace("$colorNames", colorNamesElm)

fs.writeFileSync(`../src/w/elm/src/W/Theme/Colors.elm`, colorsElmWithExports);
child_process.execSync("npx elm-format ../src/w/elm/src/W/Theme/Colors.elm --elm-version=0.19 --yes");


/**
 * Gleam Output
 */

const colorsGleamHeader = `
import gleam_community/colour

fn color(r, g, b) {
  let assert Ok(c) = colour.from_rgb255(r, g, b)

  c
}

pub type ColorScale {
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
      pub fn ${toGleamColorName(name, colorScheme)}() { ${toGleamColorScale(values)} }
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
  return `color(${r}, ${g}, ${b})`;
}


fs.writeFileSync(`../src/w/colors.gleam`, colorsGleam);

