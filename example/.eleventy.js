module.exports = function(config) {
  config.addPassthroughCopy({
    "./index.mjs": "index.mjs",
    "./node_modules/w-theme/dist/debugger.js": "/w-debugger.js",
    "./node_modules/w-theme/dist/exporter.js": "/w-exporter.js",
    "./node_modules/w-theme/dist/index.js": "/w-theme.js",
  });

  config.addGlobalData("palette", async () => {
    return (await import("w-theme")).default.palette;
  });

  config.addGlobalData("colorScale", async () => {
    return (await import("w-theme")).default.colorScale;
  });
};
