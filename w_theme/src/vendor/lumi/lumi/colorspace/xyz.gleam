import gleam/float
import gleam/result
import vendor/lumi/lumi

pub fn to_rgb(xyz: lumi.Xyz) {
  let lumi.Xyz(x: x, y: y, z: z) = xyz
  let x = x /. 100.0
  let y = y /. 100.0
  let z = z /. 100.0

  let r = x *. 3.2406 +. y *. -1.5372 +. z *. -0.4986
  let g = x *. -0.9689 +. y *. 1.8758 +. z *. 0.0415
  let b = x *. 0.0557 +. y *. -0.204 +. z *. 1.057

  let gamma_correct = fn(x) {
    case x <=. 0.0031308 {
      True -> 12.92 *. x
      False ->
        1.055
        *. {
          float.power(x, 1.0 /. 2.4)
          |> result.unwrap(0.0)
        }
        -. 0.0557
    }
    |> float.multiply(255.0)
    |> float.clamp(min: 0.0, max: 255.0)
  }

  lumi.Rgb(r: gamma_correct(r), g: gamma_correct(g), b: gamma_correct(b))
}

pub fn to_lab(xyz: lumi.Xyz) {
  let delta = 6.0 /. 29.0
  let f = fn(t) {
    case
      t
      >. float.power(delta, 3.0)
      |> result.unwrap(0.0)
    {
      True ->
        float.power(t, 1.0 /. 3.0)
        |> result.unwrap(0.0)
      False ->
        { 1.0 /. 3.0 }
        *. t
        *. {
          float.power(delta, -2.0)
          |> result.unwrap(0.0)
        }
    }
  }
  let x = xyz.x /. 95.0489
  let y = xyz.y /. 100.0
  let z = xyz.z /. 108.884
  lumi.Lab(
    l: 116.0 *. f(y) -. 16.0,
    a: 500.0 *. { f(x) -. f(y) },
    b: 200.0 *. { f(y) -. f(z) },
  )
}

pub fn to_luv(xyz: lumi.Xyz) {
  let lumi.Xyz(x: x, y: y, z: z) = xyz

  let luminance = 100.0
  let ref_u = 0.2009
  let ref_v = 0.461
  let divisor = x +. 15.0 *. y +. 3.0 *. z
  let var_u = 4.0 *. x /. divisor
  let var_v = 9.0 *. y /. divisor

  let l = case
    y /. luminance
    <=. float.power(6.0 /. 29.0, 3.0)
    |> result.unwrap(0.0)
  {
    True ->
      {
        float.power(29.0 /. 3.0, 3.0)
        |> result.unwrap(0.0)
      }
      *. y
      /. luminance
    False ->
      116.0
      *. {
        float.power(y /. luminance, 1.0 /. 3.0)
        |> result.unwrap(0.0)
      }
      -. 16.0
  }
  let u = 13.0 *. l *. { var_u -. ref_u }
  let v = 13.0 *. l *. { var_v -. ref_v }

  lumi.Luv(l: l, u: u, v: v)
}
