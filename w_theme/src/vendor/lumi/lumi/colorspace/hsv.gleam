import gleam/float
import vendor/lumi/lumi
import vendor/lumi/util

pub fn to_rgb(hsv: lumi.Hsv) {
  let h = hsv.h /. 60.0
  let s = hsv.s /. 100.0
  let v = hsv.v /. 100.0

  let c = v *. s
  let x = c *. { 1.0 -. float.absolute_value(util.fmod(h, 2.0) -. 1.0) }
  let #(r, g, b) = case Nil {
    _ if h <=. 1.0 -> #(c, x, 0.0)
    _ if h <=. 2.0 -> #(x, c, 0.0)
    _ if h <=. 3.0 -> #(0.0, c, x)
    _ if h <=. 4.0 -> #(0.0, x, c)
    _ if h <=. 5.0 -> #(x, 0.0, c)
    _ -> #(c, 0.0, x)
  }

  let m = v -. c

  lumi.Rgb({ r +. m } *. 255.0, { g +. m } *. 255.0, { b +. m } *. 255.0)
}
