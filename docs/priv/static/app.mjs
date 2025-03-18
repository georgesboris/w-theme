// build/dev/javascript/prelude.mjs
var CustomType = class {
  withFields(fields) {
    let properties = Object.keys(this).map(
      (label) => label in fields ? fields[label] : this[label]
    );
    return new this.constructor(...properties);
  }
};
var List = class {
  static fromArray(array3, tail) {
    let t = tail || new Empty();
    for (let i = array3.length - 1; i >= 0; --i) {
      t = new NonEmpty(array3[i], t);
    }
    return t;
  }
  [Symbol.iterator]() {
    return new ListIterator(this);
  }
  toArray() {
    return [...this];
  }
  // @internal
  atLeastLength(desired) {
    for (let _ of this) {
      if (desired <= 0)
        return true;
      desired--;
    }
    return desired <= 0;
  }
  // @internal
  hasLength(desired) {
    for (let _ of this) {
      if (desired <= 0)
        return false;
      desired--;
    }
    return desired === 0;
  }
  // @internal
  countLength() {
    let length3 = 0;
    for (let _ of this)
      length3++;
    return length3;
  }
};
function prepend(element2, tail) {
  return new NonEmpty(element2, tail);
}
function toList(elements2, tail) {
  return List.fromArray(elements2, tail);
}
var ListIterator = class {
  #current;
  constructor(current) {
    this.#current = current;
  }
  next() {
    if (this.#current instanceof Empty) {
      return { done: true };
    } else {
      let { head, tail } = this.#current;
      this.#current = tail;
      return { value: head, done: false };
    }
  }
};
var Empty = class extends List {
};
var NonEmpty = class extends List {
  constructor(head, tail) {
    super();
    this.head = head;
    this.tail = tail;
  }
};
var BitArray = class _BitArray {
  constructor(buffer) {
    if (!(buffer instanceof Uint8Array)) {
      throw "BitArray can only be constructed from a Uint8Array";
    }
    this.buffer = buffer;
  }
  // @internal
  get length() {
    return this.buffer.length;
  }
  // @internal
  byteAt(index2) {
    return this.buffer[index2];
  }
  // @internal
  floatFromSlice(start3, end, isBigEndian) {
    return byteArrayToFloat(this.buffer, start3, end, isBigEndian);
  }
  // @internal
  intFromSlice(start3, end, isBigEndian, isSigned) {
    return byteArrayToInt(this.buffer, start3, end, isBigEndian, isSigned);
  }
  // @internal
  binaryFromSlice(start3, end) {
    return new _BitArray(this.buffer.slice(start3, end));
  }
  // @internal
  sliceAfter(index2) {
    return new _BitArray(this.buffer.slice(index2));
  }
};
var UtfCodepoint = class {
  constructor(value3) {
    this.value = value3;
  }
};
function byteArrayToInt(byteArray, start3, end, isBigEndian, isSigned) {
  let value3 = 0;
  if (isBigEndian) {
    for (let i = start3; i < end; i++) {
      value3 = value3 * 256 + byteArray[i];
    }
  } else {
    for (let i = end - 1; i >= start3; i--) {
      value3 = value3 * 256 + byteArray[i];
    }
  }
  if (isSigned) {
    const byteSize = end - start3;
    const highBit = 2 ** (byteSize * 8 - 1);
    if (value3 >= highBit) {
      value3 -= highBit * 2;
    }
  }
  return value3;
}
function byteArrayToFloat(byteArray, start3, end, isBigEndian) {
  const view = new DataView(byteArray.buffer);
  const byteSize = end - start3;
  if (byteSize === 8) {
    return view.getFloat64(start3, !isBigEndian);
  } else if (byteSize === 4) {
    return view.getFloat32(start3, !isBigEndian);
  } else {
    const msg = `Sized floats must be 32-bit or 64-bit on JavaScript, got size of ${byteSize * 8} bits`;
    throw new globalThis.Error(msg);
  }
}
var Result = class _Result extends CustomType {
  // @internal
  static isResult(data) {
    return data instanceof _Result;
  }
};
var Ok = class extends Result {
  constructor(value3) {
    super();
    this[0] = value3;
  }
  // @internal
  isOk() {
    return true;
  }
};
var Error = class extends Result {
  constructor(detail) {
    super();
    this[0] = detail;
  }
  // @internal
  isOk() {
    return false;
  }
};
function isEqual(x, y) {
  let values = [x, y];
  while (values.length) {
    let a = values.pop();
    let b = values.pop();
    if (a === b)
      continue;
    if (!isObject(a) || !isObject(b))
      return false;
    let unequal = !structurallyCompatibleObjects(a, b) || unequalDates(a, b) || unequalBuffers(a, b) || unequalArrays(a, b) || unequalMaps(a, b) || unequalSets(a, b) || unequalRegExps(a, b);
    if (unequal)
      return false;
    const proto = Object.getPrototypeOf(a);
    if (proto !== null && typeof proto.equals === "function") {
      try {
        if (a.equals(b))
          continue;
        else
          return false;
      } catch {
      }
    }
    let [keys2, get2] = getters(a);
    for (let k of keys2(a)) {
      values.push(get2(a, k), get2(b, k));
    }
  }
  return true;
}
function getters(object3) {
  if (object3 instanceof Map) {
    return [(x) => x.keys(), (x, y) => x.get(y)];
  } else {
    let extra = object3 instanceof globalThis.Error ? ["message"] : [];
    return [(x) => [...extra, ...Object.keys(x)], (x, y) => x[y]];
  }
}
function unequalDates(a, b) {
  return a instanceof Date && (a > b || a < b);
}
function unequalBuffers(a, b) {
  return a.buffer instanceof ArrayBuffer && a.BYTES_PER_ELEMENT && !(a.byteLength === b.byteLength && a.every((n, i) => n === b[i]));
}
function unequalArrays(a, b) {
  return Array.isArray(a) && a.length !== b.length;
}
function unequalMaps(a, b) {
  return a instanceof Map && a.size !== b.size;
}
function unequalSets(a, b) {
  return a instanceof Set && (a.size != b.size || [...a].some((e) => !b.has(e)));
}
function unequalRegExps(a, b) {
  return a instanceof RegExp && (a.source !== b.source || a.flags !== b.flags);
}
function isObject(a) {
  return typeof a === "object" && a !== null;
}
function structurallyCompatibleObjects(a, b) {
  if (typeof a !== "object" && typeof b !== "object" && (!a || !b))
    return false;
  let nonstructural = [Promise, WeakSet, WeakMap, Function];
  if (nonstructural.some((c) => a instanceof c))
    return false;
  return a.constructor === b.constructor;
}
function remainderInt(a, b) {
  if (b === 0) {
    return 0;
  } else {
    return a % b;
  }
}
function divideInt(a, b) {
  return Math.trunc(divideFloat(a, b));
}
function divideFloat(a, b) {
  if (b === 0) {
    return 0;
  } else {
    return a / b;
  }
}
function makeError(variant, module, line, fn, message, extra) {
  let error = new globalThis.Error(message);
  error.gleam_error = variant;
  error.module = module;
  error.line = line;
  error.function = fn;
  error.fn = fn;
  for (let k in extra)
    error[k] = extra[k];
  return error;
}

// build/dev/javascript/gleam_stdlib/gleam/option.mjs
var Some = class extends CustomType {
  constructor(x0) {
    super();
    this[0] = x0;
  }
};
var None = class extends CustomType {
};
function to_result(option2, e) {
  if (option2 instanceof Some) {
    let a = option2[0];
    return new Ok(a);
  } else {
    return new Error(e);
  }
}

// build/dev/javascript/gleam_stdlib/gleam/int.mjs
function to_string2(x) {
  return to_string(x);
}
function to_float(x) {
  return identity(x);
}

// build/dev/javascript/gleam_stdlib/gleam/dict.mjs
function new$() {
  return new_map();
}
function insert(dict, key, value3) {
  return map_insert(key, value3, dict);
}
function reverse_and_concat(loop$remaining, loop$accumulator) {
  while (true) {
    let remaining = loop$remaining;
    let accumulator = loop$accumulator;
    if (remaining.hasLength(0)) {
      return accumulator;
    } else {
      let item = remaining.head;
      let rest = remaining.tail;
      loop$remaining = rest;
      loop$accumulator = prepend(item, accumulator);
    }
  }
}
function do_keys_acc(loop$list, loop$acc) {
  while (true) {
    let list = loop$list;
    let acc = loop$acc;
    if (list.hasLength(0)) {
      return reverse_and_concat(acc, toList([]));
    } else {
      let first3 = list.head;
      let rest = list.tail;
      loop$list = rest;
      loop$acc = prepend(first3[0], acc);
    }
  }
}
function do_keys(dict) {
  let list_of_pairs = map_to_list(dict);
  return do_keys_acc(list_of_pairs, toList([]));
}
function keys(dict) {
  return do_keys(dict);
}

// build/dev/javascript/gleam_stdlib/gleam/pair.mjs
function second(pair) {
  let a = pair[1];
  return a;
}

// build/dev/javascript/gleam_stdlib/gleam/list.mjs
function do_reverse(loop$remaining, loop$accumulator) {
  while (true) {
    let remaining = loop$remaining;
    let accumulator = loop$accumulator;
    if (remaining.hasLength(0)) {
      return accumulator;
    } else {
      let item = remaining.head;
      let rest$1 = remaining.tail;
      loop$remaining = rest$1;
      loop$accumulator = prepend(item, accumulator);
    }
  }
}
function reverse(list) {
  return do_reverse(list, toList([]));
}
function do_map(loop$list, loop$fun, loop$acc) {
  while (true) {
    let list = loop$list;
    let fun = loop$fun;
    let acc = loop$acc;
    if (list.hasLength(0)) {
      return reverse(acc);
    } else {
      let first$1 = list.head;
      let rest$1 = list.tail;
      loop$list = rest$1;
      loop$fun = fun;
      loop$acc = prepend(fun(first$1), acc);
    }
  }
}
function map(list, fun) {
  return do_map(list, fun, toList([]));
}
function fold(loop$list, loop$initial, loop$fun) {
  while (true) {
    let list = loop$list;
    let initial = loop$initial;
    let fun = loop$fun;
    if (list.hasLength(0)) {
      return initial;
    } else {
      let x = list.head;
      let rest$1 = list.tail;
      loop$list = rest$1;
      loop$initial = fun(initial, x);
      loop$fun = fun;
    }
  }
}
function do_index_fold(loop$over, loop$acc, loop$with, loop$index) {
  while (true) {
    let over = loop$over;
    let acc = loop$acc;
    let with$ = loop$with;
    let index2 = loop$index;
    if (over.hasLength(0)) {
      return acc;
    } else {
      let first$1 = over.head;
      let rest$1 = over.tail;
      loop$over = rest$1;
      loop$acc = with$(acc, first$1, index2);
      loop$with = with$;
      loop$index = index2 + 1;
    }
  }
}
function index_fold(list, initial, fun) {
  return do_index_fold(list, initial, fun, 0);
}
function find(loop$list, loop$is_desired) {
  while (true) {
    let list = loop$list;
    let is_desired = loop$is_desired;
    if (list.hasLength(0)) {
      return new Error(void 0);
    } else {
      let x = list.head;
      let rest$1 = list.tail;
      let $ = is_desired(x);
      if ($) {
        return new Ok(x);
      } else {
        loop$list = rest$1;
        loop$is_desired = is_desired;
      }
    }
  }
}
function reduce(list, fun) {
  if (list.hasLength(0)) {
    return new Error(void 0);
  } else {
    let first$1 = list.head;
    let rest$1 = list.tail;
    return new Ok(fold(rest$1, first$1, fun));
  }
}
function last(list) {
  let _pipe = list;
  return reduce(_pipe, (_, elem) => {
    return elem;
  });
}

// build/dev/javascript/gleam_stdlib/gleam/string_builder.mjs
function from_strings(strings) {
  return concat(strings);
}
function from_string(string3) {
  return identity(string3);
}
function to_string3(builder) {
  return identity(builder);
}
function split2(iodata, pattern) {
  return split(iodata, pattern);
}

// build/dev/javascript/gleam_stdlib/gleam/string.mjs
function length2(string3) {
  return string_length(string3);
}
function replace(string3, pattern, substitute) {
  let _pipe = string3;
  let _pipe$1 = from_string(_pipe);
  let _pipe$2 = string_replace(_pipe$1, pattern, substitute);
  return to_string3(_pipe$2);
}
function slice(string3, idx, len) {
  let $ = len < 0;
  if ($) {
    return "";
  } else {
    let $1 = idx < 0;
    if ($1) {
      let translated_idx = length2(string3) + idx;
      let $2 = translated_idx < 0;
      if ($2) {
        return "";
      } else {
        return string_slice(string3, translated_idx, len);
      }
    } else {
      return string_slice(string3, idx, len);
    }
  }
}
function drop_left(string3, num_graphemes) {
  let $ = num_graphemes < 0;
  if ($) {
    return string3;
  } else {
    return slice(string3, num_graphemes, length2(string3) - num_graphemes);
  }
}
function do_repeat(loop$string, loop$times, loop$acc) {
  while (true) {
    let string3 = loop$string;
    let times = loop$times;
    let acc = loop$acc;
    let $ = times <= 0;
    if ($) {
      return acc;
    } else {
      loop$string = string3;
      loop$times = times - 1;
      loop$acc = acc + string3;
    }
  }
}
function repeat(string3, times) {
  return do_repeat(string3, times, "");
}
function join2(strings, separator) {
  return join(strings, separator);
}
function padding(size, pad_string) {
  let pad_string_length = length2(pad_string);
  let num_pads = divideInt(size, pad_string_length);
  let extra = remainderInt(size, pad_string_length);
  return repeat(pad_string, num_pads) + slice(pad_string, 0, extra);
}
function pad_left(string3, desired_length, pad_string) {
  let current_length = length2(string3);
  let to_pad_length = desired_length - current_length;
  let $ = to_pad_length <= 0;
  if ($) {
    return string3;
  } else {
    return padding(to_pad_length, pad_string) + string3;
  }
}
function split3(x, substring) {
  if (substring === "") {
    return graphemes(x);
  } else {
    let _pipe = x;
    let _pipe$1 = from_string(_pipe);
    let _pipe$2 = split2(_pipe$1, substring);
    return map(_pipe$2, to_string3);
  }
}
function inspect2(term) {
  let _pipe = inspect(term);
  return to_string3(_pipe);
}

// build/dev/javascript/gleam_stdlib/gleam/result.mjs
function map2(result, fun) {
  if (result.isOk()) {
    let x = result[0];
    return new Ok(fun(x));
  } else {
    let e = result[0];
    return new Error(e);
  }
}
function map_error(result, fun) {
  if (result.isOk()) {
    let x = result[0];
    return new Ok(x);
  } else {
    let error = result[0];
    return new Error(fun(error));
  }
}
function try$(result, fun) {
  if (result.isOk()) {
    let x = result[0];
    return fun(x);
  } else {
    let e = result[0];
    return new Error(e);
  }
}
function then$(result, fun) {
  return try$(result, fun);
}
function unwrap(result, default$) {
  if (result.isOk()) {
    let v = result[0];
    return v;
  } else {
    return default$;
  }
}

// build/dev/javascript/gleam_stdlib/gleam/dynamic.mjs
var DecodeError = class extends CustomType {
  constructor(expected, found, path) {
    super();
    this.expected = expected;
    this.found = found;
    this.path = path;
  }
};
function classify(data) {
  return classify_dynamic(data);
}
function int(data) {
  return decode_int(data);
}
function any(decoders) {
  return (data) => {
    if (decoders.hasLength(0)) {
      return new Error(
        toList([new DecodeError("another type", classify(data), toList([]))])
      );
    } else {
      let decoder = decoders.head;
      let decoders$1 = decoders.tail;
      let $ = decoder(data);
      if ($.isOk()) {
        let decoded = $[0];
        return new Ok(decoded);
      } else {
        return any(decoders$1)(data);
      }
    }
  };
}
function push_path(error, name) {
  let name$1 = identity(name);
  let decoder = any(
    toList([string, (x) => {
      return map2(int(x), to_string2);
    }])
  );
  let name$2 = (() => {
    let $ = decoder(name$1);
    if ($.isOk()) {
      let name$22 = $[0];
      return name$22;
    } else {
      let _pipe = toList(["<", classify(name$1), ">"]);
      let _pipe$1 = from_strings(_pipe);
      return to_string3(_pipe$1);
    }
  })();
  return error.withFields({ path: prepend(name$2, error.path) });
}
function map_errors(result, f) {
  return map_error(
    result,
    (_capture) => {
      return map(_capture, f);
    }
  );
}
function string(data) {
  return decode_string(data);
}
function field(name, inner_type) {
  return (value3) => {
    let missing_field_error = new DecodeError("field", "nothing", toList([]));
    return try$(
      decode_field(value3, name),
      (maybe_inner) => {
        let _pipe = maybe_inner;
        let _pipe$1 = to_result(_pipe, toList([missing_field_error]));
        let _pipe$2 = try$(_pipe$1, inner_type);
        return map_errors(
          _pipe$2,
          (_capture) => {
            return push_path(_capture, name);
          }
        );
      }
    );
  };
}

// build/dev/javascript/gleam_stdlib/dict.mjs
var referenceMap = /* @__PURE__ */ new WeakMap();
var tempDataView = new DataView(new ArrayBuffer(8));
var referenceUID = 0;
function hashByReference(o) {
  const known = referenceMap.get(o);
  if (known !== void 0) {
    return known;
  }
  const hash = referenceUID++;
  if (referenceUID === 2147483647) {
    referenceUID = 0;
  }
  referenceMap.set(o, hash);
  return hash;
}
function hashMerge(a, b) {
  return a ^ b + 2654435769 + (a << 6) + (a >> 2) | 0;
}
function hashString(s) {
  let hash = 0;
  const len = s.length;
  for (let i = 0; i < len; i++) {
    hash = Math.imul(31, hash) + s.charCodeAt(i) | 0;
  }
  return hash;
}
function hashNumber(n) {
  tempDataView.setFloat64(0, n);
  const i = tempDataView.getInt32(0);
  const j = tempDataView.getInt32(4);
  return Math.imul(73244475, i >> 16 ^ i) ^ j;
}
function hashBigInt(n) {
  return hashString(n.toString());
}
function hashObject(o) {
  const proto = Object.getPrototypeOf(o);
  if (proto !== null && typeof proto.hashCode === "function") {
    try {
      const code2 = o.hashCode(o);
      if (typeof code2 === "number") {
        return code2;
      }
    } catch {
    }
  }
  if (o instanceof Promise || o instanceof WeakSet || o instanceof WeakMap) {
    return hashByReference(o);
  }
  if (o instanceof Date) {
    return hashNumber(o.getTime());
  }
  let h = 0;
  if (o instanceof ArrayBuffer) {
    o = new Uint8Array(o);
  }
  if (Array.isArray(o) || o instanceof Uint8Array) {
    for (let i = 0; i < o.length; i++) {
      h = Math.imul(31, h) + getHash(o[i]) | 0;
    }
  } else if (o instanceof Set) {
    o.forEach((v) => {
      h = h + getHash(v) | 0;
    });
  } else if (o instanceof Map) {
    o.forEach((v, k) => {
      h = h + hashMerge(getHash(v), getHash(k)) | 0;
    });
  } else {
    const keys2 = Object.keys(o);
    for (let i = 0; i < keys2.length; i++) {
      const k = keys2[i];
      const v = o[k];
      h = h + hashMerge(getHash(v), hashString(k)) | 0;
    }
  }
  return h;
}
function getHash(u) {
  if (u === null)
    return 1108378658;
  if (u === void 0)
    return 1108378659;
  if (u === true)
    return 1108378657;
  if (u === false)
    return 1108378656;
  switch (typeof u) {
    case "number":
      return hashNumber(u);
    case "string":
      return hashString(u);
    case "bigint":
      return hashBigInt(u);
    case "object":
      return hashObject(u);
    case "symbol":
      return hashByReference(u);
    case "function":
      return hashByReference(u);
    default:
      return 0;
  }
}
var SHIFT = 5;
var BUCKET_SIZE = Math.pow(2, SHIFT);
var MASK = BUCKET_SIZE - 1;
var MAX_INDEX_NODE = BUCKET_SIZE / 2;
var MIN_ARRAY_NODE = BUCKET_SIZE / 4;
var ENTRY = 0;
var ARRAY_NODE = 1;
var INDEX_NODE = 2;
var COLLISION_NODE = 3;
var EMPTY = {
  type: INDEX_NODE,
  bitmap: 0,
  array: []
};
function mask(hash, shift) {
  return hash >>> shift & MASK;
}
function bitpos(hash, shift) {
  return 1 << mask(hash, shift);
}
function bitcount(x) {
  x -= x >> 1 & 1431655765;
  x = (x & 858993459) + (x >> 2 & 858993459);
  x = x + (x >> 4) & 252645135;
  x += x >> 8;
  x += x >> 16;
  return x & 127;
}
function index(bitmap, bit) {
  return bitcount(bitmap & bit - 1);
}
function cloneAndSet(arr, at, val) {
  const len = arr.length;
  const out = new Array(len);
  for (let i = 0; i < len; ++i) {
    out[i] = arr[i];
  }
  out[at] = val;
  return out;
}
function spliceIn(arr, at, val) {
  const len = arr.length;
  const out = new Array(len + 1);
  let i = 0;
  let g = 0;
  while (i < at) {
    out[g++] = arr[i++];
  }
  out[g++] = val;
  while (i < len) {
    out[g++] = arr[i++];
  }
  return out;
}
function spliceOut(arr, at) {
  const len = arr.length;
  const out = new Array(len - 1);
  let i = 0;
  let g = 0;
  while (i < at) {
    out[g++] = arr[i++];
  }
  ++i;
  while (i < len) {
    out[g++] = arr[i++];
  }
  return out;
}
function createNode(shift, key1, val1, key2hash, key2, val2) {
  const key1hash = getHash(key1);
  if (key1hash === key2hash) {
    return {
      type: COLLISION_NODE,
      hash: key1hash,
      array: [
        { type: ENTRY, k: key1, v: val1 },
        { type: ENTRY, k: key2, v: val2 }
      ]
    };
  }
  const addedLeaf = { val: false };
  return assoc(
    assocIndex(EMPTY, shift, key1hash, key1, val1, addedLeaf),
    shift,
    key2hash,
    key2,
    val2,
    addedLeaf
  );
}
function assoc(root, shift, hash, key, val, addedLeaf) {
  switch (root.type) {
    case ARRAY_NODE:
      return assocArray(root, shift, hash, key, val, addedLeaf);
    case INDEX_NODE:
      return assocIndex(root, shift, hash, key, val, addedLeaf);
    case COLLISION_NODE:
      return assocCollision(root, shift, hash, key, val, addedLeaf);
  }
}
function assocArray(root, shift, hash, key, val, addedLeaf) {
  const idx = mask(hash, shift);
  const node = root.array[idx];
  if (node === void 0) {
    addedLeaf.val = true;
    return {
      type: ARRAY_NODE,
      size: root.size + 1,
      array: cloneAndSet(root.array, idx, { type: ENTRY, k: key, v: val })
    };
  }
  if (node.type === ENTRY) {
    if (isEqual(key, node.k)) {
      if (val === node.v) {
        return root;
      }
      return {
        type: ARRAY_NODE,
        size: root.size,
        array: cloneAndSet(root.array, idx, {
          type: ENTRY,
          k: key,
          v: val
        })
      };
    }
    addedLeaf.val = true;
    return {
      type: ARRAY_NODE,
      size: root.size,
      array: cloneAndSet(
        root.array,
        idx,
        createNode(shift + SHIFT, node.k, node.v, hash, key, val)
      )
    };
  }
  const n = assoc(node, shift + SHIFT, hash, key, val, addedLeaf);
  if (n === node) {
    return root;
  }
  return {
    type: ARRAY_NODE,
    size: root.size,
    array: cloneAndSet(root.array, idx, n)
  };
}
function assocIndex(root, shift, hash, key, val, addedLeaf) {
  const bit = bitpos(hash, shift);
  const idx = index(root.bitmap, bit);
  if ((root.bitmap & bit) !== 0) {
    const node = root.array[idx];
    if (node.type !== ENTRY) {
      const n = assoc(node, shift + SHIFT, hash, key, val, addedLeaf);
      if (n === node) {
        return root;
      }
      return {
        type: INDEX_NODE,
        bitmap: root.bitmap,
        array: cloneAndSet(root.array, idx, n)
      };
    }
    const nodeKey = node.k;
    if (isEqual(key, nodeKey)) {
      if (val === node.v) {
        return root;
      }
      return {
        type: INDEX_NODE,
        bitmap: root.bitmap,
        array: cloneAndSet(root.array, idx, {
          type: ENTRY,
          k: key,
          v: val
        })
      };
    }
    addedLeaf.val = true;
    return {
      type: INDEX_NODE,
      bitmap: root.bitmap,
      array: cloneAndSet(
        root.array,
        idx,
        createNode(shift + SHIFT, nodeKey, node.v, hash, key, val)
      )
    };
  } else {
    const n = root.array.length;
    if (n >= MAX_INDEX_NODE) {
      const nodes = new Array(32);
      const jdx = mask(hash, shift);
      nodes[jdx] = assocIndex(EMPTY, shift + SHIFT, hash, key, val, addedLeaf);
      let j = 0;
      let bitmap = root.bitmap;
      for (let i = 0; i < 32; i++) {
        if ((bitmap & 1) !== 0) {
          const node = root.array[j++];
          nodes[i] = node;
        }
        bitmap = bitmap >>> 1;
      }
      return {
        type: ARRAY_NODE,
        size: n + 1,
        array: nodes
      };
    } else {
      const newArray = spliceIn(root.array, idx, {
        type: ENTRY,
        k: key,
        v: val
      });
      addedLeaf.val = true;
      return {
        type: INDEX_NODE,
        bitmap: root.bitmap | bit,
        array: newArray
      };
    }
  }
}
function assocCollision(root, shift, hash, key, val, addedLeaf) {
  if (hash === root.hash) {
    const idx = collisionIndexOf(root, key);
    if (idx !== -1) {
      const entry = root.array[idx];
      if (entry.v === val) {
        return root;
      }
      return {
        type: COLLISION_NODE,
        hash,
        array: cloneAndSet(root.array, idx, { type: ENTRY, k: key, v: val })
      };
    }
    const size = root.array.length;
    addedLeaf.val = true;
    return {
      type: COLLISION_NODE,
      hash,
      array: cloneAndSet(root.array, size, { type: ENTRY, k: key, v: val })
    };
  }
  return assoc(
    {
      type: INDEX_NODE,
      bitmap: bitpos(root.hash, shift),
      array: [root]
    },
    shift,
    hash,
    key,
    val,
    addedLeaf
  );
}
function collisionIndexOf(root, key) {
  const size = root.array.length;
  for (let i = 0; i < size; i++) {
    if (isEqual(key, root.array[i].k)) {
      return i;
    }
  }
  return -1;
}
function find2(root, shift, hash, key) {
  switch (root.type) {
    case ARRAY_NODE:
      return findArray(root, shift, hash, key);
    case INDEX_NODE:
      return findIndex(root, shift, hash, key);
    case COLLISION_NODE:
      return findCollision(root, key);
  }
}
function findArray(root, shift, hash, key) {
  const idx = mask(hash, shift);
  const node = root.array[idx];
  if (node === void 0) {
    return void 0;
  }
  if (node.type !== ENTRY) {
    return find2(node, shift + SHIFT, hash, key);
  }
  if (isEqual(key, node.k)) {
    return node;
  }
  return void 0;
}
function findIndex(root, shift, hash, key) {
  const bit = bitpos(hash, shift);
  if ((root.bitmap & bit) === 0) {
    return void 0;
  }
  const idx = index(root.bitmap, bit);
  const node = root.array[idx];
  if (node.type !== ENTRY) {
    return find2(node, shift + SHIFT, hash, key);
  }
  if (isEqual(key, node.k)) {
    return node;
  }
  return void 0;
}
function findCollision(root, key) {
  const idx = collisionIndexOf(root, key);
  if (idx < 0) {
    return void 0;
  }
  return root.array[idx];
}
function without(root, shift, hash, key) {
  switch (root.type) {
    case ARRAY_NODE:
      return withoutArray(root, shift, hash, key);
    case INDEX_NODE:
      return withoutIndex(root, shift, hash, key);
    case COLLISION_NODE:
      return withoutCollision(root, key);
  }
}
function withoutArray(root, shift, hash, key) {
  const idx = mask(hash, shift);
  const node = root.array[idx];
  if (node === void 0) {
    return root;
  }
  let n = void 0;
  if (node.type === ENTRY) {
    if (!isEqual(node.k, key)) {
      return root;
    }
  } else {
    n = without(node, shift + SHIFT, hash, key);
    if (n === node) {
      return root;
    }
  }
  if (n === void 0) {
    if (root.size <= MIN_ARRAY_NODE) {
      const arr = root.array;
      const out = new Array(root.size - 1);
      let i = 0;
      let j = 0;
      let bitmap = 0;
      while (i < idx) {
        const nv = arr[i];
        if (nv !== void 0) {
          out[j] = nv;
          bitmap |= 1 << i;
          ++j;
        }
        ++i;
      }
      ++i;
      while (i < arr.length) {
        const nv = arr[i];
        if (nv !== void 0) {
          out[j] = nv;
          bitmap |= 1 << i;
          ++j;
        }
        ++i;
      }
      return {
        type: INDEX_NODE,
        bitmap,
        array: out
      };
    }
    return {
      type: ARRAY_NODE,
      size: root.size - 1,
      array: cloneAndSet(root.array, idx, n)
    };
  }
  return {
    type: ARRAY_NODE,
    size: root.size,
    array: cloneAndSet(root.array, idx, n)
  };
}
function withoutIndex(root, shift, hash, key) {
  const bit = bitpos(hash, shift);
  if ((root.bitmap & bit) === 0) {
    return root;
  }
  const idx = index(root.bitmap, bit);
  const node = root.array[idx];
  if (node.type !== ENTRY) {
    const n = without(node, shift + SHIFT, hash, key);
    if (n === node) {
      return root;
    }
    if (n !== void 0) {
      return {
        type: INDEX_NODE,
        bitmap: root.bitmap,
        array: cloneAndSet(root.array, idx, n)
      };
    }
    if (root.bitmap === bit) {
      return void 0;
    }
    return {
      type: INDEX_NODE,
      bitmap: root.bitmap ^ bit,
      array: spliceOut(root.array, idx)
    };
  }
  if (isEqual(key, node.k)) {
    if (root.bitmap === bit) {
      return void 0;
    }
    return {
      type: INDEX_NODE,
      bitmap: root.bitmap ^ bit,
      array: spliceOut(root.array, idx)
    };
  }
  return root;
}
function withoutCollision(root, key) {
  const idx = collisionIndexOf(root, key);
  if (idx < 0) {
    return root;
  }
  if (root.array.length === 1) {
    return void 0;
  }
  return {
    type: COLLISION_NODE,
    hash: root.hash,
    array: spliceOut(root.array, idx)
  };
}
function forEach(root, fn) {
  if (root === void 0) {
    return;
  }
  const items = root.array;
  const size = items.length;
  for (let i = 0; i < size; i++) {
    const item = items[i];
    if (item === void 0) {
      continue;
    }
    if (item.type === ENTRY) {
      fn(item.v, item.k);
      continue;
    }
    forEach(item, fn);
  }
}
var Dict = class _Dict {
  /**
   * @template V
   * @param {Record<string,V>} o
   * @returns {Dict<string,V>}
   */
  static fromObject(o) {
    const keys2 = Object.keys(o);
    let m = _Dict.new();
    for (let i = 0; i < keys2.length; i++) {
      const k = keys2[i];
      m = m.set(k, o[k]);
    }
    return m;
  }
  /**
   * @template K,V
   * @param {Map<K,V>} o
   * @returns {Dict<K,V>}
   */
  static fromMap(o) {
    let m = _Dict.new();
    o.forEach((v, k) => {
      m = m.set(k, v);
    });
    return m;
  }
  static new() {
    return new _Dict(void 0, 0);
  }
  /**
   * @param {undefined | Node<K,V>} root
   * @param {number} size
   */
  constructor(root, size) {
    this.root = root;
    this.size = size;
  }
  /**
   * @template NotFound
   * @param {K} key
   * @param {NotFound} notFound
   * @returns {NotFound | V}
   */
  get(key, notFound) {
    if (this.root === void 0) {
      return notFound;
    }
    const found = find2(this.root, 0, getHash(key), key);
    if (found === void 0) {
      return notFound;
    }
    return found.v;
  }
  /**
   * @param {K} key
   * @param {V} val
   * @returns {Dict<K,V>}
   */
  set(key, val) {
    const addedLeaf = { val: false };
    const root = this.root === void 0 ? EMPTY : this.root;
    const newRoot = assoc(root, 0, getHash(key), key, val, addedLeaf);
    if (newRoot === this.root) {
      return this;
    }
    return new _Dict(newRoot, addedLeaf.val ? this.size + 1 : this.size);
  }
  /**
   * @param {K} key
   * @returns {Dict<K,V>}
   */
  delete(key) {
    if (this.root === void 0) {
      return this;
    }
    const newRoot = without(this.root, 0, getHash(key), key);
    if (newRoot === this.root) {
      return this;
    }
    if (newRoot === void 0) {
      return _Dict.new();
    }
    return new _Dict(newRoot, this.size - 1);
  }
  /**
   * @param {K} key
   * @returns {boolean}
   */
  has(key) {
    if (this.root === void 0) {
      return false;
    }
    return find2(this.root, 0, getHash(key), key) !== void 0;
  }
  /**
   * @returns {[K,V][]}
   */
  entries() {
    if (this.root === void 0) {
      return [];
    }
    const result = [];
    this.forEach((v, k) => result.push([k, v]));
    return result;
  }
  /**
   *
   * @param {(val:V,key:K)=>void} fn
   */
  forEach(fn) {
    forEach(this.root, fn);
  }
  hashCode() {
    let h = 0;
    this.forEach((v, k) => {
      h = h + hashMerge(getHash(v), getHash(k)) | 0;
    });
    return h;
  }
  /**
   * @param {unknown} o
   * @returns {boolean}
   */
  equals(o) {
    if (!(o instanceof _Dict) || this.size !== o.size) {
      return false;
    }
    let equal = true;
    this.forEach((v, k) => {
      equal = equal && isEqual(o.get(k, !v), v);
    });
    return equal;
  }
};

// build/dev/javascript/gleam_stdlib/gleam_stdlib.mjs
var Nil = void 0;
var NOT_FOUND = {};
function identity(x) {
  return x;
}
function to_string(term) {
  return term.toString();
}
function float_to_string(float3) {
  const string3 = float3.toString().replace("+", "");
  if (string3.indexOf(".") >= 0) {
    return string3;
  } else {
    const index2 = string3.indexOf("e");
    if (index2 >= 0) {
      return string3.slice(0, index2) + ".0" + string3.slice(index2);
    } else {
      return string3 + ".0";
    }
  }
}
function string_replace(string3, target, substitute) {
  if (typeof string3.replaceAll !== "undefined") {
    return string3.replaceAll(target, substitute);
  }
  return string3.replace(
    // $& means the whole matched string
    new RegExp(target.replace(/[.*+?^${}()|[\]\\]/g, "\\$&"), "g"),
    substitute
  );
}
function string_length(string3) {
  if (string3 === "") {
    return 0;
  }
  const iterator = graphemes_iterator(string3);
  if (iterator) {
    let i = 0;
    for (const _ of iterator) {
      i++;
    }
    return i;
  } else {
    return string3.match(/./gsu).length;
  }
}
function graphemes(string3) {
  const iterator = graphemes_iterator(string3);
  if (iterator) {
    return List.fromArray(Array.from(iterator).map((item) => item.segment));
  } else {
    return List.fromArray(string3.match(/./gsu));
  }
}
var segmenter = void 0;
function graphemes_iterator(string3) {
  if (globalThis.Intl && Intl.Segmenter) {
    segmenter ||= new Intl.Segmenter();
    return segmenter.segment(string3)[Symbol.iterator]();
  }
}
function split(xs, pattern) {
  return List.fromArray(xs.split(pattern));
}
function join(xs, separator) {
  const iterator = xs[Symbol.iterator]();
  let result = iterator.next().value || "";
  let current = iterator.next();
  while (!current.done) {
    result = result + separator + current.value;
    current = iterator.next();
  }
  return result;
}
function concat(xs) {
  let result = "";
  for (const x of xs) {
    result = result + x;
  }
  return result;
}
function string_slice(string3, idx, len) {
  if (len <= 0 || idx >= string3.length) {
    return "";
  }
  const iterator = graphemes_iterator(string3);
  if (iterator) {
    while (idx-- > 0) {
      iterator.next();
    }
    let result = "";
    while (len-- > 0) {
      const v = iterator.next().value;
      if (v === void 0) {
        break;
      }
      result += v.segment;
    }
    return result;
  } else {
    return string3.match(/./gsu).slice(idx, idx + len).join("");
  }
}
var unicode_whitespaces = [
  " ",
  // Space
  "	",
  // Horizontal tab
  "\n",
  // Line feed
  "\v",
  // Vertical tab
  "\f",
  // Form feed
  "\r",
  // Carriage return
  "\x85",
  // Next line
  "\u2028",
  // Line separator
  "\u2029"
  // Paragraph separator
].join("");
var left_trim_regex = new RegExp(`^([${unicode_whitespaces}]*)`, "g");
var right_trim_regex = new RegExp(`([${unicode_whitespaces}]*)$`, "g");
function print_debug(string3) {
  if (typeof process === "object" && process.stderr?.write) {
    process.stderr.write(string3 + "\n");
  } else if (typeof Deno === "object") {
    Deno.stderr.writeSync(new TextEncoder().encode(string3 + "\n"));
  } else {
    console.log(string3);
  }
}
function ceiling(float3) {
  return Math.ceil(float3);
}
function floor2(float3) {
  return Math.floor(float3);
}
function round2(float3) {
  return Math.round(float3);
}
function truncate(float3) {
  return Math.trunc(float3);
}
function power2(base, exponent) {
  return Math.pow(base, exponent);
}
function new_map() {
  return Dict.new();
}
function map_to_list(map4) {
  return List.fromArray(map4.entries());
}
function map_get(map4, key) {
  const value3 = map4.get(key, NOT_FOUND);
  if (value3 === NOT_FOUND) {
    return new Error(Nil);
  }
  return new Ok(value3);
}
function map_insert(key, value3, map4) {
  return map4.set(key, value3);
}
function classify_dynamic(data) {
  if (typeof data === "string") {
    return "String";
  } else if (typeof data === "boolean") {
    return "Bool";
  } else if (data instanceof Result) {
    return "Result";
  } else if (data instanceof List) {
    return "List";
  } else if (data instanceof BitArray) {
    return "BitArray";
  } else if (data instanceof Dict) {
    return "Dict";
  } else if (Number.isInteger(data)) {
    return "Int";
  } else if (Array.isArray(data)) {
    return `Tuple of ${data.length} elements`;
  } else if (typeof data === "number") {
    return "Float";
  } else if (data === null) {
    return "Null";
  } else if (data === void 0) {
    return "Nil";
  } else {
    const type = typeof data;
    return type.charAt(0).toUpperCase() + type.slice(1);
  }
}
function decoder_error(expected, got) {
  return decoder_error_no_classify(expected, classify_dynamic(got));
}
function decoder_error_no_classify(expected, got) {
  return new Error(
    List.fromArray([new DecodeError(expected, got, List.fromArray([]))])
  );
}
function decode_string(data) {
  return typeof data === "string" ? new Ok(data) : decoder_error("String", data);
}
function decode_int(data) {
  return Number.isInteger(data) ? new Ok(data) : decoder_error("Int", data);
}
function decode_field(value3, name) {
  const not_a_map_error = () => decoder_error("Dict", value3);
  if (value3 instanceof Dict || value3 instanceof WeakMap || value3 instanceof Map) {
    const entry = map_get(value3, name);
    return new Ok(entry.isOk() ? new Some(entry[0]) : new None());
  } else if (value3 === null) {
    return not_a_map_error();
  } else if (Object.getPrototypeOf(value3) == Object.prototype) {
    return try_get_field(value3, name, () => new Ok(new None()));
  } else {
    return try_get_field(value3, name, not_a_map_error);
  }
}
function try_get_field(value3, field2, or_else) {
  try {
    return field2 in value3 ? new Ok(new Some(value3[field2])) : or_else();
  } catch {
    return or_else();
  }
}
function inspect(v) {
  const t = typeof v;
  if (v === true)
    return "True";
  if (v === false)
    return "False";
  if (v === null)
    return "//js(null)";
  if (v === void 0)
    return "Nil";
  if (t === "string")
    return inspectString(v);
  if (t === "bigint" || Number.isInteger(v))
    return v.toString();
  if (t === "number")
    return float_to_string(v);
  if (Array.isArray(v))
    return `#(${v.map(inspect).join(", ")})`;
  if (v instanceof List)
    return inspectList(v);
  if (v instanceof UtfCodepoint)
    return inspectUtfCodepoint(v);
  if (v instanceof BitArray)
    return inspectBitArray(v);
  if (v instanceof CustomType)
    return inspectCustomType(v);
  if (v instanceof Dict)
    return inspectDict(v);
  if (v instanceof Set)
    return `//js(Set(${[...v].map(inspect).join(", ")}))`;
  if (v instanceof RegExp)
    return `//js(${v})`;
  if (v instanceof Date)
    return `//js(Date("${v.toISOString()}"))`;
  if (v instanceof Function) {
    const args = [];
    for (const i of Array(v.length).keys())
      args.push(String.fromCharCode(i + 97));
    return `//fn(${args.join(", ")}) { ... }`;
  }
  return inspectObject(v);
}
function inspectString(str) {
  let new_str = '"';
  for (let i = 0; i < str.length; i++) {
    let char = str[i];
    switch (char) {
      case "\n":
        new_str += "\\n";
        break;
      case "\r":
        new_str += "\\r";
        break;
      case "	":
        new_str += "\\t";
        break;
      case "\f":
        new_str += "\\f";
        break;
      case "\\":
        new_str += "\\\\";
        break;
      case '"':
        new_str += '\\"';
        break;
      default:
        if (char < " " || char > "~" && char < "\xA0") {
          new_str += "\\u{" + char.charCodeAt(0).toString(16).toUpperCase().padStart(4, "0") + "}";
        } else {
          new_str += char;
        }
    }
  }
  new_str += '"';
  return new_str;
}
function inspectDict(map4) {
  let body = "dict.from_list([";
  let first3 = true;
  map4.forEach((value3, key) => {
    if (!first3)
      body = body + ", ";
    body = body + "#(" + inspect(key) + ", " + inspect(value3) + ")";
    first3 = false;
  });
  return body + "])";
}
function inspectObject(v) {
  const name = Object.getPrototypeOf(v)?.constructor?.name || "Object";
  const props = [];
  for (const k of Object.keys(v)) {
    props.push(`${inspect(k)}: ${inspect(v[k])}`);
  }
  const body = props.length ? " " + props.join(", ") + " " : "";
  const head = name === "Object" ? "" : name + " ";
  return `//js(${head}{${body}})`;
}
function inspectCustomType(record) {
  const props = Object.keys(record).map((label) => {
    const value3 = inspect(record[label]);
    return isNaN(parseInt(label)) ? `${label}: ${value3}` : value3;
  }).join(", ");
  return props ? `${record.constructor.name}(${props})` : record.constructor.name;
}
function inspectList(list) {
  return `[${list.toArray().map(inspect).join(", ")}]`;
}
function inspectBitArray(bits) {
  return `<<${Array.from(bits.buffer).join(", ")}>>`;
}
function inspectUtfCodepoint(codepoint2) {
  return `//utfcodepoint(${String.fromCodePoint(codepoint2.value)})`;
}

// build/dev/javascript/gleam_stdlib/gleam/float.mjs
function to_string4(x) {
  return float_to_string(x);
}
function min(a, b) {
  let $ = a < b;
  if ($) {
    return a;
  } else {
    return b;
  }
}
function max(a, b) {
  let $ = a > b;
  if ($) {
    return a;
  } else {
    return b;
  }
}
function ceiling2(x) {
  return ceiling(x);
}
function floor(x) {
  return floor2(x);
}
function truncate2(x) {
  return truncate(x);
}
function power(base, exponent) {
  let fractional = ceiling2(exponent) - exponent > 0;
  let $ = base < 0 && fractional || base === 0 && exponent < 0;
  if ($) {
    return new Error(void 0);
  } else {
    return new Ok(power2(base, exponent));
  }
}
function negate(x) {
  return -1 * x;
}
function do_round(x) {
  let $ = x >= 0;
  if ($) {
    return round2(x);
  } else {
    return 0 - round2(negate(x));
  }
}
function round(x) {
  return do_round(x);
}
function modulo(dividend, divisor) {
  if (divisor === 0) {
    return new Error(void 0);
  } else {
    return new Ok(dividend - floor(divideFloat(dividend, divisor)) * divisor);
  }
}
function divide(a, b) {
  if (b === 0) {
    return new Error(void 0);
  } else {
    let b$1 = b;
    return new Ok(divideFloat(a, b$1));
  }
}
function multiply(a, b) {
  return a * b;
}

// build/dev/javascript/gleam_community_colour/gleam_community/colour.mjs
var Rgba = class extends CustomType {
  constructor(r, g, b, a) {
    super();
    this.r = r;
    this.g = g;
    this.b = b;
    this.a = a;
  }
};
var Hsla = class extends CustomType {
  constructor(h, s, l, a) {
    super();
    this.h = h;
    this.s = s;
    this.l = l;
    this.a = a;
  }
};
function valid_colour_value(c) {
  let $ = c > 1 || c < 0;
  if ($) {
    return new Error(void 0);
  } else {
    return new Ok(c);
  }
}
function hue_to_rgb(hue, m1, m2) {
  let h = (() => {
    if (hue < 0) {
      return hue + 1;
    } else if (hue > 1) {
      return hue - 1;
    } else {
      return hue;
    }
  })();
  let h_t_6 = h * 6;
  let h_t_2 = h * 2;
  let h_t_3 = h * 3;
  if (h_t_6 < 1) {
    return m1 + (m2 - m1) * h * 6;
  } else if (h_t_2 < 1) {
    return m2;
  } else if (h_t_3 < 2) {
    return m1 + (m2 - m1) * (divideFloat(2, 3) - h) * 6;
  } else {
    return m1;
  }
}
function hsla_to_rgba(h, s, l, a) {
  let m2 = (() => {
    let $ = l <= 0.5;
    if ($) {
      return l * (s + 1);
    } else {
      return l + s - l * s;
    }
  })();
  let m1 = l * 2 - m2;
  let r = hue_to_rgb(h + divideFloat(1, 3), m1, m2);
  let g = hue_to_rgb(h, m1, m2);
  let b = hue_to_rgb(h - divideFloat(1, 3), m1, m2);
  return [r, g, b, a];
}
function rgba_to_hsla(r, g, b, a) {
  let min_colour = min(r, min(g, b));
  let max_colour = max(r, max(g, b));
  let h12 = (() => {
    let $ = true;
    if (max_colour === r) {
      return divide(g - b, max_colour - min_colour);
    } else if (max_colour === g) {
      let _pipe = divide(b - r, max_colour - min_colour);
      return then$(_pipe, (d) => {
        return new Ok(2 + d);
      });
    } else {
      let _pipe = divide(r - g, max_colour - min_colour);
      return then$(_pipe, (d) => {
        return new Ok(4 + d);
      });
    }
  })();
  let h22 = (() => {
    if (h12.isOk()) {
      let v = h12[0];
      return new Ok(v * divideFloat(1, 6));
    } else {
      return h12;
    }
  })();
  let h3 = (() => {
    if (h22.isOk() && h22[0] < 0) {
      let v = h22[0];
      return v + 1;
    } else if (h22.isOk()) {
      let v = h22[0];
      return v;
    } else {
      return 0;
    }
  })();
  let l = divideFloat(min_colour + max_colour, 2);
  let s = (() => {
    let $ = true;
    if (min_colour === max_colour) {
      return 0;
    } else if (l < 0.5) {
      return divideFloat(max_colour - min_colour, max_colour + min_colour);
    } else {
      return divideFloat(
        max_colour - min_colour,
        2 - max_colour - min_colour
      );
    }
  })();
  return [h3, s, l, a];
}
function from_rgb255(red, green, blue) {
  return then$(
    (() => {
      let _pipe = red;
      let _pipe$1 = to_float(_pipe);
      let _pipe$2 = divide(_pipe$1, 255);
      return then$(_pipe$2, valid_colour_value);
    })(),
    (r) => {
      return then$(
        (() => {
          let _pipe = green;
          let _pipe$1 = to_float(_pipe);
          let _pipe$2 = divide(_pipe$1, 255);
          return then$(_pipe$2, valid_colour_value);
        })(),
        (g) => {
          return then$(
            (() => {
              let _pipe = blue;
              let _pipe$1 = to_float(_pipe);
              let _pipe$2 = divide(_pipe$1, 255);
              return then$(_pipe$2, valid_colour_value);
            })(),
            (b) => {
              return new Ok(new Rgba(r, g, b, 1));
            }
          );
        }
      );
    }
  );
}
function from_hsla(hue, saturation, lightness, alpha) {
  return then$(
    valid_colour_value(hue),
    (h) => {
      return then$(
        valid_colour_value(saturation),
        (s) => {
          return then$(
            valid_colour_value(lightness),
            (l) => {
              return then$(
                valid_colour_value(alpha),
                (a) => {
                  return new Ok(new Hsla(h, s, l, a));
                }
              );
            }
          );
        }
      );
    }
  );
}
function to_rgba(colour) {
  if (colour instanceof Rgba) {
    let r = colour.r;
    let g = colour.g;
    let b = colour.b;
    let a = colour.a;
    return [r, g, b, a];
  } else {
    let h = colour.h;
    let s = colour.s;
    let l = colour.l;
    let a = colour.a;
    return hsla_to_rgba(h, s, l, a);
  }
}
function to_hsla(colour) {
  if (colour instanceof Hsla) {
    let h = colour.h;
    let s = colour.s;
    let l = colour.l;
    let a = colour.a;
    return [h, s, l, a];
  } else {
    let r = colour.r;
    let g = colour.g;
    let b = colour.b;
    let a = colour.a;
    return rgba_to_hsla(r, g, b, a);
  }
}
function to_css_rgba_string(colour) {
  let $ = to_rgba(colour);
  let r = $[0];
  let g = $[1];
  let b = $[2];
  let a = $[3];
  let percent = (x) => {
    let $1 = (() => {
      let _pipe = x;
      let _pipe$1 = multiply(_pipe, 1e4);
      let _pipe$2 = round(_pipe$1);
      let _pipe$3 = to_float(_pipe$2);
      return divide(_pipe$3, 100);
    })();
    if (!$1.isOk()) {
      throw makeError(
        "let_assert",
        "gleam_community/colour",
        702,
        "",
        "Pattern match failed, no pattern matched the value.",
        { value: $1 }
      );
    }
    let p = $1[0];
    return p;
  };
  let round_to = (x) => {
    let $1 = (() => {
      let _pipe = x;
      let _pipe$1 = multiply(_pipe, 1e3);
      let _pipe$2 = round(_pipe$1);
      let _pipe$3 = to_float(_pipe$2);
      return divide(_pipe$3, 1e3);
    })();
    if (!$1.isOk()) {
      throw makeError(
        "let_assert",
        "gleam_community/colour",
        714,
        "",
        "Pattern match failed, no pattern matched the value.",
        { value: $1 }
      );
    }
    let r$1 = $1[0];
    return r$1;
  };
  return join2(
    toList([
      "rgba(",
      to_string4(percent(r)) + "%,",
      to_string4(percent(g)) + "%,",
      to_string4(percent(b)) + "%,",
      to_string4(round_to(a)),
      ")"
    ]),
    ""
  );
}

// build/dev/javascript/gleam_stdlib/gleam/io.mjs
function debug(term) {
  let _pipe = term;
  let _pipe$1 = inspect2(_pipe);
  print_debug(_pipe$1);
  return term;
}

// build/dev/javascript/gleam_stdlib/gleam/bool.mjs
function guard(requirement, consequence, alternative) {
  if (requirement) {
    return consequence;
  } else {
    return alternative();
  }
}

// build/dev/javascript/lustre/lustre/effect.mjs
var Effect = class extends CustomType {
  constructor(all) {
    super();
    this.all = all;
  }
};
function none() {
  return new Effect(toList([]));
}

// build/dev/javascript/lustre/lustre/internals/vdom.mjs
var Text = class extends CustomType {
  constructor(content) {
    super();
    this.content = content;
  }
};
var Element = class extends CustomType {
  constructor(key, namespace, tag, attrs, children2, self_closing, void$) {
    super();
    this.key = key;
    this.namespace = namespace;
    this.tag = tag;
    this.attrs = attrs;
    this.children = children2;
    this.self_closing = self_closing;
    this.void = void$;
  }
};
var Map2 = class extends CustomType {
  constructor(subtree) {
    super();
    this.subtree = subtree;
  }
};
var Attribute = class extends CustomType {
  constructor(x0, x1, as_property) {
    super();
    this[0] = x0;
    this[1] = x1;
    this.as_property = as_property;
  }
};
var Event = class extends CustomType {
  constructor(x0, x1) {
    super();
    this[0] = x0;
    this[1] = x1;
  }
};
function attribute_to_event_handler(attribute2) {
  if (attribute2 instanceof Attribute) {
    return new Error(void 0);
  } else {
    let name = attribute2[0];
    let handler = attribute2[1];
    let name$1 = drop_left(name, 2);
    return new Ok([name$1, handler]);
  }
}
function do_element_list_handlers(elements2, handlers2, key) {
  return index_fold(
    elements2,
    handlers2,
    (handlers3, element2, index2) => {
      let key$1 = key + "-" + to_string2(index2);
      return do_handlers(element2, handlers3, key$1);
    }
  );
}
function do_handlers(loop$element, loop$handlers, loop$key) {
  while (true) {
    let element2 = loop$element;
    let handlers2 = loop$handlers;
    let key = loop$key;
    if (element2 instanceof Text) {
      return handlers2;
    } else if (element2 instanceof Map2) {
      let subtree = element2.subtree;
      loop$element = subtree();
      loop$handlers = handlers2;
      loop$key = key;
    } else {
      let attrs = element2.attrs;
      let children2 = element2.children;
      let handlers$1 = fold(
        attrs,
        handlers2,
        (handlers3, attr) => {
          let $ = attribute_to_event_handler(attr);
          if ($.isOk()) {
            let name = $[0][0];
            let handler = $[0][1];
            return insert(handlers3, key + "-" + name, handler);
          } else {
            return handlers3;
          }
        }
      );
      return do_element_list_handlers(children2, handlers$1, key);
    }
  }
}
function handlers(element2) {
  return do_handlers(element2, new$(), "0");
}

// build/dev/javascript/lustre/lustre/attribute.mjs
function attribute(name, value3) {
  return new Attribute(name, identity(value3), false);
}
function on(name, handler) {
  return new Event("on" + name, handler);
}
function style(properties) {
  return attribute(
    "style",
    fold(
      properties,
      "",
      (styles, _use1) => {
        let name$1 = _use1[0];
        let value$1 = _use1[1];
        return styles + name$1 + ":" + value$1 + ";";
      }
    )
  );
}
function class$(name) {
  return attribute("class", name);
}
function value(val) {
  return attribute("value", val);
}

// build/dev/javascript/lustre/lustre/element.mjs
function element(tag, attrs, children2) {
  if (tag === "area") {
    return new Element("", "", tag, attrs, toList([]), false, true);
  } else if (tag === "base") {
    return new Element("", "", tag, attrs, toList([]), false, true);
  } else if (tag === "br") {
    return new Element("", "", tag, attrs, toList([]), false, true);
  } else if (tag === "col") {
    return new Element("", "", tag, attrs, toList([]), false, true);
  } else if (tag === "embed") {
    return new Element("", "", tag, attrs, toList([]), false, true);
  } else if (tag === "hr") {
    return new Element("", "", tag, attrs, toList([]), false, true);
  } else if (tag === "img") {
    return new Element("", "", tag, attrs, toList([]), false, true);
  } else if (tag === "input") {
    return new Element("", "", tag, attrs, toList([]), false, true);
  } else if (tag === "link") {
    return new Element("", "", tag, attrs, toList([]), false, true);
  } else if (tag === "meta") {
    return new Element("", "", tag, attrs, toList([]), false, true);
  } else if (tag === "param") {
    return new Element("", "", tag, attrs, toList([]), false, true);
  } else if (tag === "source") {
    return new Element("", "", tag, attrs, toList([]), false, true);
  } else if (tag === "track") {
    return new Element("", "", tag, attrs, toList([]), false, true);
  } else if (tag === "wbr") {
    return new Element("", "", tag, attrs, toList([]), false, true);
  } else {
    return new Element("", "", tag, attrs, children2, false, false);
  }
}
function text(content) {
  return new Text(content);
}
function fragment(elements2) {
  return element(
    "lustre-fragment",
    toList([style(toList([["display", "contents"]]))]),
    elements2
  );
}

// build/dev/javascript/gleam_stdlib/gleam/set.mjs
var Set2 = class extends CustomType {
  constructor(dict) {
    super();
    this.dict = dict;
  }
};
function new$3() {
  return new Set2(new$());
}

// build/dev/javascript/lustre/lustre/internals/patch.mjs
var Diff = class extends CustomType {
  constructor(x0) {
    super();
    this[0] = x0;
  }
};
var Emit = class extends CustomType {
  constructor(x0, x1) {
    super();
    this[0] = x0;
    this[1] = x1;
  }
};
var Init = class extends CustomType {
  constructor(x0, x1) {
    super();
    this[0] = x0;
    this[1] = x1;
  }
};
function is_empty_element_diff(diff2) {
  return isEqual(diff2.created, new$()) && isEqual(
    diff2.removed,
    new$3()
  ) && isEqual(diff2.updated, new$());
}

// build/dev/javascript/lustre/lustre/internals/runtime.mjs
var Attrs = class extends CustomType {
  constructor(x0) {
    super();
    this[0] = x0;
  }
};
var Batch = class extends CustomType {
  constructor(x0, x1) {
    super();
    this[0] = x0;
    this[1] = x1;
  }
};
var Debug = class extends CustomType {
  constructor(x0) {
    super();
    this[0] = x0;
  }
};
var Dispatch = class extends CustomType {
  constructor(x0) {
    super();
    this[0] = x0;
  }
};
var Emit2 = class extends CustomType {
  constructor(x0, x1) {
    super();
    this[0] = x0;
    this[1] = x1;
  }
};
var Event2 = class extends CustomType {
  constructor(x0, x1) {
    super();
    this[0] = x0;
    this[1] = x1;
  }
};
var Shutdown = class extends CustomType {
};
var Subscribe = class extends CustomType {
  constructor(x0, x1) {
    super();
    this[0] = x0;
    this[1] = x1;
  }
};
var Unsubscribe = class extends CustomType {
  constructor(x0) {
    super();
    this[0] = x0;
  }
};
var ForceModel = class extends CustomType {
  constructor(x0) {
    super();
    this[0] = x0;
  }
};

// build/dev/javascript/lustre/vdom.ffi.mjs
if (window && window.customElements) {
  window.customElements.define(
    "lustre-fragment",
    class LustreFragment extends HTMLElement {
      constructor() {
        super();
      }
    }
  );
}
function morph(prev, next, dispatch) {
  let out;
  let stack = [{ prev, next, parent: prev.parentNode }];
  while (stack.length) {
    let { prev: prev2, next: next2, parent } = stack.pop();
    while (next2.subtree !== void 0)
      next2 = next2.subtree();
    if (next2.content !== void 0) {
      if (!prev2) {
        const created = document.createTextNode(next2.content);
        parent.appendChild(created);
        out ??= created;
      } else if (prev2.nodeType === Node.TEXT_NODE) {
        if (prev2.textContent !== next2.content)
          prev2.textContent = next2.content;
        out ??= prev2;
      } else {
        const created = document.createTextNode(next2.content);
        parent.replaceChild(created, prev2);
        out ??= created;
      }
    } else if (next2.tag !== void 0) {
      const created = createElementNode({
        prev: prev2,
        next: next2,
        dispatch,
        stack
      });
      if (!prev2) {
        parent.appendChild(created);
      } else if (prev2 !== created) {
        parent.replaceChild(created, prev2);
      }
      out ??= created;
    }
  }
  return out;
}
function createElementNode({ prev, next, dispatch, stack }) {
  const namespace = next.namespace || "http://www.w3.org/1999/xhtml";
  const canMorph = prev && prev.nodeType === Node.ELEMENT_NODE && prev.localName === next.tag && prev.namespaceURI === (next.namespace || "http://www.w3.org/1999/xhtml");
  const el = canMorph ? prev : namespace ? document.createElementNS(namespace, next.tag) : document.createElement(next.tag);
  let handlersForEl;
  if (!registeredHandlers.has(el)) {
    const emptyHandlers = /* @__PURE__ */ new Map();
    registeredHandlers.set(el, emptyHandlers);
    handlersForEl = emptyHandlers;
  } else {
    handlersForEl = registeredHandlers.get(el);
  }
  const prevHandlers = canMorph ? new Set(handlersForEl.keys()) : null;
  const prevAttributes = canMorph ? new Set(Array.from(prev.attributes, (a) => a.name)) : null;
  let className = null;
  let style3 = null;
  let innerHTML = null;
  if (canMorph && next.tag === "textarea") {
    const innertText = next.children[Symbol.iterator]().next().value?.content;
    if (innertText !== void 0)
      el.value = innertText;
  }
  const delegated = [];
  for (const attr of next.attrs) {
    const name = attr[0];
    const value3 = attr[1];
    if (attr.as_property) {
      if (el[name] !== value3)
        el[name] = value3;
      if (canMorph)
        prevAttributes.delete(name);
    } else if (name.startsWith("on")) {
      const eventName = name.slice(2);
      const callback = dispatch(value3, eventName === "input");
      if (!handlersForEl.has(eventName)) {
        el.addEventListener(eventName, lustreGenericEventHandler);
      }
      handlersForEl.set(eventName, callback);
      if (canMorph)
        prevHandlers.delete(eventName);
    } else if (name.startsWith("data-lustre-on-")) {
      const eventName = name.slice(15);
      const callback = dispatch(lustreServerEventHandler);
      if (!handlersForEl.has(eventName)) {
        el.addEventListener(eventName, lustreGenericEventHandler);
      }
      handlersForEl.set(eventName, callback);
      el.setAttribute(name, value3);
    } else if (name.startsWith("delegate:data-") || name.startsWith("delegate:aria-")) {
      el.setAttribute(name, value3);
      delegated.push([name.slice(10), value3]);
    } else if (name === "class") {
      className = className === null ? value3 : className + " " + value3;
    } else if (name === "style") {
      style3 = style3 === null ? value3 : style3 + value3;
    } else if (name === "dangerous-unescaped-html") {
      innerHTML = value3;
    } else {
      if (el.getAttribute(name) !== value3)
        el.setAttribute(name, value3);
      if (name === "value" || name === "selected")
        el[name] = value3;
      if (canMorph)
        prevAttributes.delete(name);
    }
  }
  if (className !== null) {
    el.setAttribute("class", className);
    if (canMorph)
      prevAttributes.delete("class");
  }
  if (style3 !== null) {
    el.setAttribute("style", style3);
    if (canMorph)
      prevAttributes.delete("style");
  }
  if (canMorph) {
    for (const attr of prevAttributes) {
      el.removeAttribute(attr);
    }
    for (const eventName of prevHandlers) {
      handlersForEl.delete(eventName);
      el.removeEventListener(eventName, lustreGenericEventHandler);
    }
  }
  if (next.tag === "slot") {
    window.queueMicrotask(() => {
      for (const child of el.assignedElements()) {
        for (const [name, value3] of delegated) {
          if (!child.hasAttribute(name)) {
            child.setAttribute(name, value3);
          }
        }
      }
    });
  }
  if (next.key !== void 0 && next.key !== "") {
    el.setAttribute("data-lustre-key", next.key);
  } else if (innerHTML !== null) {
    el.innerHTML = innerHTML;
    return el;
  }
  let prevChild = el.firstChild;
  let seenKeys = null;
  let keyedChildren = null;
  let incomingKeyedChildren = null;
  let firstChild = children(next).next().value;
  if (canMorph && firstChild !== void 0 && // Explicit checks are more verbose but truthy checks force a bunch of comparisons
  // we don't care about: it's never gonna be a number etc.
  firstChild.key !== void 0 && firstChild.key !== "") {
    seenKeys = /* @__PURE__ */ new Set();
    keyedChildren = getKeyedChildren(prev);
    incomingKeyedChildren = getKeyedChildren(next);
    for (const child of children(next)) {
      prevChild = diffKeyedChild(
        prevChild,
        child,
        el,
        stack,
        incomingKeyedChildren,
        keyedChildren,
        seenKeys
      );
    }
  } else {
    for (const child of children(next)) {
      stack.unshift({ prev: prevChild, next: child, parent: el });
      prevChild = prevChild?.nextSibling;
    }
  }
  while (prevChild) {
    const next2 = prevChild.nextSibling;
    el.removeChild(prevChild);
    prevChild = next2;
  }
  return el;
}
var registeredHandlers = /* @__PURE__ */ new WeakMap();
function lustreGenericEventHandler(event2) {
  const target = event2.currentTarget;
  if (!registeredHandlers.has(target)) {
    target.removeEventListener(event2.type, lustreGenericEventHandler);
    return;
  }
  const handlersForEventTarget = registeredHandlers.get(target);
  if (!handlersForEventTarget.has(event2.type)) {
    target.removeEventListener(event2.type, lustreGenericEventHandler);
    return;
  }
  handlersForEventTarget.get(event2.type)(event2);
}
function lustreServerEventHandler(event2) {
  const el = event2.currentTarget;
  const tag = el.getAttribute(`data-lustre-on-${event2.type}`);
  const data = JSON.parse(el.getAttribute("data-lustre-data") || "{}");
  const include = JSON.parse(el.getAttribute("data-lustre-include") || "[]");
  switch (event2.type) {
    case "input":
    case "change":
      include.push("target.value");
      break;
  }
  return {
    tag,
    data: include.reduce(
      (data2, property) => {
        const path = property.split(".");
        for (let i = 0, o = data2, e = event2; i < path.length; i++) {
          if (i === path.length - 1) {
            o[path[i]] = e[path[i]];
          } else {
            o[path[i]] ??= {};
            e = e[path[i]];
            o = o[path[i]];
          }
        }
        return data2;
      },
      { data }
    )
  };
}
function getKeyedChildren(el) {
  const keyedChildren = /* @__PURE__ */ new Map();
  if (el) {
    for (const child of children(el)) {
      const key = child?.key || child?.getAttribute?.("data-lustre-key");
      if (key)
        keyedChildren.set(key, child);
    }
  }
  return keyedChildren;
}
function diffKeyedChild(prevChild, child, el, stack, incomingKeyedChildren, keyedChildren, seenKeys) {
  while (prevChild && !incomingKeyedChildren.has(prevChild.getAttribute("data-lustre-key"))) {
    const nextChild = prevChild.nextSibling;
    el.removeChild(prevChild);
    prevChild = nextChild;
  }
  if (keyedChildren.size === 0) {
    stack.unshift({ prev: prevChild, next: child, parent: el });
    prevChild = prevChild?.nextSibling;
    return prevChild;
  }
  if (seenKeys.has(child.key)) {
    console.warn(`Duplicate key found in Lustre vnode: ${child.key}`);
    stack.unshift({ prev: null, next: child, parent: el });
    return prevChild;
  }
  seenKeys.add(child.key);
  const keyedChild = keyedChildren.get(child.key);
  if (!keyedChild && !prevChild) {
    stack.unshift({ prev: null, next: child, parent: el });
    return prevChild;
  }
  if (!keyedChild && prevChild !== null) {
    const placeholder = document.createTextNode("");
    el.insertBefore(placeholder, prevChild);
    stack.unshift({ prev: placeholder, next: child, parent: el });
    return prevChild;
  }
  if (!keyedChild || keyedChild === prevChild) {
    stack.unshift({ prev: prevChild, next: child, parent: el });
    prevChild = prevChild?.nextSibling;
    return prevChild;
  }
  el.insertBefore(keyedChild, prevChild);
  stack.unshift({ prev: keyedChild, next: child, parent: el });
  return prevChild;
}
function* children(element2) {
  for (const child of element2.children) {
    yield* forceChild(child);
  }
}
function* forceChild(element2) {
  if (element2.subtree !== void 0) {
    yield* forceChild(element2.subtree());
  } else {
    yield element2;
  }
}

// build/dev/javascript/lustre/lustre.ffi.mjs
var LustreClientApplication = class _LustreClientApplication {
  /**
   * @template Flags
   *
   * @param {object} app
   * @param {(flags: Flags) => [Model, Lustre.Effect<Msg>]} app.init
   * @param {(msg: Msg, model: Model) => [Model, Lustre.Effect<Msg>]} app.update
   * @param {(model: Model) => Lustre.Element<Msg>} app.view
   * @param {string | HTMLElement} selector
   * @param {Flags} flags
   *
   * @returns {Gleam.Ok<(action: Lustre.Action<Lustre.Client, Msg>>) => void>}
   */
  static start({ init: init2, update, view }, selector, flags) {
    if (!is_browser())
      return new Error(new NotABrowser());
    const root = selector instanceof HTMLElement ? selector : document.querySelector(selector);
    if (!root)
      return new Error(new ElementNotFound(selector));
    const app = new _LustreClientApplication(root, init2(flags), update, view);
    return new Ok((action) => app.send(action));
  }
  /**
   * @param {Element} root
   * @param {[Model, Lustre.Effect<Msg>]} init
   * @param {(model: Model, msg: Msg) => [Model, Lustre.Effect<Msg>]} update
   * @param {(model: Model) => Lustre.Element<Msg>} view
   *
   * @returns {LustreClientApplication}
   */
  constructor(root, [init2, effects], update, view) {
    this.root = root;
    this.#model = init2;
    this.#update = update;
    this.#view = view;
    this.#tickScheduled = window.requestAnimationFrame(
      () => this.#tick(effects.all.toArray(), true)
    );
  }
  /** @type {Element} */
  root;
  /**
   * @param {Lustre.Action<Lustre.Client, Msg>} action
   *
   * @returns {void}
   */
  send(action) {
    if (action instanceof Debug) {
      if (action[0] instanceof ForceModel) {
        this.#tickScheduled = window.cancelAnimationFrame(this.#tickScheduled);
        this.#queue = [];
        this.#model = action[0][0];
        const vdom = this.#view(this.#model);
        const dispatch = (handler, immediate = false) => (event2) => {
          const result = handler(event2);
          if (result instanceof Ok) {
            this.send(new Dispatch(result[0], immediate));
          }
        };
        const prev = this.root.firstChild ?? this.root.appendChild(document.createTextNode(""));
        morph(prev, vdom, dispatch);
      }
    } else if (action instanceof Dispatch) {
      const msg = action[0];
      const immediate = action[1] ?? false;
      this.#queue.push(msg);
      if (immediate) {
        this.#tickScheduled = window.cancelAnimationFrame(this.#tickScheduled);
        this.#tick();
      } else if (!this.#tickScheduled) {
        this.#tickScheduled = window.requestAnimationFrame(() => this.#tick());
      }
    } else if (action instanceof Emit2) {
      const event2 = action[0];
      const data = action[1];
      this.root.dispatchEvent(
        new CustomEvent(event2, {
          detail: data,
          bubbles: true,
          composed: true
        })
      );
    } else if (action instanceof Shutdown) {
      this.#tickScheduled = window.cancelAnimationFrame(this.#tickScheduled);
      this.#model = null;
      this.#update = null;
      this.#view = null;
      this.#queue = null;
      while (this.root.firstChild) {
        this.root.firstChild.remove();
      }
    }
  }
  /** @type {Model} */
  #model;
  /** @type {(model: Model, msg: Msg) => [Model, Lustre.Effect<Msg>]} */
  #update;
  /** @type {(model: Model) => Lustre.Element<Msg>} */
  #view;
  /** @type {Array<Msg>} */
  #queue = [];
  /** @type {number | undefined} */
  #tickScheduled;
  /**
   * @param {Lustre.Effect<Msg>[]} effects
   * @param {boolean} isFirstRender
   */
  #tick(effects = [], isFirstRender = false) {
    this.#tickScheduled = void 0;
    if (!this.#flush(effects, isFirstRender))
      return;
    const vdom = this.#view(this.#model);
    const dispatch = (handler, immediate = false) => (event2) => {
      const result = handler(event2);
      if (result instanceof Ok) {
        this.send(new Dispatch(result[0], immediate));
      }
    };
    const prev = this.root.firstChild ?? this.root.appendChild(document.createTextNode(""));
    morph(prev, vdom, dispatch);
  }
  #flush(effects = [], didUpdate = false) {
    while (this.#queue.length > 0) {
      const msg = this.#queue.shift();
      const [next, effect] = this.#update(this.#model, msg);
      didUpdate ||= this.#model !== next;
      effects = effects.concat(effect.all.toArray());
      this.#model = next;
    }
    while (effects.length > 0) {
      const effect = effects.shift();
      const dispatch = (msg) => this.send(new Dispatch(msg));
      const emit2 = (event2, data) => this.root.dispatchEvent(
        new CustomEvent(event2, {
          detail: data,
          bubbles: true,
          composed: true
        })
      );
      const select2 = () => {
      };
      const root = this.root;
      effect({ dispatch, emit: emit2, select: select2, root });
    }
    if (this.#queue.length > 0) {
      return this.#flush(effects, didUpdate);
    } else {
      return didUpdate;
    }
  }
};
var start = LustreClientApplication.start;
var LustreServerApplication = class _LustreServerApplication {
  static start({ init: init2, update, view, on_attribute_change }, flags) {
    const app = new _LustreServerApplication(
      init2(flags),
      update,
      view,
      on_attribute_change
    );
    return new Ok((action) => app.send(action));
  }
  constructor([model, effects], update, view, on_attribute_change) {
    this.#model = model;
    this.#update = update;
    this.#view = view;
    this.#html = view(model);
    this.#onAttributeChange = on_attribute_change;
    this.#renderers = /* @__PURE__ */ new Map();
    this.#handlers = handlers(this.#html);
    this.#tick(effects.all.toArray());
  }
  send(action) {
    if (action instanceof Attrs) {
      for (const attr of action[0]) {
        const decoder = this.#onAttributeChange.get(attr[0]);
        if (!decoder)
          continue;
        const msg = decoder(attr[1]);
        if (msg instanceof Error)
          continue;
        this.#queue.push(msg);
      }
      this.#tick();
    } else if (action instanceof Batch) {
      this.#queue = this.#queue.concat(action[0].toArray());
      this.#tick(action[1].all.toArray());
    } else if (action instanceof Debug) {
    } else if (action instanceof Dispatch) {
      this.#queue.push(action[0]);
      this.#tick();
    } else if (action instanceof Emit2) {
      const event2 = new Emit(action[0], action[1]);
      for (const [_, renderer] of this.#renderers) {
        renderer(event2);
      }
    } else if (action instanceof Event2) {
      const handler = this.#handlers.get(action[0]);
      if (!handler)
        return;
      const msg = handler(action[1]);
      if (msg instanceof Error)
        return;
      this.#queue.push(msg[0]);
      this.#tick();
    } else if (action instanceof Subscribe) {
      const attrs = keys(this.#onAttributeChange);
      const patch = new Init(attrs, this.#html);
      this.#renderers = this.#renderers.set(action[0], action[1]);
      action[1](patch);
    } else if (action instanceof Unsubscribe) {
      this.#renderers = this.#renderers.delete(action[0]);
    }
  }
  #model;
  #update;
  #queue;
  #view;
  #html;
  #renderers;
  #handlers;
  #onAttributeChange;
  #tick(effects = []) {
    if (!this.#flush(false, effects))
      return;
    const vdom = this.#view(this.#model);
    const diff2 = elements(this.#html, vdom);
    if (!is_empty_element_diff(diff2)) {
      const patch = new Diff(diff2);
      for (const [_, renderer] of this.#renderers) {
        renderer(patch);
      }
    }
    this.#html = vdom;
    this.#handlers = diff2.handlers;
  }
  #flush(didUpdate = false, effects = []) {
    while (this.#queue.length > 0) {
      const msg = this.#queue.shift();
      const [next, effect] = this.#update(this.#model, msg);
      didUpdate ||= this.#model !== next;
      effects = effects.concat(effect.all.toArray());
      this.#model = next;
    }
    while (effects.length > 0) {
      const effect = effects.shift();
      const dispatch = (msg) => this.send(new Dispatch(msg));
      const emit2 = (event2, data) => this.root.dispatchEvent(
        new CustomEvent(event2, {
          detail: data,
          bubbles: true,
          composed: true
        })
      );
      const select2 = () => {
      };
      const root = null;
      effect({ dispatch, emit: emit2, select: select2, root });
    }
    if (this.#queue.length > 0) {
      return this.#flush(didUpdate, effects);
    } else {
      return didUpdate;
    }
  }
};
var start_server_application = LustreServerApplication.start;
var is_browser = () => globalThis.window && window.document;

// build/dev/javascript/lustre/lustre.mjs
var App = class extends CustomType {
  constructor(init2, update, view, on_attribute_change) {
    super();
    this.init = init2;
    this.update = update;
    this.view = view;
    this.on_attribute_change = on_attribute_change;
  }
};
var ElementNotFound = class extends CustomType {
  constructor(selector) {
    super();
    this.selector = selector;
  }
};
var NotABrowser = class extends CustomType {
};
function application(init2, update, view) {
  return new App(init2, update, view, new None());
}
function start2(app, selector, flags) {
  return guard(
    !is_browser(),
    new Error(new NotABrowser()),
    () => {
      return start(app, selector, flags);
    }
  );
}

// build/dev/javascript/lustre/lustre/element/html.mjs
function text2(content) {
  return text(content);
}
function style2(attrs, css) {
  return element("style", attrs, toList([text2(css)]));
}
function article(attrs, children2) {
  return element("article", attrs, children2);
}
function h1(attrs, children2) {
  return element("h1", attrs, children2);
}
function h2(attrs, children2) {
  return element("h2", attrs, children2);
}
function hgroup(attrs, children2) {
  return element("hgroup", attrs, children2);
}
function section(attrs, children2) {
  return element("section", attrs, children2);
}
function div(attrs, children2) {
  return element("div", attrs, children2);
}
function code(attrs, children2) {
  return element("code", attrs, children2);
}
function option(attrs, label) {
  return element("option", attrs, toList([text(label)]));
}
function select(attrs, children2) {
  return element("select", attrs, children2);
}

// build/dev/javascript/lustre/lustre/event.mjs
function on2(name, handler) {
  return on(name, handler);
}
function value2(event2) {
  let _pipe = event2;
  return field("target", field("value", string))(
    _pipe
  );
}
function on_input(msg) {
  return on2(
    "input",
    (event2) => {
      let _pipe = value2(event2);
      return map2(_pipe, msg);
    }
  );
}

// build/dev/javascript/gleam_community_colour/gleam_community/colour/accessibility.mjs
function intensity(colour_value) {
  let $ = true;
  if (colour_value <= 0.03928) {
    return divideFloat(colour_value, 12.92);
  } else {
    let $1 = power(divideFloat(colour_value + 0.055, 1.055), 2.4);
    if (!$1.isOk()) {
      throw makeError(
        "let_assert",
        "gleam_community/colour/accessibility",
        62,
        "intensity",
        "Pattern match failed, no pattern matched the value.",
        { value: $1 }
      );
    }
    let i = $1[0];
    return i;
  }
}
function luminance(colour) {
  let $ = to_rgba(colour);
  let r = $[0];
  let g = $[1];
  let b = $[2];
  let r_intensity = intensity(r);
  let g_intensity = intensity(g);
  let b_intensity = intensity(b);
  return 0.2126 * r_intensity + 0.7152 * g_intensity + 0.0722 * b_intensity;
}
function contrast_ratio(colour_a, colour_b) {
  let luminance_a = luminance(colour_a) + 0.05;
  let luminance_b = luminance(colour_b) + 0.05;
  let $ = luminance_a > luminance_b;
  if ($) {
    return divideFloat(luminance_a, luminance_b);
  } else {
    return divideFloat(luminance_b, luminance_a);
  }
}

// build/dev/javascript/app/app/colors.mjs
var ColorScale = class extends CustomType {
  constructor(bg, bg_subtle, tint, tint_subtle, tint_strong, accent, accent_subtle, accent_strong, solid, solid_subtle, solid_strong, solid_text, text_subtle, text3, shadow) {
    super();
    this.bg = bg;
    this.bg_subtle = bg_subtle;
    this.tint = tint;
    this.tint_subtle = tint_subtle;
    this.tint_strong = tint_strong;
    this.accent = accent;
    this.accent_subtle = accent_subtle;
    this.accent_strong = accent_strong;
    this.solid = solid;
    this.solid_subtle = solid_subtle;
    this.solid_strong = solid_strong;
    this.solid_text = solid_text;
    this.text_subtle = text_subtle;
    this.text = text3;
    this.shadow = shadow;
  }
};
function from_rgb(r, g, b) {
  let $ = from_rgb255(r, g, b);
  if (!$.isOk()) {
    throw makeError(
      "let_assert",
      "app/colors",
      70,
      "from_rgb",
      "Pattern match failed, no pattern matched the value.",
      { value: $ }
    );
  }
  let colour = $[0];
  return colour;
}
function default_base() {
  return new ColorScale(
    from_rgb(252, 252, 253),
    from_rgb(249, 249, 251),
    from_rgb(232, 232, 236),
    from_rgb(240, 240, 243),
    from_rgb(224, 225, 230),
    from_rgb(205, 206, 214),
    from_rgb(217, 217, 224),
    from_rgb(185, 187, 198),
    from_rgb(139, 141, 152),
    from_rgb(150, 152, 162),
    from_rgb(128, 131, 141),
    from_rgb(255, 255, 255),
    from_rgb(96, 100, 108),
    from_rgb(28, 32, 36),
    from_rgb(28, 32, 36)
  );
}
function float_string(value3) {
  let precision = 2;
  let base = (() => {
    let _pipe = value3;
    let _pipe$1 = truncate2(_pipe);
    return to_string2(_pipe$1);
  })();
  let decimals = (() => {
    let _pipe = value3;
    let _pipe$1 = modulo(_pipe, 1);
    let _pipe$2 = unwrap(_pipe$1, 0);
    let _pipe$3 = to_string4(_pipe$2);
    let _pipe$4 = slice(_pipe$3, 2, precision);
    return pad_left(_pipe$4, precision, "0");
  })();
  return base + "." + decimals;
}
function color_stats(color, bg_color, base_bg_color) {
  let $ = to_hsla(color);
  let h = $[0];
  let s = $[1];
  let l = $[2];
  return toList([
    ["contrast", float_string(contrast_ratio(bg_color, color))],
    ["luminance", float_string(luminance(color))],
    [
      "hsl",
      float_string(h) + " " + float_string(s) + " " + float_string(l) + " "
    ]
  ]);
}

// build/dev/javascript/app/app/fonts.mjs
var FontPalette = class extends CustomType {
  constructor(name, heading, text3, code2) {
    super();
    this.name = name;
    this.heading = heading;
    this.text = text3;
    this.code = code2;
  }
};
var Font = class extends CustomType {
  constructor(name, css, css_import, href) {
    super();
    this.name = name;
    this.css = css;
    this.css_import = css_import;
    this.href = href;
  }
};
function font_from_href(href) {
  let name = (() => {
    let _pipe = href;
    let _pipe$1 = split3(_pipe, "/");
    let _pipe$2 = last(_pipe$1);
    let _pipe$3 = unwrap(_pipe$2, "");
    return replace(_pipe$3, "+", " ");
  })();
  return new Font(
    name,
    '"' + name + '"',
    replace(name, " ", "+"),
    href
  );
}
function font_palette_from_hrefs(pair) {
  let font_heading_href = pair[0];
  let font_text_href = pair[1];
  let font_heading = font_from_href(font_heading_href);
  let font_text = font_from_href(font_text_href);
  let font_code = font_from_href(
    "https://fonts.google.com/specimen/JetBrains+Mono"
  );
  return new FontPalette(
    font_heading.name + " + " + font_text.name,
    font_heading,
    font_text,
    font_code
  );
}
function default_palette() {
  return font_palette_from_hrefs(
    [
      "https://fonts.google.com/specimen/Playfair+Display",
      "https://fonts.google.com/specimen/Source+Sans+Pro"
    ]
  );
}
var font_pairs_hrefs = /* @__PURE__ */ toList([
  [
    "https://fonts.google.com/specimen/Playfair+Display",
    "https://fonts.google.com/specimen/Source+Sans+Pro"
  ],
  [
    "https://fonts.google.com/specimen/Playfair+Display",
    "https://fonts.google.com/specimen/Source+Sans+Pro"
  ],
  [
    "https://fonts.google.com/specimen/Quattrocento",
    "https://fonts.google.com/specimen/Quattrocento+Sans"
  ],
  [
    "https://fonts.google.com/specimen/Quattrocento",
    "https://fonts.google.com/specimen/Fanwood+Text"
  ],
  [
    "https://fonts.google.com/specimen/Oswald",
    "https://fonts.google.com/specimen/Quattrocento"
  ],
  [
    "https://fonts.google.com/specimen/Fjalla+One",
    "https://fonts.google.com/specimen/Libre+Baskerville"
  ],
  [
    "https://fonts.google.com/specimen/Lustria",
    "https://fonts.google.com/specimen/Lato"
  ],
  [
    "https://fonts.google.com/specimen/Cormorant+Garamond",
    "https://fonts.google.com/specimen/Proza+Libre"
  ],
  [
    "https://fonts.google.com/specimen/Oswald",
    "https://fonts.google.com/specimen/EB+Garamond"
  ],
  [
    "https://fonts.google.com/specimen/Libre+Baskerville",
    "https://fonts.google.com/specimen/Source+Sans+Pro"
  ],
  [
    "https://fonts.google.com/specimen/Cinzel",
    "https://fonts.google.com/specimen/Fauna+One"
  ],
  [
    "https://fonts.google.com/specimen/Sacramento",
    "https://fonts.google.com/specimen/Alice"
  ],
  [
    "https://fonts.google.com/specimen/Yeseva+One",
    "https://fonts.google.com/specimen/Josefin+Sans"
  ],
  [
    "https://fonts.google.com/specimen/Libre+Baskerville",
    "https://fonts.google.com/specimen/Josefin+Sans"
  ],
  [
    "https://fonts.google.com/specimen/Cardo",
    "https://fonts.google.com/specimen/Josefin+Sans"
  ],
  [
    "https://fonts.google.com/specimen/Lora",
    "https://fonts.google.com/specimen/Roboto"
  ],
  [
    "https://fonts.google.com/specimen/Spectral",
    "https://fonts.google.com/specimen/Karla"
  ],
  [
    "https://fonts.google.com/specimen/Halant",
    "https://fonts.google.com/specimen/Nunito+Sans"
  ],
  [
    "https://fonts.google.com/specimen/Karla",
    "https://fonts.google.com/specimen/Karla"
  ],
  [
    "https://fonts.google.com/specimen/Lora",
    "https://fonts.google.com/specimen/Merriweather"
  ],
  [
    "https://fonts.google.com/specimen/Roboto",
    "https://fonts.google.com/specimen/Nunito"
  ],
  [
    "https://fonts.google.com/specimen/Quicksand",
    "https://fonts.google.com/specimen/Quicksand"
  ],
  [
    "https://fonts.google.com/specimen/Ubuntu",
    "https://fonts.google.com/specimen/Open+Sans"
  ],
  [
    "https://fonts.google.com/specimen/Montserrat",
    "https://fonts.google.com/specimen/Hind"
  ],
  [
    "https://fonts.google.com/specimen/Nunito",
    "https://fonts.google.com/specimen/PT+Sans"
  ],
  [
    "https://fonts.google.com/specimen/Oswald",
    "https://fonts.google.com/specimen/Merriweather"
  ],
  [
    "https://fonts.google.com/specimen/Montserrat",
    "https://fonts.google.com/specimen/Cardo"
  ],
  [
    "https://fonts.google.com/specimen/Montserrat",
    "https://fonts.google.com/specimen/Crimson+Text"
  ],
  [
    "https://fonts.google.com/specimen/Open+Sans",
    "https://fonts.google.com/specimen/Open+Sans+Condensed"
  ],
  [
    "https://fonts.google.com/specimen/Nunito",
    "https://fonts.google.com/specimen/Nunito"
  ],
  [
    "https://fonts.google.com/specimen/Arvo",
    "https://fonts.google.com/specimen/Lato"
  ],
  [
    "https://fonts.google.com/specimen/Abril+Fatface",
    "https://fonts.google.com/specimen/Poppins"
  ],
  [
    "https://fonts.google.com/specimen/Playfair+Display",
    "https://fonts.google.com/specimen/Source+Sans+Pro"
  ],
  [
    "https://fonts.google.com/specimen/Karla",
    "https://fonts.google.com/specimen/Inconsolata"
  ],
  [
    "https://fonts.google.com/specimen/Ultra",
    "https://fonts.google.com/specimen/Slabo+27px"
  ],
  [
    "https://fonts.google.com/specimen/Nixie+One",
    "https://fonts.google.com/specimen/Ledger"
  ],
  [
    "https://fonts.google.com/specimen/Stint+Ultra+Expanded",
    "https://fonts.google.com/specimen/Pontano+Sans"
  ],
  [
    "https://fonts.google.com/specimen/Amatic+SC",
    "https://fonts.google.com/specimen/Andika"
  ],
  [
    "https://fonts.google.com/specimen/Unica+One",
    "https://fonts.google.com/specimen/Crimson+Text"
  ],
  [
    "https://fonts.google.com/specimen/Philosopher",
    "https://fonts.google.com/specimen/Muli"
  ],
  [
    "https://fonts.google.com/specimen/Source+Sans+Pro",
    "https://fonts.google.com/specimen/Source+Serif+Pro"
  ],
  [
    "https://fonts.google.com/specimen/Fjalla+One",
    "https://fonts.google.com/specimen/Cantarell"
  ],
  [
    "https://fonts.google.com/specimen/Work+Sans",
    "https://fonts.google.com/specimen/Open+Sans"
  ],
  [
    "https://fonts.google.com/specimen/Hind",
    "https://fonts.google.com/specimen/Open+Sans"
  ],
  [
    "https://fonts.google.com/specimen/Nunito",
    "https://fonts.google.com/specimen/Open+Sans"
  ],
  [
    "https://fonts.google.com/specimen/Oxygen",
    "https://fonts.google.com/specimen/Source+Sans+Pro"
  ],
  [
    "https://fonts.google.com/specimen/PT+Sans",
    "https://fonts.google.com/specimen/Cabin"
  ],
  [
    "https://fonts.google.com/specimen/Roboto+Condensed",
    "https://fonts.google.com/specimen/Cabin"
  ],
  [
    "https://fonts.google.com/specimen/Raleway",
    "https://fonts.google.com/specimen/Open+Sans"
  ],
  [
    "https://fonts.google.com/specimen/Roboto",
    "https://fonts.google.com/specimen/Lora"
  ]
]);
function palettes() {
  return map(font_pairs_hrefs, font_palette_from_hrefs);
}

// build/dev/javascript/app/app.mjs
var Model2 = class extends CustomType {
  constructor(font_palettes, font_palette) {
    super();
    this.font_palettes = font_palettes;
    this.font_palette = font_palette;
  }
};
var OnSelectFontPalette = class extends CustomType {
  constructor(x0) {
    super();
    this[0] = x0;
  }
};
function font_import_family(font) {
  return "&family=" + font.css_import;
}
function font_imports(font_palette) {
  return "@import url('https://fonts.googleapis.com/css2?display=block" + font_import_family(
    font_palette.heading
  ) + font_import_family(font_palette.text) + font_import_family(
    font_palette.code
  );
}
function header() {
  return hgroup(
    toList([]),
    toList([
      h1(
        toList([class$("font-heading text-3xl")]),
        toList([text("W Theme")])
      ),
      h2(
        toList([class$("text-subtle")]),
        toList([
          text(
            "A theme schema designed for consistency and flexibility with support for light and dark modes."
          )
        ])
      )
    ])
  );
}
function view_color_scale(color_scale, base_scale) {
  let color_base = to_hsla(color_scale.solid);
  let color_hue = color_base[0];
  let color_saturation = color_base[1];
  return section(
    toList([class$("flex gap-sm")]),
    (() => {
      let _pipe = toList([
        [color_scale.bg, color_scale.bg],
        [color_scale.bg_subtle, color_scale.bg],
        [color_scale.tint_subtle, color_scale.bg],
        [color_scale.tint, color_scale.bg],
        [color_scale.tint_strong, color_scale.bg],
        [color_scale.accent_subtle, color_scale.bg],
        [color_scale.accent, color_scale.bg],
        [color_scale.accent_strong, color_scale.bg],
        [color_scale.solid_subtle, color_scale.bg],
        [color_scale.solid, color_scale.bg],
        [color_scale.solid_strong, color_scale.bg],
        [color_scale.solid_text, color_scale.solid],
        [color_scale.text_subtle, color_scale.bg],
        [color_scale.text, color_scale.bg],
        [color_scale.shadow, color_scale.bg]
      ]);
      return map(
        _pipe,
        (pair) => {
          let color = pair[0];
          let bg_color = pair[1];
          let color_norm = (() => {
            let _pipe$1 = color;
            let _pipe$2 = to_hsla(_pipe$1);
            return ((x) => {
              let $ = from_hsla(color_hue, color_saturation, x[2], 1);
              if (!$.isOk()) {
                throw makeError(
                  "let_assert",
                  "app",
                  150,
                  "",
                  "Pattern match failed, no pattern matched the value.",
                  { value: $ }
                );
              }
              let c = $[0];
              return c;
            })(_pipe$2);
          })();
          let color_stats2 = color_stats(
            color_norm,
            bg_color,
            base_scale.bg
          );
          return div(
            toList([class$("flex flex-col gap-sm")]),
            toList([
              div(
                toList([
                  class$("h-lg w-lg"),
                  style(
                    toList([["background", to_css_rgba_string(color)]])
                  )
                ]),
                toList([])
              ),
              div(
                toList([
                  class$("h-lg w-lg"),
                  style(
                    toList([
                      ["background", to_css_rgba_string(color_norm)]
                    ])
                  )
                ]),
                toList([])
              ),
              div(
                toList([class$("text-sm")]),
                (() => {
                  let _pipe$1 = color_stats2;
                  return map(
                    _pipe$1,
                    (stat) => {
                      return fragment(
                        toList([
                          div(
                            toList([class$("col-span-8")]),
                            toList([text(second(stat))])
                          )
                        ])
                      );
                    }
                  );
                })()
              )
            ])
          );
        }
      );
    })()
  );
}
function theme_builder(model) {
  let base_color_scale = default_base();
  return article(
    toList([]),
    toList([
      h1(
        toList([class$("font-heading text-3xl")]),
        toList([text("Theme Builder")])
      ),
      select(
        toList([
          value(model.font_palette.name),
          on_input((var0) => {
            return new OnSelectFontPalette(var0);
          })
        ]),
        (() => {
          let _pipe = model.font_palettes;
          return map(
            _pipe,
            (palette) => {
              return option(toList([value(palette.name)]), palette.name);
            }
          );
        })()
      ),
      view_color_scale(base_color_scale, base_color_scale)
    ])
  );
}
function main_content() {
  return code(
    toList([class$("font-text")]),
    toList([
      text(
        '\n            <h2 id="colors">Colors</h2>\n      <p>We can safely say that colors are the star of the show of any theme.\n        Our theme specification is made of a <em>color palette of 6 colors</em> and each color is made of a <em>scale of\n          12 variations</em>.\n        This might seem like <em>a lot</em> of available colors, but this was decided through a lot of real world\n        experimentation and minimalistic color scales ended up relying on other factors such as opacity for achieving\n        the flexibility needed for building rich UI&#39;s.\n        This ends up becoming a huge pain to maintain and opacity is <em>not</em> an ideal way of mixing colors.\n        With this set of colors available, we&#39;re confident that you can build rich interfaces without opting for\n        escape hatches of your design system.</p>\n      <h3 id="color-palette">Color Palette</h3>\n      <blockquote>\n        <p>a.k.a &quot;color variants&quot;</p>\n      </blockquote>\n      <p>Every theme is built using a palette of 6 colors.</p>\n      <ul>\n        <li><strong>Base</strong> \u2014 used for most of the content, the main background, text colors, etc.</li>\n        <li><strong>Primary</strong> \xAD\u2014 used for content highlights with a contrasting color, sometimes called\n          <em>&quot;accent&quot;</em> color.\n        </li>\n        <li><strong>Secondary</strong> \u2014 used as an alternative to the primary color, giving flexibility to your\n          designs.</li>\n        <li><strong>Success</strong> \u2014 used for positive content. <em>e.g. success feedbacks, confirm buttons, \u2026</em>\n        </li>\n        <li><strong>Warning</strong> \xAD\u2014 used for cautionary content. <em>e.g. non critical warning messages</em></li>\n        <li><strong>Danger</strong> \u2014 used for errors and destructive content. <em>e.g. failure feedbacks, delete\n            buttons, \u2026</em></li>\n      </ul>\n      <h3 id="color-scale">Color Scale</h3>\n      <p>Each color is defined using a scale with 12 steps.</p>\n      <h4 id="background">Background</h4>\n      <ul>\n        <li><strong>bg</strong> \u2014 the main background of your ui</li>\n        <li><strong>bg-subtle</strong> \u2014 an alternate, slightly darker, color of your main background. useful for\n          creating depth.</li>\n      </ul>\n      <h4 id="tint">Tint</h4>\n      <ul>\n        <li><strong>tint</strong> \u2014 useful for subtle backgrounds of some UI elements.</li>\n        <li><strong>tint-subtle</strong> \u2014 subtler variation, useful for &quot;pressed&quot; states.</li>\n        <li><strong>tint-strong</strong> \u2014 stronger variation, useful for &quot;hovered&quot; states.</li>\n      </ul>\n      <h4 id="accent">Accent</h4>\n      <ul>\n        <li><strong>accent</strong> \u2014 useful for dividers, borders and other small UI elements.</li>\n        <li><strong>accent-subtle</strong> \u2014 subtle variation, useful for &quot;pressed&quot; states.</li>\n        <li><strong>accent-strong</strong> \u2014 stronger variation, useful for &quot;hovered&quot; states.</li>\n      </ul>\n      <p><strong>Accent</strong> colors are not made for background or text usage as they&#39;re not guaranteed to have\n        proper contrast, they should be used for colored elements.</p>\n      <h4 id="solid">Solid</h4>\n      <ul>\n        <li><strong>solid</strong> \u2014 useful for solid elements such as buttons.</li>\n        <li><strong>solid-subtle</strong> \u2014 subtle variation, useful for &quot;pressed&quot; states.</li>\n        <li><strong>solid-strong</strong> \u2014 stronger variation, useful for &quot;hovered&quot; states.</li>\n        <li><strong>solid-text</strong> \u2014 contrasting color ensuring legibility of text over solid backgrounds</li>\n      </ul>\n      <p><strong>Solid</strong> colors should use <strong>solid-text</strong> as their text color for proper\n        accessibility.</p>\n      <h4 id="text">Text</h4>\n      <ul>\n        <li><strong>text</strong> \u2014 the main text color of your application.</li>\n        <li><strong>text-subtle</strong> \u2014 subtler variation for secondary text.</li>\n      </ul>\n      <p>Both <strong>text colors</strong> are guaranteed to be <strong>accessible</strong> over any\n        <strong>background</strong> and <strong>tint</strong> colors.\n      </p>\n      <h4 id="shadow">Shadow</h4>\n      <ul>\n        <li><strong>shadow</strong> \u2014 a darker shade of the color, useful for coloring shadows.</li>\n      </ul>\n      <p>Shadows are usually used with alpha values for better effects: <code>rgb(var(--w-base-shadow) / 0.25)</code>\n      </p>\n      <blockquote>\n        <p>[!TIP]\n          We use &quot;color channels&quot; on our CSS variable colors instead of a defined color space. So we can:</p>\n        <ul>\n          <li>Create transparent variations of any colors like this <code>rgb(--var(--w-base-bg) / 0.5)</code></li>\n          <li>Be <a href="">tailwindcss compatible</a> so you can use their colors using tailwind&#39;s opacity\n            functions <code>bg-primary/50</code></li>\n        </ul>\n        <p>So, remember to always use the colors variables like</p>\n        <ul>\n          <li><code>rgb(--var(--w-primary-solid))</code></li>\n          <li>Or <code>rgb(--var(--w-primary-solid) / 0.5)</code></li>\n        </ul>\n        <p>[!NOTE]\n          Our color scale was largely inspired by <a href="https://www.radix-ui.com/colors">radix-colors</a>. Do you\n          want to know what are the differences?\n          Their colors are built using a 1-12 scale with semantic meaning given through documentation.</p>\n        <ul>\n          <li>Semantic names are used instead of their number based naming.</li>\n          <li>We ensure consistency across the main color spaces, so our <strong>tint</strong>, <strong>accent</strong>\n            and <strong>solid</strong> colors have the same tones available.</li>\n          <li>We included the contrasting <code>solid-text</code> into our scale, instead of relying on <a\n              href="https://www.radix-ui.com/colors/docs/palette-composition/understanding-the-scale#steps-910-solid-backgrounds">different\n              implied values for some colors</a>.</li>\n          <li><code>bg-subtle</code> is <em>always</em> darker than <code>bg</code>, while radix&#39;s 2nd color\n            contrast differs between light and dark modes.</li>\n          <li><code>solid-text</code> is not an official color on the radix scale, it is supposed to be implied\n            depending on the color used (most colors use white as contrast color but some hand-picked colors use a\n            darker tone). We made it an official color so it is easier to build UI&#39;s without knowing the color that\n            is being used. </li>\n          <li><code>shadow</code> is a scale itself in radix and not a color shade.</li>\n        </ul>\n      </blockquote>\n      <h2 id="font-families">Font Families</h2>\n      <p>Not a lot to cover regarding our font family tokens. You can define then with fallback values, just like you\n        would when defining the <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/font-family">font-family</a>\n        css property.</p>\n      <pre><code class="lang-yaml">-<span class="ruby"> heading\n          </span>-<span class="ruby"> text\n          </span>-<span class="ruby"> code</span>\n        </code></pre>\n      <h2 id="font-size">Font Size</h2>\n      <p>The font sizes should be defined using <code>rem</code> values. This way you can control all of your\n        interface&#39;s sizes by moving the base value of your font size in a single place.\n        The scale chosen here was deeply inspired by <a href="https://tailwindcss.com/docs/font-size">TailwindCSS</a>.\n      </p>\n      <pre><code class="lang-yaml">-<span class="ruby"> xs\n          </span>-<span class="ruby"> sm\n          </span>-<span class="ruby"> md\n          </span>-<span class="ruby"> lg\n          </span>-<span class="ruby"> xl\n          </span>-<span class="ruby"> <span class="hljs-number">2</span>xl\n          </span>-<span class="ruby"> <span class="hljs-number">3</span>xl\n          </span>`\n        </code></pre>\n      <h2 id="font-tracking">Font Tracking</h2>\n      <p>Also known as <strong>letter spacing</strong>. Font tracking controls how each character is spaced to each\n        other. These values are defined using <code>em</code> units, so the setting works in relation to the currently\n        used font size.\n        The scale chosen here was deeply inspired by <a\n          href="https://tailwindcss.com/docs/letter-spacing">TailwindCSS</a>.</p>\n      <pre><code class="lang-yaml">-<span class="ruby"> xs\n          </span>-<span class="ruby"> sm\n          </span>-<span class="ruby"> md\n          </span>-<span class="ruby"> lg\n          </span>-<span class="ruby"> xl\n          </span>-<span class="ruby"> <span class="hljs-number">2</span>xl\n          </span>-<span class="ruby"> <span class="hljs-number">3</span>xl\n          </span>`\n        </code></pre>\n      <h2 id="font-leading">Font Leading</h2>\n      <p>Also known as <strong>line height</strong>. Font tracking controls how each character is spaced to each other.\n        These values are defined using <code>em</code> units, so the setting works in relation to the currently used\n        font size.\n        The scale chosen here was deeply inspired by <a href="https://tailwindcss.com/docs/line-height">TailwindCSS</a>.\n      </p>\n      <pre><code class="lang-yaml">-<span class="ruby"> xs\n          </span>-<span class="ruby"> sm\n          </span>-<span class="ruby"> md\n          </span>-<span class="ruby"> lg\n          </span>-<span class="ruby"> xl\n          </span>-<span class="ruby"> <span class="hljs-number">2</span>xl\n          </span>-<span class="ruby"> <span class="hljs-number">3</span>xl\n          </span>`\n        </code></pre>\n      <h2 id="spacing">Spacing</h2>\n      <p>The most important thing about spacing variables is to use <code>rem</code> based values. This way your whole\n        interface gets properly spaced when the user decides to increase their default font value for accessibility\n        reasons.\n        Also, you can even play around with base font values across different pages of your applications and get great\n        looking results! For instance, maybe your marketing website would benefit from larger fonts and buttons, you can\n        make that happen by just adjusting the <code>font-size</code> ha of your <code>h</code> element.\n        :sparkles:</p>\n      <p>The scale chosen here was deeply inspired by <a\n          href="https://tailwindcss.com/docs/customizing-spacing">TailwindCSS</a>.\n        The idea of using naming based values instead of number based is that you can even integrate w-theme with\n        tailwind and still be able to use both scales interchangeably (e.g <code>p-4 m-sm</code>)</p>\n      <pre><code class="lang-yaml">-<span class="ruby"> xs\n          </span>-<span class="ruby"> sm\n          </span>-<span class="ruby"> md\n          </span>-<span class="ruby"> lg\n          </span>-<span class="ruby"> xl\n          </span>-<span class="ruby"> <span class="hljs-number">2</span>xl\n          </span>-<span class="ruby"> <span class="hljs-number">3</span>xl\n          </span>`\n        </code></pre>\n      <h2 id="sizing">Sizing</h2>\n      <p>Sizing values are mostly used to define widths of elements such as containers, sidebars, modals, etc.\n        We advise the usage of <code>rem</code> based values so that your sizings will scale consistently.</p>\n      <p>The scale chosen here was deeply inspired by <a href="https://tailwindcss.com/docs/container">TailwindCSS</a>.\n      </p>\n      <pre><code class="lang-yaml">-<span class="ruby"> xs\n          </span>-<span class="ruby"> sm\n          </span>-<span class="ruby"> md\n          </span>-<span class="ruby"> lg\n          </span>-<span class="ruby"> xl\n          </span>-<span class="ruby"> <span class="hljs-number">2</span>xl\n          </span>-<span class="ruby"> <span class="hljs-number">3</span>xl\n          </span>`\n        </code></pre>\n      <h2 id="border-radius">Border Radius</h2>\n      <p>Just as spacing and sizing values, we advise the usage of <code>rem</code> based values so that your border\n        radius will scale consistently.</p>\n      <ul>\n        <li>xs</li>\n        <li>sm</li>\n        <li>md</li>\n        <li>lg</li>\n        <li>xl</li>\n        <li>2xl</li>\n        <li>3xl</li>\n      </ul>\n      <p>The default border radius we provide are usually 50% of the size of the related spacing variable, that way you\n        can usually get good results when pairing them.</p>\n      <pre><code><span class="hljs-selector-class">.button</span> {\n          <span class="hljs-ha">padding</span>: <span class="hljs-built_in">var</span>(--w-spacing-md);\n          <span class="hljs-ha">border-radius</span>: <span class="hljs-built_in">var</span>(--w-radius-md);\n          }\n        </code></pre>\n      <p>The scale chosen here was deeply inspired by <a\n          href="https://tailwindcss.com/docs/border-radius">TailwindCSS</a>.\n        In fact, you can integrate our scale into your tailwind theme with no surprises! Just be aware of one small\n        translation:</p>\n      <pre><code class="lang-css"><span class="hljs-selector-class">.rounded-sm</span> <span class="hljs-comment">/*\n            --w-radius-xs (our "xs" becomes tailwind\'s "sm") */</span>\n          <span class="hljs-selector-class">.rounded</span> <span class="hljs-comment">/* --w-radius-sm (our "sm"\n            becomes tailwind\'s default) */</span>\n          <span class="hljs-selector-class">.rounded-md</span> <span class="hljs-comment">/* --w-radius-md (things are\n            named equally starting from here) */</span>\n          ...\n        </code></pre>\n      <h1 id="javascript-api">Javascript API</h1>\n      <p>Use our provided API to quickly declare themes and their related CSS.</p>\n      <pre><code>npm <span class="hljs-selector-tag">i</span> -D w-theme\n        </code></pre>\n      <blockquote>\n        <p>[!NOTE]\n          You should mostly use our Javascript API for code-generation (css/js/h).\n          This library is not optimized to be used as part of your production application.\n          However, you&#39;re free to use it on the browser for theme exploration sandboxes, etc.</p>\n      </blockquote>\n      <h4 id="using-built-in-colors">Using built-in colors</h4>\n      <p>The quickest way to create a theme is to use one of our <a\n          href="https://github.com/georgesboris/w-theme/tree/main/src/w/colors.js">built-in colors</a>.</p>\n      <pre><code class="lang-js"><span class="hljs-keyword">import</span> wt from <span\n            class="hljs-string">"w-theme"</span>\n\n          const <span class="hljs-built_in">theme</span> = wt.<span class="hljs-built_in">theme</span>({\n          base: <span class="hljs-string">"slate"</span>,\n          primary: <span class="hljs-string">"cyan"</span>,\n          secondary: <span class="hljs-string">"plum"</span>,\n          fontFamilies: {\n          heading: <span class="hljs-string">"Papyrus"</span>\n          }\n          })\n\n          <span class="hljs-comment">// set theme on the body of your document</span>\n          wt.setTheme(<span class="hljs-built_in">theme</span>);\n\n          <span class="hljs-comment">// grab theme CSS content and apply it to other elements (e.g. through a\n            class)</span>\n          wt.getCSSVariables(<span class="hljs-built_in">theme</span>);\n        </code></pre>\n      <h4 id="defining-custom-color-scales">Defining custom color scales</h4>\n      <p>You can also bypass our colors completely and pass in your custom color scale.</p>\n      <pre><code class="lang-js"><span class="hljs-keyword">import</span> wt <span class="hljs-keyword">from</span>\n          <span class="hljs-string">"w-theme"</span>\n\n          <span class="hljs-keyword">const</span> theme = wt.theme({\n          primary: {\n          bg: <span class="hljs-string">"<span class="hljs-subst">#fff</span>"</span>\n          <span class="hljs-string">"bg-subtle"</span>: <span class="hljs-string">"<span\n              class="hljs-subst">#fafafa</span>"</span>,\n          ...\n          },\n          })\n        </code></pre>\n      <h4 id="generating-color-scales">Generating color scales</h4>\n      <blockquote>\n        <p>[!WARNING]\n          Work in progress\u2026</p>\n      </blockquote>\n      <p>You can pass in custom values and new color scales will be generated from theme.\n        Any format recognizable by <a href="https://colorjs.io/">color.js</a> can be used.</p>\n      <pre><code class="lang-js"><span class="hljs-keyword">import</span> wt from <span\n            class="hljs-string">"w-theme"</span>\n\n          const <span class="hljs-built_in">theme</span> = wt.<span class="hljs-built_in">theme</span>({\n          primary: <span class="hljs-string">"#0A4"</span>,\n          secondary: <span class="hljs-string">"rgb(0, 200, 100)"</span>\n          })\n        </code></pre>\n      <h4 id="generating-spacing-and-border-radius-values">Generating spacing and border radius values</h4>\n      <p>Just as colors, you can pass in both a complete set of values to your spacings and rounded colors.\n        However, you can also pass in a scale value that will be used to auto-generate all other values.</p>\n      <pre><code class="lang-js">import wt from <span class="hljs-string">"w-theme"</span>\n\n          const theme = wt.theme({\n          <span class="hljs-symbol"> spacing:</span> {\n          <span class="hljs-symbol"> xs:</span> <span class="hljs-string">"0.1rem"</span>,\n          <span class="hljs-symbol"> sm:</span> <span class="hljs-string">"0.125rem"</span>,\n          ...\n          },\n          <span class="hljs-symbol"> borderRadius:</span> {\n          <span class="hljs-symbol"> xs:</span> <span class="hljs-string">"0.2rem"</span>,\n          <span class="hljs-symbol"> sm:</span> <span class="hljs-string">"0.3rem"</span>,\n          ...\n          }\n          })\n\n          const otherTheme = wt.theme({\n          <span class="hljs-symbol"> spacingScale:</span> <span class="hljs-number">1.2</span>,\n          <span class="hljs-symbol"> borderRadiusScale:</span> <span class="hljs-number">0.2</span>\n          })\n        </code></pre>\n      <h4 id="base-styles">Base styles</h4>\n      <p>The <code>setBaseStyles</code> function can be used for a few utilities like:</p>\n      <ul>\n        <li>Set most elements to use <code>font-text</code> as font family</li>\n        <li>Set <code>h1, h2, h3, h4, h5, h6</code> elements to use <code>font-heading</code></li>\n        <li>Set <code>code</code> element to use <code>font-code</code></li>\n        <li>Selectors <code>[data-w-palette=&quot;primary&quot;], .w-primary</code> to automatically apply a few palette\n          related styles to their children:<ul>\n            <li><code>background-color</code> will be set to the tinted color</li>\n            <li><code>border-color</code> will be set to the <code>accent</code> color</li>\n            <li><code>color</code> will be set to the related variant</li>\n            <li>if the class is added to an <code>a</code> or <code>button</code> tag, the <code>:hover, :active</code>\n              will change background to <code>tint-strong</code> and <code>tint-subtle</code></li>\n          </ul>\n        </li>\n        <li>Previous selectors plus <code>.w-solid</code> will automatically apply:<ul>\n            <li><code>background</code> will be set to <code>solid</code></li>\n            <li><code>color</code> will be set to <code>solid-text</code></li>\n            <li>when appropriate, the <code>:hover, :active</code> will change background to <code>solid-strong</code>\n              and <code>solid-subtle</code> colors</li>\n          </ul>\n        </li>\n      </ul>\n      <p>You can disable styles had base elements by passing in <code>base: false</code> in the options object.\n        You can also disable the class related styles by passing in <code>selectors: false</code> to the options object.\n      </p>\n      <pre><code class="lang-js"><span class="hljs-keyword">import</span> wt <span class="hljs-keyword">from</span>\n          <span class="hljs-string">"w-theme"</span>\n\n          wt.setBaseStyles({\n          base: <span class="hljs-literal">true</span>,\n          selectors: <span class="hljs-literal">false</span>\n          })\n        </code></pre>\n      <p>Also, you can get access to just these base styles through the <code>getCSSBaseStyles</code> function, the same\n        options apply.</p>\n      <h1 id="theme-sampler">Theme Sampler</h1>\n      <p>We provide a web-component that can be placed anywhere in your application and it will inherit the currently\n        available tokens.\n        This is a great way to test out different themes or debug design token inheritance in real applications.</p>\n      <pre><code class="lang-bash">&lt;script src=<span\n            class="hljs-string">"https://cdn.jsdelivr.net/gh/georgesboris/w-theme/w-theme-sampler.js"</span>&gt;<span\n            class="xml"><span class="hljs-tag">&lt;/<span class="hljs-name">script</span>&gt;</span></span>\n\n          &lt;div <span class="hljs-class"><span class="hljs-keyword">class</span></span>=<span\n            class="hljs-string">"blue-theme"</span>&gt;\n          <span class="xml"><span class="hljs-tag">&lt;<span class="hljs-name">w-theme-sampler</span>&gt;</span><span\n              class="hljs-tag">&lt;/<span class="hljs-name">w-theme-sampler</span>&gt;</span>\n            <span class="hljs-tag">&lt;/<span class="hljs-name">div</span>&gt;</span></span>\n\n          &lt;div <span class="hljs-class"><span class="hljs-keyword">class</span></span>=<span\n            class="hljs-string">"red-theme"</span>&gt;\n          <span class="xml"><span class="hljs-tag">&lt;<span class="hljs-name">w-theme-sampler</span>&gt;</span><span\n              class="hljs-tag">&lt;/<span class="hljs-name">w-theme-sampler</span>&gt;</span>\n            <span class="hljs-tag">&lt;/<span class="hljs-name">div</span>&gt;</span></span>\n        </code></pre>\n      <blockquote>\n        <p>[!WARNING]\n          Work in progress\u2026 you can see a standalone version of the theme sampler on our examples folder.</p>\n      </blockquote>\n      <h1 id="theme-debugger">Theme Debugger</h1>\n      <p>We provide a drop-in script that can be used to debug your design tokens on live applications.\n        This can be extremelly useful for debugging existing applications and visualizing design tokens live.</p>\n      <blockquote>\n        <p>[!WARNING]\n          Work in progress\u2026 the example page showcases the development version of our debugger.</p>\n      </blockquote>\n      <h1 id="tailwind-plugin">Tailwind Plugin</h1>\n      <pre><code class="lang-bash">npm <span class="hljs-selector-tag">i</span> -D w-theme\n        </code></pre>\n      <p>Then set it up as a <a href="https://tailwindcss.com/docs/plugins">tailwind plugin</a>.</p>\n      <pre><code class="lang-js"><span class="hljs-comment">// tailwind.config.js</span>\n\n          <span class="hljs-keyword">module</span>.<span class="hljs-keyword">exports</span> = {\n          plugins: [\n          require(<span class="hljs-string">"w-theme/tailwindcss"</span>)\n          ]\n          }\n        </code></pre>\n      <p>Our tailwind plugin accepts the following options:</p>\n      <pre><code class="lang-js"><span class="hljs-keyword">const</span> options = {\n          // disable tailwind\'s default colors, spacing <span class="hljs-keyword">and</span> border radius\n          strict: <span class="hljs-literal">false</span>,\n          // disable tailwind\'s default spacing variables\n          strictSpacing: <span class="hljs-literal">false</span>,\n          // disable the usage <span class="hljs-keyword">of</span> non-text colors <span class="hljs-keyword">as</span>\n          text colors\n          // (e.g. tint colors are <span class="hljs-keyword">not</span> valid text colors)\n          strictTextColors: <span class="hljs-literal">true</span>,\n          // add more color options to tailwind\'s color options\n          extraColors: <span class="hljs-meta">{...}</span>,\n          // add base styles (e.g. body background color, text color, heading font families, etc.)\n          baseStyles: <span class="hljs-literal">true</span>,\n          // add base class styles (e.g. .w-primary <span class="hljs-keyword">and</span> .w-primary-solid)\n          baseSelectors: <span class="hljs-literal">true</span>\n          }\n\n          module.exports = {\n          plugins: [\n          require(<span class="hljs-string">"w-theme/tailwindcss"</span>)(options)\n          ]\n          }\n        </code></pre>\n      <p>You can then use our variables as normal tailwind values like so:</p>\n      <pre><code class="lang-h"><span class="hljs-tag">&lt;<span class="hljs-name">button</span> <span\n              class="hljs-attr">class</span>=<span class="hljs-string">"px-md py-sm bg-solid bg-solid-text\n              hover:bg-solid-strong active:bg-solid-subtle"</span>&gt;</span>\n          ...\n          <span class="hljs-tag">&lt;/<span class="hljs-name">button</span>&gt;</span>\n        </code></pre>\n      <h2 id="related-libraries">Related Libraries</h2>\n      <h3 id="-elm-https-elm-lang-org-"><a href="https://elm-lang.org">Elm</a></h3>\n      <ul>\n        <li><a href="https://package.elm-lang.org/packages/georgesboris/elm-theme/latest/">elm-theme</a> \u2014 A fully\n          compliant w-theme library for Elm applications with support for automatically switching dark/light modes,\n          defining and extending themes with type-safety and more.</li>\n        <li><a href="https://package.elm-lang.org/packages/georgesboris/elm-widgets/latest/">elm-widgets</a> \u2014 A library\n          of UI elements themed through w-theme.</li>\n        <li><a href="https://package.elm-lang.org/packages/georgesboris/elm-book/latest/">elm-book</a> \u2014 A documentation\n          library themed through w-theme.</li>\n      </ul>\n      <h3 id="-gleam-https-gleam-run-"><a href="https://gleam.run">Gleam</a></h3>\n      <ul>\n        <li><strong>TBD</strong> :detective:</li>\n      </ul>\n    '
      )
    ])
  );
}
function main() {
  let app = application(
    (_) => {
      return [
        new Model2(palettes(), default_palette()),
        none()
      ];
    },
    (model, msg) => {
      {
        let palette = msg[0];
        return [
          model.withFields({
            font_palette: (() => {
              let _pipe = model.font_palettes;
              let _pipe$1 = find(
                _pipe,
                (x) => {
                  return x.name === palette;
                }
              );
              let _pipe$2 = unwrap(_pipe$1, model.font_palette);
              return debug(_pipe$2);
            })()
          }),
          none()
        ];
      }
    },
    (model) => {
      return fragment(
        toList([
          style2(toList([]), font_imports(model.font_palette)),
          div(
            toList([
              class$("grid grid-cols-12 p-xl gap-xl"),
              class$("font-text"),
              style(
                toList([
                  ["--w-font-heading", model.font_palette.heading.css],
                  ["--w-font-text", model.font_palette.text.css],
                  ["--w-font-code", model.font_palette.code.css]
                ])
              )
            ]),
            toList([
              div(toList([class$("col-span-2")]), toList([header()])),
              div(
                toList([class$("col-span-4")]),
                toList([main_content()])
              ),
              div(
                toList([class$("col-span-4")]),
                toList([theme_builder(model)])
              )
            ])
          )
        ])
      );
    }
  );
  let $ = start2(app, "#app", void 0);
  if (!$.isOk()) {
    throw makeError(
      "let_assert",
      "app",
      74,
      "main",
      "Pattern match failed, no pattern matched the value.",
      { value: $ }
    );
  }
  return void 0;
}

// build/.lustre/entry.mjs
main();
