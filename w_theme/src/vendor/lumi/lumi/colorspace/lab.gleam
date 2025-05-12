import gleam/float
import gleam/result
import vendor/lumi/lumi
import vendor/lumi/util

pub fn to_xyz(lab: lumi.Lab) {
  let lumi.Lab(l: l, a: a, b: b) = lab
  let delta = 6.0 /. 29.0
  let f = fn(t) {
    case t >. delta {
      True ->
        float.power(t, 3.0)
        |> result.unwrap(0.0)
      False ->
        3.0
        *. {
          float.power(delta, 2.0)
          |> result.unwrap(0.0)
        }
        *. { t -. 4.0 /. 29.0 }
    }
  }
  let c = { l +. 16.0 } /. 116.0
  lumi.Xyz(
    x: 95.0489 *. f(c +. a /. 500.0),
    y: 100.0 *. f(c),
    z: 108.884 *. f(c -. b /. 200.0),
  )
}

pub fn to_lchab(lab: lumi.Lab) {
  let lumi.Lab(l: l, a: a, b: b) = lab
  let c =
    float.power(
      {
        {
          float.power(a, 2.0)
          |> result.unwrap(0.0)
        }
        +. {
          float.power(b, 2.0)
          |> result.unwrap(0.0)
        }
      },
      0.5,
    )
    |> result.unwrap(0.0)
  let h =
    util.atan(b /. a)
    |> util.radians_to_degrees()
    |> util.wrap_to_range(0.0, 360.0)
  lumi.Lchab(l: l, c: c, h: h)
}
