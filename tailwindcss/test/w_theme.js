const { describe, it } = require("node:test");
const assert = require("node:assert/strict");
const wTheme = require("../src/w_theme.js");


/**
 * Constants
 */

const themeKeys = ["fontFamily", "colors", "borderRadius"];
const themeKeysWithTextColor = ["fontFamily", "colors", "borderRadius", "textColor"];
const textColor = "textColor";
const extraColors = ["purple", "pink"];


/**
 * Tests
 */

describe("theme handler - strict: false", () => {
  it("no options", () => {
    const response = wTheme.themeHandler();

    hasKeys(response.theme.extend, themeKeys);
    hasKeys(response.theme, [textColor]);
  });

  it("extra colors", () => {
    const response = wTheme.themeHandler({ extraColors });

    hasKeys(response.theme.extend, themeKeys);
    hasKey(response.theme, textColor);
  });

  it("loose text color", () => {
    const response = wTheme.themeHandler({ extraColors, strictTextColors: false });

    hasKeys(response.theme.extend, themeKeysWithTextColor);
    doesNotHaveKey(response.theme, textColor);
  });
});

describe("theme handler - strict: false", () => {
  it("no options", () => {
    const response = wTheme.themeHandler({ strict: true });

    hasKeys(response.theme, themeKeysWithTextColor);
  });

  it("extra colors", () => {
    const response = wTheme.themeHandler({ strict: true, extraColors });

    hasKeys(response.theme, themeKeysWithTextColor);
  });

  it("loose text color", () => {
    const response = wTheme.themeHandler({ strict: true, extraColors, strictTextColors: false });

    hasKeys(response.theme, themeKeys);
    hasKey(response.theme.extend, textColor);
  });
});


/**
 * Helpers
 */

function hasKeys(obj, targetKeys) {
  const keys = Object.getOwnPropertyNames(obj);

  assert.ok(targetKeys.every((k) => {
    return keys.includes(k);
  }));
}

function hasKey(obj, targetKey) {
  assert.ok(obj.hasOwnProperty(targetKey));
}

function doesNotHaveKey(obj, targetKey) {
  assert.equal(false, obj.hasOwnProperty(targetKey));
}
