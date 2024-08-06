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
    [bg, bgSubtle, tintSubtle, tint, tintStrong, accentSubtle, accent, accentStrong, solid, solidStrong, textSubtle, text, solidText] = colorChannels;
  } else {
    [bgSubtle, bg, tintSubtle, tint, tintStrong, accentSubtle, accent, accentStrong, solid, solidStrong, textSubtle, text, solidText] = colorChannels;
  }

  const solidSubtle = toSolidSubtle(solid, solidStrong);
  const shadow = colorScheme == "light" ? textSubtle : toColorChannels("#000000");

  return {
    "bg": bg,
    "bg-subtle": bgSubtle,
    "tint-subtle": tintSubtle,
    "tint": tint,
    "tint-strong": tintStrong,
    "accent-subtle": accentSubtle,
    "accent": accent,
    "accent-strong": accentStrong,
    "solid-subtle": solidSubtle,
    "solid": solid,
    "solid-strong": solidStrong,
    "solid-text": solidText,
    "text-subtle": textSubtle,
    "text": text,
    "shadow": shadow
  };
}

function toRGB(colorChannels) {
  return {
    "bg": rgbFromChannels(colorChannels["bg"]),
    "bg-subtle": rgbFromChannels(colorChannels["bg-subtle"]),
    "tint-subtle": rgbFromChannels(colorChannels["tint-subtle"]),
    "tint": rgbFromChannels(colorChannels["tint"]),
    "tint-strong": rgbFromChannels(colorChannels["tint-strong"]),
    "accent-subtle": rgbFromChannels(colorChannels["accent-subtle"]),
    "accent": rgbFromChannels(colorChannels["accent"]),
    "accent-strong": rgbFromChannels(colorChannels["accent-strong"]),
    "solid-subtle": rgbFromChannels(colorChannels["solid-subtle"]),
    "solid": rgbFromChannels(colorChannels["solid"]),
    "solid-strong": rgbFromChannels(colorChannels["solid-strong"]),
    "solid-text": rgbFromChannels(colorChannels["solid-text"]),
    "text-subtle": rgbFromChannels(colorChannels["text-subtle"]),
    "text": rgbFromChannels(colorChannels["text"]),
    "shadow": rgbFromChannels(colorChannels["shadow"]),
  };
}

function toCSSVariables(colorChannels) {
  return {
    "--w-bg": rgbFromChannels(colorChannels["bg"]),
    "--w-bg-subtle": rgbFromChannels(colorChannels["bg-subtle"]),
    "--w-tint-subtle": rgbFromChannels(colorChannels["tint-subtle"]),
    "--w-tint": rgbFromChannels(colorChannels["tint"]),
    "--w-tint-strong": rgbFromChannels(colorChannels["tint-strong"]),
    "--w-accent-subtle": rgbFromChannels(colorChannels["accent-subtle"]),
    "--w-accent": rgbFromChannels(colorChannels["accent"]),
    "--w-accent-strong": rgbFromChannels(colorChannels["accent-strong"]),
    "--w-solid-subtle": rgbFromChannels(colorChannels["solid-subtle"]),
    "--w-solid": rgbFromChannels(colorChannels["solid"]),
    "--w-solid-strong": rgbFromChannels(colorChannels["solid-strong"]),
    "--w-solid-text": rgbFromChannels(colorChannels["solid-text"]),
    "--w-text-subtle": rgbFromChannels(colorChannels["text-subtle"]),
    "--w-text": rgbFromChannels(colorChannels["text"]),
    "--w-shadow": rgbFromChannels(colorChannels["shadow"]),
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
  return colorChannelsFromColor(new Color(hex))
}

function colorChannelsFromColor(color) {
  return color.srgb.map(x =>
    (x >= 0.0)
      ? Math.floor(x * 255)
      : Math.floor((1 + x) * 255)
  );
}

function colorFromChannels(channels) {
  return new Color("srgb", channels.map(x => x / 255));
}

function toSolidSubtle(solidChannels, solidStrongChannels) {
  const solid = colorFromChannels(solidChannels);
  const solidStrong = colorFromChannels(solidStrongChannels);

  const sDiff = solidStrong.hsl.s - solid.hsl.s;
  const lDiff = solidStrong.hsl.l - solid.hsl.l;

  const solidSubtle = new Color("hsl", [solid.hsl.h, Math.max(0, solid.hsl.s - sDiff), Math.max(0, solid.hsl.l - lDiff)]);

  return colorChannelsFromColor(solidSubtle);
}

function rgbFromChannels([r, g, b]) {
  return `rgb(${r},${g},${b})`;
}

