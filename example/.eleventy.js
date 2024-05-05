module.exports = function(config) {
  config.addPassthroughCopy({
    "./index.mjs": "index.mjs",
    "./node_modules/w-theme/src/debugger.js": "/w-debugger.js",
    "./node_modules/w-theme/src/index.js": "/w-theme.js",
    "./node_modules/w-theme/src/w": "/w",
  });

  config.addGlobalData("palette", async () => {
    return (await import("w-theme")).default.palette;
  });

  config.addGlobalData("colorScale", async () => {
    return (await import("w-theme")).default.colorScale;
  });
};
