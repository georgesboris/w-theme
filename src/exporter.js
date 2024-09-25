import w from "./index.js";
import * as css from "./w/css.js";

const themes = getThemes();

function getThemes() {
  let cssRulesets = [];

  for (let s of document.styleSheets) {
    const isTheme = "wTheme" in s.ownerNode.dataset;
    if (isTheme) { cssRulesets = cssRulesets.concat(findRulesets(s)); };
  }

  return cssRulesets.map(toThemeRecord);
}

function findRulesets(parent) {
  let acc = [];

  for (let ruleset of parent.cssRules) {
    if (ruleset.type == 1 && ruleset.style.getPropertyValue("--w-base-text")) {
      acc = acc.concat(ruleset)
    } else if (ruleset.type == 4) {
      acc = acc.concat(findRulesets(ruleset))
    }
  }

  return acc;
}


function getSelectorClass(ruleset) {
  const selectorClassRegex = /\.((\w|\d|-|_)+)($|\,|\s|\{)/;
  return selectorClassRegex.exec(ruleset.selectorText)?.[1] || "";
}

function toThemeRecord(ruleset) {
  const selectorClass = getSelectorClass(ruleset);
  const title = ruleset.style.getPropertyValue("--w-theme-id") || ruleset.selectorText;

  const colors = Object.fromEntries(
    w.colorValues.map((c) =>
      ([ruleset.style.getPropertyValue(c.cssId), c])
    )
  )

  const radius = Object.fromEntries(
    w.borderRadiusValues.map((c) => {
      const remValue = ruleset.style.getPropertyValue(c.cssId);
      const pxValue = css.remToPx(remValue);

      return [pxValue, { ...c, remValue }]
    })
  )

  const spacing = Object.fromEntries(
    w.spacingValues.map((c) => {
      const remValue = ruleset.style.getPropertyValue(c.cssId);
      const pxValue = css.remToPx(remValue);

      return [pxValue, { ...c, remValue }]
    })
  )

  const sizing = Object.fromEntries(
    w.sizingValues.map((c) => {
      const remValue = ruleset.style.getPropertyValue(c.cssId);
      const pxValue = css.remToPx(remValue);

      return [pxValue, { ...c, remValue }]
    })
  )

  const fonts = Object.fromEntries(
    w.fontFamilyValues.map((c) =>
      ([ruleset.style.getPropertyValue(c.cssId), c])
    )
  )

  return {
    selectorClass,
    title,
    colors,
    radius,
    spacing,
    fonts
  }
}

/**
 * Helpers : Color Channels
 */

const colorChannelsRegex = /^rgba?\((?<r>\d{1,3})\,\s*(?<g>\d{1,3})\,\s*(?<b>\d{1,3})/;

function toColorChannels(value) {
  const channels = colorChannelsRegex.exec(value)?.groups;

  if (channels) {
    return `${channels.r} ${channels.g} ${channels.b}`;
  } else {
    return ""
  }
}

