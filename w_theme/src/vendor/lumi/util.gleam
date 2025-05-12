pub fn degrees_to_radians(degrees) {
  degrees /. 180.0 *. pi()
}

pub fn radians_to_degrees(radians) {
  radians *. 180.0 /. pi()
}

pub fn wrap_to_range(x, min, max) {
  let v = fmod(x -. min, max -. min) +. min
  case v <=. 0.0 {
    True -> v +. max
    False -> v
  }
}

@external(erlang, "math", "fmod")
@external(javascript, "./extern.mjs", "fmod")
pub fn fmod(x: Float, y: Float) -> Float

@external(erlang, "math", "pi")
@external(javascript, "./extern.mjs", "pi")
pub fn pi() -> Float

@external(erlang, "math", "sin")
@external(javascript, "./extern.mjs", "sin")
pub fn sin(x: Float) -> Float

@external(erlang, "math", "cos")
@external(javascript, "./extern.mjs", "cos")
pub fn cos(x: Float) -> Float

@external(erlang, "math", "atan")
@external(javascript, "./extern.mjs", "atan")
pub fn atan(x: Float) -> Float

@external(erlang, "math", "atan2")
@external(javascript, "./extern.mjs", "atan2")
pub fn atan2(y: Float, x: Float) -> Float
