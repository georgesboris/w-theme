import gleam/float
import gleam/result
import vendor/lumi/lumi
import vendor/lumi/util

pub fn to_xyz(luv: lumi.Luv) {
  let lumi.Luv(l: l, u: u, v: v) = luv

  let luminance = 100.0
  let ref_u = 0.2009
  let ref_v = 0.461
  let var_u = u /. { 13.0 *. l } +. ref_u
  let var_v = v /. { 13.0 *. l } +. ref_v

  let y = case l <=. 8.0 {
    True ->
      luminance
      *. l
      *. {
        float.power(3.0 /. 29.0, 3.0)
        |> result.unwrap(0.0)
      }
    False ->
      luminance
      *. {
        float.power({ l +. 16.0 } /. 116.0, 3.0)
        |> result.unwrap(0.0)
      }
  }
  let x = y *. { 9.0 *. var_u } /. { 4.0 *. var_v }
  let z = y *. { 12.0 -. 3.0 *. var_u -. 20.0 *. var_v } /. { 4.0 *. var_v }

  lumi.Xyz(x: x, y: y, z: z)
}

pub fn to_lchuv(luv: lumi.Luv) {
  let lumi.Luv(l: l, u: u, v: v) = luv
  lumi.Lchuv(
    l: l,
    c: float.power(
      {
        {
          float.power(u, 2.0)
          |> result.unwrap(0.0)
        }
        +. {
          float.power(v, 2.0)
          |> result.unwrap(0.0)
        }
      },
      0.5,
    )
      |> result.unwrap(0.0),
    h: util.atan2(v, u)
      |> util.radians_to_degrees()
      |> util.wrap_to_range(0.0, 360.0),
  )
}
