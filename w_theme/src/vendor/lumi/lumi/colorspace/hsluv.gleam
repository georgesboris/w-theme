import gleam/float
import gleam/list
import gleam/result
import vendor/lumi/lumi
import vendor/lumi/util

pub fn to_lchuv(hsluv: lumi.Hsluv) {
  let lumi.Hsluv(h: h, s: s, luv: luv) = hsluv

  let calculate_bounding_lines_and_max_chroma = fn() {
    let distance_from_origin_angle = fn(slope, intercept, angle) {
      let d = intercept /. { util.sin(angle) -. slope *. util.cos(angle) }
      case d <. 0.0 {
        True -> 999_999_999_999_999_999.0
        False -> d
      }
    }

    let epsilon = 0.0088564516
    let kappa = 903.2962962

    let m_r0 = 3.240969941904521
    let m_r1 = -1.537383177570093
    let m_r2 = -0.498610760293

    let m_g0 = -0.96924363628087
    let m_g1 = 1.87596750150772
    let m_g2 = 0.041555057407175

    let m_b0 = 0.055630079696993
    let m_b1 = -0.20397695888897
    let m_b2 = 1.056971514242878

    let sub1 =
      {
        float.power(luv +. 16.0, 3.0)
        |> result.unwrap(0.0)
      }
      /. 1_560_896.0
    let sub2 = case sub1 >. epsilon {
      True -> sub1
      False -> 1.0 /. kappa
    }

    let s1r = sub2 *. { 284_517.0 *. m_r0 -. 94_839.0 *. m_r2 }
    let s2r =
      sub2 *. { 838_422.0 *. m_r2 +. 769_860.0 *. m_r1 +. 731_718.0 *. m_r0 }
    let s3r = sub2 *. { 632_260.0 *. m_r2 -. 126_452.0 *. m_r1 }

    let s1g = sub2 *. { 284_517.0 *. m_g0 -. 94_839.0 *. m_g2 }
    let s2g =
      sub2 *. { 838_422.0 *. m_g2 +. 769_860.0 *. m_g1 +. 731_718.0 *. m_g0 }
    let s3g = sub2 *. { 632_260.0 *. m_g2 -. 126_452.0 *. m_g1 }

    let s1b = sub2 *. { 284_517.0 *. m_b0 -. 94_839.0 *. m_b2 }
    let s2b =
      sub2 *. { 838_422.0 *. m_b2 +. 769_860.0 *. m_b1 +. 731_718.0 *. m_b0 }
    let s3b = sub2 *. { 632_260.0 *. m_b2 -. 126_452.0 *. m_b1 }

    let r0s = s1r /. s3r
    let r0i = s2r *. luv /. s3r
    let r1s = s1r /. { s3r +. 126_452.0 }
    let r1i = { s2r -. 769_860.0 } *. luv /. { s3r +. 126_452.0 }

    let g0s = s1g /. s3g
    let g0i = s2g *. luv /. s3g
    let g1s = s1g /. { s3g +. 126_452.0 }
    let g1i = { s2g -. 769_860.0 } *. luv /. { s3g +. 126_452.0 }

    let b0s = s1b /. s3b
    let b0i = s2b *. luv /. s3b
    let b1s = s1b /. { s3b +. 126_452.0 }
    let b1i = { s2b -. 769_860.0 } *. luv /. { s3b +. 126_452.0 }

    let hue_rad = h /. 360.0 *. util.pi() *. 2.0
    let r0 = distance_from_origin_angle(r0s, r0i, hue_rad)
    let r1 = distance_from_origin_angle(r1s, r1i, hue_rad)
    let g0 = distance_from_origin_angle(g0s, g0i, hue_rad)
    let g1 = distance_from_origin_angle(g1s, g1i, hue_rad)
    let b0 = distance_from_origin_angle(b0s, b0i, hue_rad)
    let b1 = distance_from_origin_angle(b1s, b1i, hue_rad)

    [r1, g0, g1, b0, b1]
    |> list.fold(r0, float.min)
  }

  let #(l, c) = case Nil {
    _ if luv >. 99.9999999 -> #(100.0, 0.0)
    _ if luv <. 0.00000001 -> #(0.0, 0.0)
    _ -> {
      #(luv, calculate_bounding_lines_and_max_chroma() /. 100.0 *. s)
    }
  }
  lumi.Lchuv(l, c, h)
}
