module.exports = {
  mapValues,
  mergeKeys,
};


function mapValues(obj, fn) {
  const entries = Object.entries(obj)
    .map(([k, v]) => [k, fn(v, k)])

  return Object.fromEntries(entries);
}

function mergeKeys(obj) {
  const entries = Object.entries(obj);
  const attrs = entries[0] ? Object.keys(entries[0][1]) : [];

  return attrs
    .reduce((acc, attr) => {
      acc[attr] = entries.reduce((attrAcc, [key, values]) => {
        attrAcc[key] = values[attr];

        return attrAcc;
      }, {});

      return acc;
    }, {});
}

