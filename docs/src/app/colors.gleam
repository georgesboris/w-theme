import gleam/float
import gleam/int
import gleam/list
import gleam/result
import gleam/string
import gleam_community/colour.{type Color}
import gleam_community/colour/accessibility

pub type ColorScale {
  ColorScale(
    bg: Color,
    bg_subtle: Color,
    tint: Color,
    tint_subtle: Color,
    tint_strong: Color,
    accent: Color,
    accent_subtle: Color,
    accent_strong: Color,
    solid: Color,
    solid_subtle: Color,
    solid_strong: Color,
    solid_text: Color,
    text_subtle: Color,
    text: Color,
    shadow: Color,
  )
}

pub fn default_base() -> ColorScale {
  ColorScale(
    bg: from_rgb(252, 252, 253),
    bg_subtle: from_rgb(249, 249, 251),
    tint: from_rgb(232, 232, 236),
    tint_subtle: from_rgb(240, 240, 243),
    tint_strong: from_rgb(224, 225, 230),
    accent: from_rgb(205, 206, 214),
    accent_subtle: from_rgb(217, 217, 224),
    accent_strong: from_rgb(185, 187, 198),
    solid: from_rgb(139, 141, 152),
    solid_subtle: from_rgb(150, 152, 162),
    solid_strong: from_rgb(128, 131, 141),
    solid_text: from_rgb(255, 255, 255),
    text_subtle: from_rgb(96, 100, 108),
    text: from_rgb(28, 32, 36),
    shadow: from_rgb(28, 32, 36),
  )
}

pub fn color_scale_colors(color_scale: ColorScale) -> List(Color) {
  [
    color_scale.bg,
    color_scale.bg_subtle,
    color_scale.tint,
    color_scale.tint_subtle,
    color_scale.tint_strong,
    color_scale.accent,
    color_scale.accent_subtle,
    color_scale.accent_strong,
    color_scale.solid,
    color_scale.solid_subtle,
    color_scale.solid_strong,
    color_scale.solid_text,
    color_scale.text_subtle,
    color_scale.text,
    color_scale.shadow,
  ]
}

fn from_rgb(r: Int, g: Int, b: Int) -> Color {
  let assert Ok(colour) = colour.from_rgb255(r, g, b)

  colour
}

pub fn color_stats(
  color: Color,
  bg_color: Color,
  base_bg_color: Color,
) -> List(#(String, String)) {
  let #(h, s, l, _) = colour.to_hsla(color)
  [
    #("contrast", float_string(accessibility.contrast_ratio(bg_color, color))),
    #("luminance", float_string(accessibility.luminance(color))),
    #(
      "hsl",
      float_string(h) <> " " <> float_string(s) <> " " <> float_string(l) <> " ",
    ),
    // #("luminance", float_string(accessibility.luminance(color))),
  // #("#", colour.to_rgb_hex_string(color)),
  ]
}

fn float_string(value: Float) -> String {
  let precision = 2

  let base =
    value
    |> float.truncate()
    |> int.to_string()

  let decimals =
    value
    |> float.modulo(1.0)
    |> result.unwrap(0.0)
    |> float.to_string()
    |> string.slice(at_index: 2, length: precision)
    |> string.pad_left(precision, "0")

  base <> "." <> decimals
}
