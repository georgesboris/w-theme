import vendor/lumi/lumi
import vendor/lumi/util

pub fn to_lab(lchab: lumi.Lchab) {
  let lumi.Lchab(l: l, c: c, h: h) = lchab
  let a = c *. util.cos(util.degrees_to_radians(h))
  let b = c *. util.sin(util.degrees_to_radians(h))
  lumi.Lab(l: l, a: a, b: b)
}
