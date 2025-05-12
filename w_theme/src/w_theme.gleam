import gleam/dict
import gleam/float
import gleam/int
import gleam/list
import gleam/option
import gleam/result
import gleam/string
import gleam_community/colour.{type Color}
import gleam_community/colour/accessibility
import lustre
import lustre/attribute.{type Attribute} as attr
import lustre/effect.{type Effect}
import lustre/element.{type Element}
import lustre/element/html
import lustre/event
import plinth/javascript/console
import vendor/lumi/lumi
import vendor/lumi/lumi/colorspace/hsluv
import vendor/lumi/lumi/colorspace/lchuv
import vendor/lumi/lumi/colorspace/luv
import vendor/lumi/lumi/colorspace/rgb
import vendor/lumi/lumi/colorspace/xyz
import vendor/lumi/util

type Variant {
  Variant(key: VariantKey, name: String, color_scale: ColorScale)
}

type VariantKey {
  VariantKey(name: String, order: Int)
}

type Model {
  Model(
    active: VariantKey,
    variant_input: String,
    variants: dict.Dict(VariantKey, ColorScale),
    show_contrast: Bool,
  )
}

type Msg {
  OnSelectVariant(VariantKey)
  InputVariant(String)
  CreateVariant
  OnColorInput(String, ColorKey, String)
  OnShowContrastInput(Bool)
}

fn init(_) -> #(Model, Effect(Msg)) {
  let benchmark_base = #(
    VariantKey(name: "Benchmark", order: 0),
    to_variant(
      bg: "#2A2F36",
      bg_subtle: "#1E2328",
      tint: "#393F47",
      tint_subtle: "#393F47",
      tint_strong: "#404650",
      accent: "#505866",
      accent_subtle: "#404650",
      accent_strong: "#404650",
      solid: "#505866",
      solid_subtle: "#454C57",
      solid_strong: "#5F6773",
      solid_text: "#FFFFFF",
      text: "#F3F4F6",
      text_subtle: "#9DA3AE",
      shadow: "#000000",
    ),
  )

  let default_base = #(
    VariantKey(name: "Base", order: 1),
    color_scale_from_key_colors(
      bg: { benchmark_base.1 }.bg,
      tint: from_hsl(214.0, 0.13, 0.225),
      accent: from_hsl(214.0, 0.13, 0.4),
      solid: { benchmark_base.1 }.solid,
      text: { benchmark_base.1 }.text,
    ),
  )
  let default_success = #(
    VariantKey(name: "Success", order: 2),
    color_scale_merged_with_key_colors(
      default_base.1,
      // from_hsl(98.0, 0.99, 0.36),
      from_hsl(131.0, 0.41, 0.46),
    ),
  )

  // let default_success = #(
  //   VariantKey(name: "Success", order: 2),
  //   color_scale_from_key_colors(
  //     bg: { default_base.1 }.bg,
  //     tint: from_hsl(127.0, 0.2, 0.26),
  //     accent: from_hsl(128.0, 0.24, 0.33),
  //     solid: from_hsl(131.0, 0.41, 0.46),
  //     text: { benchmark_base.1 }.text,
  //   ),
  // )

  #(
    Model(
      active: default_success.0,
      variant_input: "",
      variants: dict.from_list([benchmark_base, default_base, default_success]),
      show_contrast: False,
    ),
    effect.none(),
  )
}

fn variants_list(model: Model) -> List(Variant) {
  model.variants
  |> dict.to_list
  |> list.map(fn(x) { Variant(key: x.0, name: { x.0 }.name, color_scale: x.1) })
  |> list.sort(fn(a, b) { int.compare(a.key.order, b.key.order) })
}

fn variant_by_name(
  model: Model,
  name: String,
) -> Result(#(VariantKey, ColorScale), Nil) {
  model.variants
  |> dict.to_list
  |> list.find(fn(x) {
    let #(variant_description, _) = x

    variant_description.name == name
  })
}

fn variant_by_key(
  model: Model,
  key: VariantKey,
) -> Result(#(VariantKey, ColorScale), Nil) {
  dict.get(model.variants, key)
  |> result.map(fn(x) { #(key, x) })
}

fn update(model: Model, msg: Msg) -> #(Model, Effect(Msg)) {
  case msg {
    InputVariant(value) -> {
      #(Model(..model, variant_input: value), effect.none())
    }
    CreateVariant -> {
      case
        model.variant_input,
        variant_by_name(model, model.variant_input),
        variant_by_key(model, model.active)
      {
        "", _, _ -> #(model, effect.none())
        _, _, Error(_) -> #(model, effect.none())
        _, Ok(matching_variant), _ -> #(
          Model(..model, variant_input: "", active: matching_variant.0),
          effect.none(),
        )
        _, Error(_), Ok(active) -> {
          let key =
            VariantKey(
              name: model.variant_input,
              order: dict.size(model.variants),
            )

          #(
            Model(
              ..model,
              variant_input: "",
              active: key,
              variants: dict.insert(model.variants, key, active.1),
            ),
            effect.none(),
          )
        }
      }
    }
    OnSelectVariant(variant) -> {
      #(Model(..model, active: variant), effect.none())
    }
    OnColorInput(label, key, value) -> {
      case variant_by_name(model, label), colour.from_rgb_hex_string(value) {
        Ok(variant), Ok(color) -> {
          let #(variant_key, color_scale) = variant

          #(
            Model(
              ..model,
              variants: model.variants
                |> dict.insert(
                  variant_key,
                  set_color_scale_color(color_scale, key, color),
                ),
            ),
            effect.none(),
          )
        }

        _, _ -> #(model, effect.none())
      }
    }
    OnShowContrastInput(value) -> {
      #(Model(..model, show_contrast: value), effect.none())
    }
  }
}

type ColorKey {
  Bg
  BgSubtle
  Tint
  TintSubtle
  TintStrong
  Accent
  AccentSubtle
  AccentStrong
  Solid
  SolidSubtle
  SolidStrong
  SolidText
  Text
  TextSubtle
  Shadow
}

type ColorScale {
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
    text: Color,
    text_subtle: Color,
    shadow: Color,
  )
}

fn to_color_scale_colors(color_scale: ColorScale) -> List(#(ColorKey, Color)) {
  [
    #(BgSubtle, color_scale.bg_subtle),
    #(Bg, color_scale.bg),
    #(TintSubtle, color_scale.tint_subtle),
    #(Tint, color_scale.tint),
    #(TintStrong, color_scale.tint_strong),
    #(AccentSubtle, color_scale.accent_subtle),
    #(Accent, color_scale.accent),
    #(AccentStrong, color_scale.accent_strong),
    #(SolidSubtle, color_scale.solid_subtle),
    #(Solid, color_scale.solid),
    #(SolidStrong, color_scale.solid_strong),
    #(SolidText, color_scale.solid_text),
    #(Text, color_scale.text),
    #(TextSubtle, color_scale.text_subtle),
    #(Shadow, color_scale.shadow),
  ]
}

fn to_color_scale_grouped_colors(
  color_scale: ColorScale,
) -> List(#(#(ColorKey, Color), List(#(ColorKey, Color)))) {
  [
    #(#(Bg, color_scale.bg), [
      #(BgSubtle, color_scale.bg_subtle),
      #(Bg, color_scale.bg),
    ]),
    #(#(Tint, color_scale.tint), [
      #(TintSubtle, color_scale.tint_subtle),
      #(Tint, color_scale.tint),
      #(TintStrong, color_scale.tint_strong),
    ]),
    #(#(Accent, color_scale.accent), [
      #(AccentSubtle, color_scale.accent_subtle),
      #(Accent, color_scale.accent),
      #(AccentStrong, color_scale.accent_strong),
    ]),
    #(#(Solid, color_scale.solid), [
      #(SolidSubtle, color_scale.solid_subtle),
      #(Solid, color_scale.solid),
      #(SolidStrong, color_scale.solid_strong),
      #(SolidText, color_scale.solid_text),
    ]),
    #(#(Text, color_scale.text), [
      #(Text, color_scale.text),
      #(TextSubtle, color_scale.text_subtle),
    ]),
    #(#(Shadow, color_scale.shadow), []),
  ]
}

fn get_color_scale_color(color_scale: ColorScale, key: ColorKey) -> Color {
  case key {
    Bg -> color_scale.bg
    BgSubtle -> color_scale.bg_subtle
    Tint -> color_scale.tint
    TintSubtle -> color_scale.tint_subtle
    TintStrong -> color_scale.tint_strong
    Accent -> color_scale.accent
    AccentSubtle -> color_scale.accent_subtle
    AccentStrong -> color_scale.accent_strong
    Solid -> color_scale.solid
    SolidSubtle -> color_scale.solid_subtle
    SolidStrong -> color_scale.solid_strong
    SolidText -> color_scale.solid_text
    Text -> color_scale.text
    TextSubtle -> color_scale.text_subtle
    Shadow -> color_scale.shadow
  }
}

fn set_color_scale_color(
  color_scale: ColorScale,
  key: ColorKey,
  value: Color,
) -> ColorScale {
  case key {
    Bg -> ColorScale(..color_scale, bg: value)
    BgSubtle -> ColorScale(..color_scale, bg_subtle: value)
    Tint -> ColorScale(..color_scale, tint: value)
    TintSubtle -> ColorScale(..color_scale, tint_subtle: value)
    TintStrong -> ColorScale(..color_scale, tint_strong: value)
    Accent -> ColorScale(..color_scale, accent: value)
    AccentSubtle -> ColorScale(..color_scale, accent_subtle: value)
    AccentStrong -> ColorScale(..color_scale, accent_strong: value)
    Solid -> ColorScale(..color_scale, solid: value)
    SolidSubtle -> ColorScale(..color_scale, solid_subtle: value)
    SolidStrong -> ColorScale(..color_scale, solid_strong: value)
    SolidText -> ColorScale(..color_scale, solid_text: value)
    Text -> ColorScale(..color_scale, text: value)
    TextSubtle -> ColorScale(..color_scale, text_subtle: value)
    Shadow -> ColorScale(..color_scale, shadow: value)
  }
}

fn color_scale_css_vars_attr(color_scale: ColorScale) -> Attribute(msg) {
  attr.styles([
    #("--w-bg", to_hex_string(color_scale.bg)),
    #("--w-bg-subtle", to_hex_string(color_scale.bg_subtle)),
    #("--w-tint", to_hex_string(color_scale.tint)),
    #("--w-tint-subtle", to_hex_string(color_scale.tint_subtle)),
    #("--w-tint-strong", to_hex_string(color_scale.tint_strong)),
    #("--w-accent", to_hex_string(color_scale.accent)),
    #("--w-accent-subtle", to_hex_string(color_scale.accent_subtle)),
    #("--w-accent-strong", to_hex_string(color_scale.accent_strong)),
    #("--w-solid", to_hex_string(color_scale.solid)),
    #("--w-solid-subtle", to_hex_string(color_scale.solid_subtle)),
    #("--w-solid-strong", to_hex_string(color_scale.solid_strong)),
    #("--w-solid-text", to_hex_string(color_scale.solid_text)),
    #("--w-text", to_hex_string(color_scale.text)),
    #("--w-text-subtle", to_hex_string(color_scale.text_subtle)),
    #("--w-shadow", to_hex_string(color_scale.shadow)),
  ])
}

fn to_variant(
  bg bg_str: String,
  bg_subtle bg_subtle_str: String,
  tint tint_str: String,
  tint_subtle tint_subtle_str: String,
  tint_strong tint_strong_str: String,
  accent accent_str: String,
  accent_subtle accent_subtle_str: String,
  accent_strong accent_strong_str: String,
  solid solid_str: String,
  solid_subtle solid_subtle_str: String,
  solid_strong solid_strong_str: String,
  solid_text solid_text_str: String,
  text text_str: String,
  text_subtle text_subtle_str: String,
  shadow shadow_str: String,
) -> ColorScale {
  let assert Ok(bg) = colour.from_rgb_hex_string(bg_str)
  let assert Ok(bg_subtle) = colour.from_rgb_hex_string(bg_subtle_str)
  let assert Ok(tint) = colour.from_rgb_hex_string(tint_str)
  let assert Ok(tint_subtle) = colour.from_rgb_hex_string(tint_subtle_str)
  let assert Ok(tint_strong) = colour.from_rgb_hex_string(tint_strong_str)
  let assert Ok(accent) = colour.from_rgb_hex_string(accent_str)
  let assert Ok(accent_subtle) = colour.from_rgb_hex_string(accent_subtle_str)
  let assert Ok(accent_strong) = colour.from_rgb_hex_string(accent_strong_str)
  let assert Ok(solid) = colour.from_rgb_hex_string(solid_str)
  let assert Ok(solid_subtle) = colour.from_rgb_hex_string(solid_subtle_str)
  let assert Ok(solid_strong) = colour.from_rgb_hex_string(solid_strong_str)
  let assert Ok(solid_text) = colour.from_rgb_hex_string(solid_text_str)
  let assert Ok(text) = colour.from_rgb_hex_string(text_str)
  let assert Ok(text_subtle) = colour.from_rgb_hex_string(text_subtle_str)
  let assert Ok(shadow) = colour.from_rgb_hex_string(shadow_str)

  ColorScale(
    bg:,
    bg_subtle:,
    tint:,
    tint_subtle:,
    tint_strong:,
    accent:,
    accent_subtle:,
    accent_strong:,
    solid:,
    solid_subtle:,
    solid_strong:,
    solid_text:,
    text:,
    text_subtle:,
    shadow:,
  )
}

fn color_scale_from_color(color: Color) -> ColorScale {
  let hsla = colour.to_hsla(color)
  let hue = hsla.0

  let c = fn(s, luv) {
    let assert Ok(color_result) = colour.from_hsl(hue, s, luv)

    color_result
  }
  case accessibility.luminance(color) <. 0.5 {
    True ->
      ColorScale(
        // bg
        bg_subtle: c(0.24, 0.08),
        bg: c(0.48, 0.1),
        // tint
        tint_subtle: c(0.64, 0.115),
        tint: c(0.64, 0.13),
        tint_strong: c(0.64, 0.15),
        // accent
        accent_subtle: c(0.75, 0.26),
        accent: c(0.75, 0.3),
        accent_strong: c(0.9, 0.34),
        // solid
        solid_subtle: c(0.75, 0.55),
        solid: c(0.75, 0.75),
        solid_strong: c(0.75, 0.9),
        solid_text: c(0.75, 0.0),
        // text
        text: c(1.0, 1.0),
        text_subtle: c(1.0, 0.6),
        // shadow
        shadow: c(1.0, 0.05),
      )

    False ->
      ColorScale(
        // bg
        bg_subtle: c(0.24, 0.08),
        bg: c(0.48, 0.1),
        // tint
        tint_subtle: c(0.64, 0.115),
        tint: c(0.64, 0.13),
        tint_strong: c(0.64, 0.15),
        // accent
        accent_subtle: c(0.75, 0.26),
        accent: c(0.75, 0.3),
        accent_strong: c(0.9, 0.34),
        // solid
        solid_subtle: c(0.75, 0.55),
        solid: c(0.75, 0.75),
        solid_strong: c(0.75, 0.9),
        solid_text: c(0.75, 0.0),
        // text
        text: c(1.0, 1.0),
        text_subtle: c(1.0, 0.6),
        // shadow
        shadow: c(1.0, 0.05),
      )
  }
}

fn color_scale_merged_with_key_colors(
  base_scale: ColorScale,
  color: Color,
) -> ColorScale {
  let #(h, _, _, _) = colour.to_hsla(color)
  let color_accent = from_hsl(h *. 360.0, 0.8, 0.6)
  let color_solid = from_hsl(h *. 360.0, 0.7, 0.55)

  let tint = lerp_color(base_scale.bg, color_accent, 0.075)
  let accent = lerp_color(base_scale.bg, color_accent, 0.5)
  let solid = color_solid
  let text = lerp_color(base_scale.text, color_solid, 0.8)

  color_scale_from_key_colors(bg: base_scale.bg, text:, tint:, accent:, solid:)
}

type Vec3 =
  #(Float, Float, Float)

fn to_rgb(color: Color) -> Vec3 {
  let #(r, g, b, _) = colour.to_rgba(color)

  #(r, g, b)
}

fn set_saturation(color: Color, saturation: Float) -> Color {
  let color_hsl = colour.to_hsla(color)
  let assert Ok(c) = colour.from_hsl(color_hsl.0, saturation, color_hsl.1)

  c
}

fn lerp_color(current: Color, target: Color, value: Float) -> Color {
  let current_rgb = to_rgb(current)
  let target_rgb = to_rgb(target)
  let #(r, g, b) = lerp3(current_rgb, target_rgb, value)
  let assert Ok(color) = colour.from_rgb(r, g, b)

  color
}

fn lerp3(current: Vec3, target: Vec3, value: Float) -> Vec3 {
  #(
    lerp(current.0, target.0, value),
    lerp(current.1, target.1, value),
    lerp(current.2, target.2, value),
  )
}

fn lerp(current: Float, target: Float, value: Float) -> Float {
  current +. { { target -. current } *. float.clamp(value, 0.0, 1.0) }
}

fn color_scale_from_key_colors(
  bg bg: Color,
  text text: Color,
  tint tint: Color,
  accent accent: Color,
  solid solid: Color,
) -> ColorScale {
  let mul = case accessibility.luminance(bg) <. 0.5 {
    True -> fn(x, m) { float.clamp(x *. { 1.0 +. m }, 0.0, 1.0) }
    False -> fn(x, m) { float.clamp(x *. { 1.0 -. m }, 0.0, 1.0) }
  }

  let solid_text = case accessibility.luminance(solid) <. 0.6 {
    True -> colour.black
    False -> colour.white
  }

  let c = fn(color, s, l) {
    let hsla = colour.to_hsla(color)
    let assert Ok(color_result) =
      colour.from_hsl(hsla.0, mul(hsla.1, s), mul(hsla.2, l))

    color_result
  }

  ColorScale(
    // bg
    bg_subtle: c(bg, 0.0, -0.1),
    bg: bg,
    // tint
    tint_subtle: c(tint, 0.0, -0.075),
    tint: tint,
    tint_strong: c(tint, 0.0, 0.075),
    // accent
    accent_subtle: c(accent, 0.0, -0.15),
    accent: accent,
    accent_strong: c(accent, 0.0, 0.15),
    // solid
    solid_subtle: c(solid, 0.0, -0.15),
    solid: solid,
    solid_strong: c(solid, 0.0, 0.15),
    solid_text: solid_text,
    // text
    text: text,
    text_subtle: c(text, -0.5, -0.3),
    // shadow
    shadow: c(solid, 0.5, -0.8),
  )
}

type ContrastRatioStatus {
  Great
  Good
  GoodForUI
  Bad
}

fn constrast_ratio_icon(status: ContrastRatioStatus) -> Element(msg) {
  case status {
    Great -> html.span([attr.style("color", "lime")], [html.text("S")])
    Good -> html.span([attr.style("color", "green")], [html.text("A")])
    GoodForUI -> html.span([attr.style("color", "orange")], [html.text("A")])
    Bad -> html.span([attr.style("color", "red")], [html.text("X")])
  }
}

fn base_variant() {
  to_variant(
    bg: "#2A2F36",
    bg_subtle: "#1E2328",
    tint: "#393F47",
    tint_subtle: "#393F47",
    tint_strong: "#404650",
    accent: "#505866",
    accent_subtle: "#404650",
    accent_strong: "#404650",
    solid: "#505866",
    solid_subtle: "#454C57",
    solid_strong: "#5F6773",
    solid_text: "#FFFFFF",
    text: "#F3F4F6",
    text_subtle: "#9DA3AE",
    shadow: "#000000",
  )
}

fn view(model: Model) -> Element(Msg) {
  html.div(
    [
      attr.class("w--sample"),
      attr.class("container mx-auto p-8"),
      attr.class("flex items-start"),
      attr.classes([#("m--contrast", model.show_contrast)]),
    ],
    [
      html.div([attr.class("py-4")], [
        html.ul(
          [attr.class("pb-2")],
          variants_list(model)
            |> list.map(fn(variant) {
              html.li([], [
                html.button(
                  [
                    attr.class("py-2 px-4 w-full text-left"),
                    attr.class("cursor-pointer hover:bg-tint-subtle"),
                    attr.classes([#("bg-tint", variant.key == model.active)]),
                    event.on_click(OnSelectVariant(variant.key)),
                  ],
                  [html.text(variant.name)],
                ),
              ])
            }),
        ),
        html.form(
          [attr.class("pr-4"), event.on_submit(fn(_) { CreateVariant })],
          [
            html.input([
              attr.placeholder("new variant…"),
              attr.class("border border-tint rounded"),
              attr.class("px-4 py-2"),
              attr.value(model.variant_input),
              event.on_input(InputVariant),
            ]),
          ],
        ),
      ]),
      case dict.get(model.variants, model.active) {
        Ok(variant) ->
          view_sample_table(model.active.name, variant, model.show_contrast)
        Error(_) -> html.div([], [])
      },
    ],
  )
}

type ColorScaleMatrix {
  ColorScaleMatrix(
    color_scale: ColorScale,
    bg: ColorScaleMatrixRow,
    bg_subtle: ColorScaleMatrixRow,
    tint: ColorScaleMatrixRow,
    tint_subtle: ColorScaleMatrixRow,
    tint_strong: ColorScaleMatrixRow,
    solid_contrast: ContrastRatioStatus,
    solid_subtle_contrast: ContrastRatioStatus,
    solid_strong_contrast: ContrastRatioStatus,
  )
}

type ColorScaleMatrixRow {
  ColorScaleMatrixRow(
    color: Color,
    color_key: ColorKey,
    text_contrast: ContrastRatioStatus,
    text_subtle_contrast: ContrastRatioStatus,
    accent_contrast: ContrastRatioStatus,
    accent_subtle_contrast: ContrastRatioStatus,
    accent_strong_contrast: ContrastRatioStatus,
    solid_contrast: ContrastRatioStatus,
    solid_subtle_contrast: ContrastRatioStatus,
    solid_strong_contrast: ContrastRatioStatus,
  )
}

fn to_color_scale_matrix_row(
  color_scale: ColorScale,
  bg: ColorKey,
) -> ColorScaleMatrixRow {
  let color = get_color_scale_color(color_scale, bg)

  ColorScaleMatrixRow(
    color:,
    color_key: bg,
    text_contrast: to_contrast_ratio(color_scale.text, color),
    text_subtle_contrast: to_contrast_ratio(color_scale.text_subtle, color),
    accent_contrast: to_contrast_ratio(color_scale.accent, color),
    accent_subtle_contrast: to_contrast_ratio(color_scale.accent_subtle, color),
    accent_strong_contrast: to_contrast_ratio(color_scale.accent_strong, color),
    solid_contrast: to_contrast_ratio(color_scale.solid, color),
    solid_subtle_contrast: to_contrast_ratio(color_scale.solid_subtle, color),
    solid_strong_contrast: to_contrast_ratio(color_scale.solid_strong, color),
  )
}

fn to_color_scale_matrix(color_scale: ColorScale) -> ColorScaleMatrix {
  ColorScaleMatrix(
    color_scale:,
    bg: to_color_scale_matrix_row(color_scale, Bg),
    bg_subtle: to_color_scale_matrix_row(color_scale, BgSubtle),
    tint: to_color_scale_matrix_row(color_scale, Tint),
    tint_subtle: to_color_scale_matrix_row(color_scale, TintSubtle),
    tint_strong: to_color_scale_matrix_row(color_scale, TintStrong),
    solid_contrast: to_contrast_ratio(color_scale.solid_text, color_scale.solid),
    solid_subtle_contrast: to_contrast_ratio(
      color_scale.solid_text,
      color_scale.solid_subtle,
    ),
    solid_strong_contrast: to_contrast_ratio(
      color_scale.solid_text,
      color_scale.solid_strong,
    ),
  )
}

fn view_sample_table(
  variant: String,
  color_scale: ColorScale,
  show_contrast: Bool,
) -> Element(Msg) {
  let color_scale_matrix = to_color_scale_matrix(color_scale)
  let variant_name = case variant {
    "" -> "base"
    _ -> variant
  }

  html.div([attr.class("w-theme"), color_scale_css_vars_attr(color_scale)], [
    html.article([attr.class("w--sample--table shadow-xl shadow-shadow/10")], [
      html.div([attr.class("flex items-center justify-end")], [
        html.label([attr.class("flex items-center gap-2 p-2")], [
          html.input([
            attr.type_("checkbox"),
            attr.checked(show_contrast),
            event.on_check(OnShowContrastInput),
          ]),
          html.p([], [html.text("show contrast tags")]),
        ]),
      ]),
      html.table([attr.class("min-w-full")], [
        html.thead([], [
          html.tr([], [
            html.th([attr.attribute("scope", "col")], [html.text(variant_name)]),
            html.th(
              [
                attr.attribute("scope", "col"),
                attr.class("border-l border-accent-subtle"),
              ],
              [html.text("text")],
            ),
            html.th(
              [attr.attribute("scope", "col"), attr.class("text-subtle")],
              [html.text("subtle")],
            ),
            html.th(
              [
                attr.attribute("scope", "col"),
                attr.class("border-l border-accent-subtle"),
                attr.class("text-subtle"),
              ],
              [html.text("subtle")],
            ),
            html.th([attr.attribute("scope", "col")], [html.text("accent")]),
            html.th(
              [attr.attribute("scope", "col"), attr.class("text-subtle")],
              [html.text("strong")],
            ),
            html.th(
              [
                attr.attribute("scope", "col"),
                attr.class("text-subtle"),
                attr.class("border-l border-accent-subtle"),
              ],
              [html.text("subtle")],
            ),
            html.th([attr.attribute("scope", "col")], [html.text("solid")]),
            html.th(
              [attr.attribute("scope", "col"), attr.class("text-subtle")],
              [html.text("strong")],
            ),
          ]),
        ]),
        html.tbody([], [
          view_matrix_row(
            variant,
            "bg-subtle",
            "bg-subtle",
            color_scale,
            BgSubtle,
            color_scale.bg_subtle,
          ),
          view_matrix_row(variant, "bg", "bg", color_scale, Bg, color_scale.bg),
          view_matrix_row(
            variant,
            "tint-subtle",
            "bg-tint-subtle",
            color_scale,
            TintSubtle,
            color_scale.tint_subtle,
          ),
          view_matrix_row(
            variant,
            "tint",
            "bg-tint",
            color_scale,
            Tint,
            color_scale.tint,
          ),
          view_matrix_row(
            variant,
            "tint-strong",
            "bg-tint-strong",
            color_scale,
            TintStrong,
            color_scale.tint_strong,
          ),
        ]),
      ]),
      // small palette
      html.ul(
        [attr.class("flex items-center gap-1 p-2")],
        color_scale
          |> to_color_scale_grouped_colors()
          |> list.map(fn(grouped_colors) {
            let #(key_color, colors) = grouped_colors
            let #(k, v) = key_color

            case colors {
              [] ->
                html.li([attr.class("flex flex-col gap-1")], [
                  view_input_color_btn(v, "h-10 w-6", fn(c) {
                    OnColorInput(variant, k, c)
                  }),
                ])

              _ ->
                html.li([attr.class("flex flex-col gap-1")], [
                  view_input_color_btn(v, "flex-grow h-5", fn(c) {
                    OnColorInput(variant, k, c)
                  }),
                  html.ul(
                    [attr.class("flex items-center gap-1")],
                    colors
                      |> list.map(fn(item) {
                        let #(k, v) = item

                        view_input_color_btn(v, "size-5", fn(c) {
                          OnColorInput(variant, k, c)
                        })
                      }),
                  ),
                ])
            }
          }),
      ),
      // css definition
      html.div([attr.class("p-4 border-t border-accent-subtle")], [
        html.pre([attr.class("bg-subtle rounded-md p-8")], [
          html.code([], [
            html.text(".w-theme--" <> string.lowercase(variant_name) <> " {
  --w-bg: " <> to_hex_string(color_scale.bg) <> ";
  --w-bg-subtle: " <> to_hex_string(color_scale.bg_subtle) <> ";
  --w-tint: " <> to_hex_string(color_scale.tint) <> ";
  --w-tint-subtle: " <> to_hex_string(color_scale.tint_subtle) <> ";
  --w-tint-strong: " <> to_hex_string(color_scale.tint_strong) <> ";
  --w-accent: " <> to_hex_string(color_scale.accent) <> ";
  --w-accent-subtle: " <> to_hex_string(color_scale.accent_subtle) <> ";
  --w-accent-strong: " <> to_hex_string(color_scale.accent_strong) <> ";
  --w-solid: " <> to_hex_string(color_scale.solid) <> ";
  --w-solid-subtle: " <> to_hex_string(color_scale.solid_subtle) <> ";
  --w-solid-strong: " <> to_hex_string(color_scale.solid_strong) <> ";
  --w-solid-text: " <> to_hex_string(color_scale.solid_text) <> ";
  --w-text: " <> to_hex_string(color_scale.text) <> ";
  --w-text-subtle: " <> to_hex_string(color_scale.text_subtle) <> ";
  --w-shadow: " <> to_hex_string(color_scale.shadow) <> ";
}"),
          ]),
        ]),
      ]),
    ]),
  ])
}

fn view_input_color_btn(
  value: Color,
  class: String,
  on_input: fn(String) -> msg,
) -> Element(msg) {
  let color_string = to_hex_string(value)

  html.span(
    [
      attr.class("flex rounded relative border-1 border-white/20"),
      attr.class(class),
      attr.style("background", color_string),
    ],
    [
      html.input([
        attr.class("w-1 h-1 opacity-0"),
        attr.type_("color"),
        attr.value(color_string),
        event.on_input(on_input),
      ]),
    ],
  )
}

fn view_matrix_row(
  variant_key: String,
  label: String,
  class: String,
  color_scale: ColorScale,
  color_key: ColorKey,
  bg: Color,
) -> Element(Msg) {
  let row_color = get_color_scale_color(color_scale, color_key)

  html.tr([attr.class(class)], [
    html.th([attr.attribute("scope", "row")], [
      html.label(
        [
          attr.class("flex items-center gap-2"),
          attr.class("p-2 cursor-pointer hover:bg-white/[0.05] rounded"),
        ],
        [html.text(label)],
      ),
    ]),
    html.td([attr.class("w--sample-table-td-group-start text-color")], [
      html.text("text"),
      view_matrix_row_constrast_ratio_tag(color_scale.text, bg),
    ]),
    html.td([attr.class("text-subtle")], [
      html.text("text"),
      view_matrix_row_constrast_ratio_tag(color_scale.text_subtle, bg),
    ]),
    html.td([attr.class("w--sample-table-td-group-start text-accent-subtle")], [
      view_accent_sample(),
      view_matrix_row_constrast_ratio_tag(color_scale.accent_subtle, bg),
    ]),
    html.td([attr.class("text-accent")], [
      view_accent_sample(),
      view_matrix_row_constrast_ratio_tag(color_scale.accent, bg),
    ]),
    html.td([attr.class("text-accent-strong")], [
      view_accent_sample(),
      view_matrix_row_constrast_ratio_tag(color_scale.accent_strong, bg),
    ]),
    html.td([attr.class("w--sample-table-td-group-start")], [
      view_solid_sample("bg-solid-subtle"),
      view_matrix_row_constrast_ratio_tag(color_scale.solid_subtle, bg),
    ]),
    html.td([], [
      view_solid_sample("bg-solid"),
      view_matrix_row_constrast_ratio_tag(color_scale.solid, bg),
    ]),
    html.td([], [
      view_solid_sample("bg-solid-strong"),
      view_matrix_row_constrast_ratio_tag(color_scale.solid_strong, bg),
    ]),
  ])
}

fn view_matrix_row_constrast_ratio_tag(fg: Color, bg: Color) {
  html.div(
    [
      attr.class("w--sample--table-contrast"),
      attr.class("absolute bottom-0 left-0"),
    ],
    [view_constrast_ratio_tag(fg, bg)],
  )
}

fn view_accent_sample() -> Element(msg) {
  html.div(
    [
      attr.class(
        "inline-flex items-center justify-center h-8 w-full border border-current rounded-sm",
      ),
    ],
    [html.div([attr.class("size-3 bg-current rounded-full")], [])],
  )
}

fn view_solid_sample(class: String) -> Element(msg) {
  html.div(
    [
      attr.class(
        "inline-flex items-center justify-center h-8 w-full px-4 rounded-sm "
        <> class,
      ),
    ],
    [html.span([attr.class("text-solid")], [html.text("button")])],
  )
}

fn view_constrast_ratio(label: String, fg: Color, bg: Color) -> Element(msg) {
  html.p(
    [
      attr.class("flex items-center justify-start"),
      attr.class("gap-2 py-0.5 px-2 rounded"),
      attr.styles([
        #("color", colour.to_css_rgba_string(fg)),
        #("background", colour.to_css_rgba_string(bg)),
      ]),
    ],
    [html.div([], [html.text(label)]), view_constrast_ratio_tag(fg, bg)],
  )
}

fn to_contrast_ratio(fg: Color, bg: Color) -> ContrastRatioStatus {
  let constrast_ratio = accessibility.contrast_ratio(fg, bg)

  case
    constrast_ratio >=. 7.0,
    constrast_ratio >=. 4.5,
    constrast_ratio >=. 1.5
  {
    // recommended is 3.0
    True, _, _ -> Great
    False, True, _ -> Good
    False, False, True -> GoodForUI
    False, False, False -> Bad
  }
}

fn view_constrast_ratio_tag(fg: Color, bg: Color) -> Element(msg) {
  let constrast_ratio = accessibility.contrast_ratio(fg, bg)
  let constrast_status = to_contrast_ratio(fg, bg)
  let constrast_ratio_string =
    constrast_ratio |> float.to_precision(2) |> float.to_string()

  html.div(
    [
      attr.class("flex items-center gap-1"),
      attr.class("bg-black/40 backdrop-blur-md text-white py-0.5 px-1"),
      attr.class("text-xs tracking-wider"),
    ],
    [
      constrast_ratio_icon(constrast_status),
      html.p([], [html.text(constrast_ratio_string)]),
    ],
  )
}

fn view_variant(name: String, color_scale: ColorScale) -> Element(Msg) {
  html.article(
    [
      color_scale_css_vars_attr(color_scale),
      attr.class("w-theme"),
      attr.class("bg rounded p-4 flex gap-4"),
    ],
    [
      html.h1([attr.class("text-xl text-color flex-grow")], [html.text(name)]),
      html.div([], [
        html.div([attr.class("space-y-2 py-2")], [
          view_constrast_ratio("bg", color_scale.text, color_scale.bg),
          view_constrast_ratio(
            "bg subtle",
            color_scale.text,
            color_scale.bg_subtle,
          ),
          view_constrast_ratio(
            "tint strong",
            color_scale.text,
            color_scale.tint_strong,
          ),
          view_constrast_ratio(
            "bg + subtle",
            color_scale.text_subtle,
            color_scale.bg,
          ),
          view_constrast_ratio(
            "bg subtle + subtle",
            color_scale.text_subtle,
            color_scale.bg_subtle,
          ),
          view_constrast_ratio(
            "tint strong + subtle",
            color_scale.text_subtle,
            color_scale.tint_strong,
          ),
          view_constrast_ratio(
            "solid subtle",
            color_scale.solid_text,
            color_scale.solid_subtle,
          ),
          view_constrast_ratio(
            "solid strong",
            color_scale.solid_text,
            color_scale.solid_strong,
          ),
        ]),
        html.div(
          [],
          color_scale
            |> to_color_scale_colors()
            |> list.map(fn(item) {
              let #(k, v) = item
              let color_string = to_hex_string(v)
              let variant_key = case name == "Base" {
                True -> ""
                False -> name
              }

              html.input([
                attr.class(""),
                attr.type_("color"),
                attr.value(color_string),
                event.on_input(fn(c) { OnColorInput(variant_key, k, c) }),
              ])
            }),
        ),
        html.div([], [
          html.div(
            [
              attr.class("h-8 w-full"),
              bg_gradient_attr(
                from: "var(--w-tint-strong)",
                to: "var(--w-bg)",
                through: [],
                at: 90,
              ),
            ],
            [],
          ),
          html.div(
            [
              attr.class("h-8 w-full"),
              bg_gradient_attr(
                from: "var(--w-text)",
                to: "var(--w-accent-subtle)",
                through: ["var(--w-text-subtle)"],
                at: 90,
              ),
            ],
            [],
          ),
          html.div(
            [
              attr.class("h-8 w-full"),
              bg_gradient_attr(
                from: "var(--w-solid-subtle)",
                to: "var(--w-solid-strong)",
                through: ["var(--w-solid)"],
                at: 90,
              ),
            ],
            [],
          ),
        ]),
        html.div([attr.class("my-4 border-t border-tint")], []),
        view_bg_sample("bg"),
        html.div([attr.class("my-4 border-t border-tint")], []),
        view_bg_sample("bg-subtle"),
        html.div([attr.class("my-4 border-t border-tint")], []),
        view_bg_sample("bg-tint"),
      ]),
    ],
  )
}

fn view_bg_sample(class: String) -> Element(msg) {
  html.div(
    [
      attr.class(class),
      attr.class("space-y-4 p-4"),
      attr.class(
        "border border-solid-color rounded-sm shadow-lg shadow-shadow/10",
      ),
    ],
    [
      html.div([attr.class("flex items-center gap-4")], [
        html.div([], [
          html.p([attr.class("text-color")], [html.text("Default text")]),
          html.p([attr.class("text-subtle")], [html.text("Subtle text")]),
        ]),
        html.div([attr.class("self-stretch mx-8 border-l border-accent")], []),
        html.div([attr.class("flex gap-4 items-center")], [
          html.button(
            [
              attr.class("flex items-center justify-center"),
              attr.class("size-8 rounded-full"),
              attr.class("border border-accent"),
              attr.class("text-accent text-xl leading-none font-bold"),
            ],
            [html.text("?")],
          ),
          view_button("border-2 border-accent text-color"),
          view_button("border border-transparent bg-transparent text-color"),
          view_button("border border-tint bg-tint text-color"),
          view_solid_button("border border-solid-color bg-solid text-solid"),
        ]),
      ]),
    ],
  )
}

fn to_hex_string(c: Color) {
  "#" <> string.pad_start(colour.to_rgb_hex_string(c), 6, "0")
}

fn from_hex(hex: String) -> Color {
  let assert Ok(color) = colour.from_rgb_hex_string(hex)

  color
}

fn from_hsl(h: Float, s: Float, l: Float) -> Color {
  let assert Ok(color) = colour.from_hsl(h /. 360.0, s, l)

  color
}

fn view_button(class: String) -> Element(msg) {
  html.button([attr.class("py-2 px-4 rounded " <> class)], [
    html.text("Click"),
    html.span([attr.class("text-subtle")], [html.text(" here")]),
  ])
}

fn view_solid_button(class: String) -> Element(msg) {
  html.button([attr.class("py-2 px-4 rounded " <> class)], [
    html.text("Click here"),
  ])
}

fn bg_gradient_attr(
  from start: String,
  to end: String,
  through stops: List(String),
  at angle: Int,
) -> Attribute(msg) {
  let all_stops = list.append([start, ..stops], [end])
  let num_stops = list.length(all_stops) - 1
  let angle_str = int.to_string(angle % 360) <> "deg"
  let all_stops_str =
    all_stops
    |> list.index_map(fn(c, i) {
      let pct = int.to_float(i) /. int.to_float(num_stops)
      let pct_floor = float.round(pct *. 100.0)

      c <> " " <> int.to_string(pct_floor) <> "%"
    })
    |> string.join(", ")

  attr.style(
    "background",
    "linear-gradient(" <> angle_str <> ", " <> all_stops_str <> ")",
  )
}

pub fn main() {
  let app = lustre.application(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)

  Nil
}
