const Color = require("colorjs.io").default;
const utils = require("./utils.js");

module.exports = {
  fromObject,
  fromObjectAsRGB,
  fromCSSExport,
  toCSSVariables,
  toRGB,
};

function fromObject(colors, colorScheme = "light") {
  return utils.mapValues(colors, (colorValues, colorName) => {
    const indexedColors = Object.values(colorValues);

    const solidColor =
      ["amber", "yellow", "lime", "mint", "sky"].includes(colorName)
        ? (colorScheme === "light" ? indexedColors[11] : indexedColors[1])
        : "#fff";

    return colorsFromRadixList([...indexedColors, solidColor], colorScheme);
  });
}

function fromObjectAsRGB(colors, colorScheme = "light") {
  return utils.mapValues(fromObject(colors, colorScheme), toRGB);
}


function fromCSSExport(cssExport) {
  const lines = cssExport.split("\n");

  const colorScheme = parseColorScheme(lines);
  const solidTextHex = parseSolidTextHex(lines);
  const otherColorsHex = parseColorsHex(lines);
  const colorsHex = [...otherColorsHex, solidTextHex];

  return colorsFromRadixList(colorsHex, colorScheme);
}

function colorsFromRadixList(colorsHex, colorScheme = "light") {
  colorChannels = colorsHex.map(toColorChannels);

  if (colorScheme == "light") {
    [bg, bgSubtle, tintSubtle, tint, tintStrong, detailSubtle, detail, detailStrong, solid, solidStrong, textSubtle, text, solidText] = colorChannels;
  } else {
    [bgSubtle, bg, tintSubtle, tint, tintStrong, detailSubtle, detail, detailStrong, solid, solidStrong, textSubtle, text, solidText] = colorChannels;
  }

  const solidSubtle = toSolidSubtle(solid, solidStrong);

  return {
    bg,
    bgSubtle,
    tintSubtle,
    tint,
    tintStrong,
    detailSubtle,
    detail,
    detailStrong,
    solidSubtle,
    solid,
    solidStrong,
    solidText,
    textSubtle,
    text,
  };
}

function toRGB(colorChannels) {
  return {
    bg: rgbFromChannels(colorChannels.bg),
    bgSubtle: rgbFromChannels(colorChannels.bgSubtle),
    tintSubtle: rgbFromChannels(colorChannels.tintSubtle),
    tint: rgbFromChannels(colorChannels.tint),
    tintStrong: rgbFromChannels(colorChannels.tintStrong),
    detailSubtle: rgbFromChannels(colorChannels.detailSubtle),
    detail: rgbFromChannels(colorChannels.detail),
    detailStrong: rgbFromChannels(colorChannels.detailStrong),
    solidSubtle: rgbFromChannels(colorChannels.solidSubtle),
    solid: rgbFromChannels(colorChannels.solid),
    solidStrong: rgbFromChannels(colorChannels.solidStrong),
    solidText: rgbFromChannels(colorChannels.solidText),
    textSubtle: rgbFromChannels(colorChannels.textSubtle),
    text: rgbFromChannels(colorChannels.text),
  };
}

function toCSSVariables(colorChannels) {
  return {
    "--w-bg": rgbFromChannels(colorChannels.bg),
    "--w-bg-subtle": rgbFromChannels(colorChannels.bgSubtle),
    "--w-tint-subtle": rgbFromChannels(colorChannels.tintSubtle),
    "--w-tint": rgbFromChannels(colorChannels.tint),
    "--w-tint-strong": rgbFromChannels(colorChannels.tintStrong),
    "--w-detail-subtle": rgbFromChannels(colorChannels.detailSubtle),
    "--w-detail": rgbFromChannels(colorChannels.detail),
    "--w-detail-strong": rgbFromChannels(colorChannels.detailStrong),
    "--w-solid-subtle": rgbFromChannels(colorChannels.solidSubtle),
    "--w-solid": rgbFromChannels(colorChannels.solid),
    "--w-solid-strong": rgbFromChannels(colorChannels.solidStrong),
    "--w-solid-text": rgbFromChannels(colorChannels.solidText),
    "--w-text-subtle": rgbFromChannels(colorChannels.textSubtle),
    "--w-text": rgbFromChannels(colorChannels.text),
  };
}

function parseColorScheme(lines) {
  return parseByRegex(lines, /\.(?<result>\w+)-theme/, "light");
}

function parseSolidTextHex(lines) {
  return parseByRegex(lines, /contrast: (?<result>#\w+);/, "#fff");
}

function parseByRegex(lines, rgx, fallback = "") {
  for (let i = 0, l = lines.length; i <= l; i++) {
    const match = lines[i].match(rgx)?.groups.result;
    if (match) return match;
  }

  return fallback;
}

function parseColorsHex(lines) {
  const firstIndex = lines.findIndex((x) => x.match(/--\w+-1:/));

  return lines
    .slice(firstIndex, firstIndex + 12)
    .map(x => x.replace(/^.*--\w+-\d+: |;$/g, ""));
}

function toColorChannels(hex) {
  return (new Color(hex)).srgb.map(x => Math.floor(x * 255));
}

function colorFromChannels(channels) {
  return new Color("srgb", channels.map(x => x / 255));
}

function toSolidSubtle(solidChannels, solidStrongChannels) {
  const solid = colorFromChannels(solidChannels);
  const solidStrong = colorFromChannels(solidStrongChannels);

  const sDiff = solidStrong.hsl.s - solid.hsl.s;
  const lDiff = solidStrong.hsl.l - solid.hsl.l;

  const solidSubtle = new Color("hsl", [solid.hsl.h, solid.hsl.s - sDiff, solid.hsl.l - lDiff]);

  return toColorChannels(solidSubtle);
}

function rgbFromChannels([r, g, b]) {
  return `rgb(${r},${g},${b})`;
}

