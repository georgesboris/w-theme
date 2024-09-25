import gleam/dict.{type Dict}
import gleam/dynamic.{type Decoder}
import gleam/float
import gleam/int
import gleam/io
import gleam/json.{type Json}
import gleam/list
import gleam/pair
import gleam/result
import gleam/string
import lustre.{type App}
import lustre/attribute
import lustre/effect.{type Effect}
import lustre/element.{type Element}
import lustre/element/html
import lustre/event

// ----------------------------------------------------------------------------

pub const name: String = "w-exporter"

pub fn component() -> App(Nil, Model, Msg) {
  lustre.component(init, update, view, on_attribute_change())
}

// ----------------------------------------------------------------------------

pub type Model {
  Model(themes: List(Theme))
}

pub type Msg {
  GotThemes(Result(List(Theme), dynamic.DecodeErrors))
  DownloadTheme(Theme)
}

fn init(_) -> #(Model, Effect(Msg)) {
  #(Model(themes: []), query_themes(GotThemes))
}

fn update(model: Model, msg: Msg) -> #(Model, Effect(Msg)) {
  case msg {
    GotThemes(Ok(themes)) -> {
      themes
      |> list.each(fn(theme) {
        debug_json(json.to_string(theme_to_w3c_design_tokens(theme)))
        debug_json(json.to_string(theme_to_figma(theme)))
      })

      #(Model(..model, themes: themes), effect.none())
    }

    GotThemes(Error(errors)) -> {
      errors
      |> list.each(fn(error) {
        io.print("expected: " <> error.expected)
        io.print("found: " <> error.found)
        io.print("path: " <> string.join(error.path, ","))
      })

      #(model, effect.none())
    }

    DownloadTheme(theme) -> {
      #(model, download_json(theme.id, theme_to_w3c_design_tokens(theme)))
    }
  }
}

fn view(model: Model) -> Element(Msg) {
  html.article(
    [
      attribute.style([
        #("position", "fixed"),
        #("bottom", "0"),
        #("right", "0"),
        #("background", "#fff"),
        #("box-shadow", "0 0 8px rgba(0,0,0,0.2)"),
      ]),
    ],
    [
      html.h1(
        [
          attribute.style([
            #("text-transform", "uppercase"),
            #("font-size", "0.6rem"),
            #("letter-spacing", "0.1rem"),
            #("padding", "0.25rem 0.5rem"),
          ]),
        ],
        [html.text("w-theme exporter")],
      ),
      case list.is_empty(model.themes) {
        True -> html.p([], [html.text("No themes found.")])
        False ->
          html.ul(
            [attribute.style([])],
            model.themes
              |> list.map(fn(theme) {
                html.li(
                  [
                    attribute.style([
                      #("display", "flex"),
                      #("flex-direction", "column"),
                      #("align-items", "stretch"),
                      #("gap", "4px"),
                      #("padding", "4px"),
                      #("text-align", "center"),
                      #("border-top", "1px solid #dadada"),
                    ]),
                  ],
                  [
                    html.p(
                      [
                        attribute.style([
                          #("display", "flex"),
                          #("justify-content", "space-between"),
                          #("align-items", "center"),
                          #("font-size", "0.75rem"),
                        ]),
                      ],
                      [
                        html.span([attribute.style([#("font-weight", "700")])], [
                          html.text("Theme"),
                        ]),
                        html.span([attribute.style([])], [html.text(theme.id)]),
                      ],
                    ),
                    view_button(DownloadTheme(theme), "Export"),
                  ],
                )
              }),
          )
      },
    ],
  )
}

fn view_button(on_click: msg, label: String) -> Element(msg) {
  html.button(
    [
      event.on_click(on_click),
      attribute.style([
        #("display", "flex"),
        #("justify-content", "center"),
        #("align-items", "center"),
        #("width", "100%"),
        #("padding", "0.6rem 1rem 0.7rem"),
        #("border-radius", "4px"),
        #("background", "black"),
        #("color", "white"),
        #("font-size", "0.75rem"),
        #("font-weight", "700"),
        #("line-height", "1"),
        #("letter-spacing", "0.05em"),
        #("text-transform", "uppercase"),
      ]),
    ],
    [html.text(label)],
  )
}

fn on_attribute_change() -> Dict(String, Decoder(Msg)) {
  dict.new()
}

// Theme ----------------------------------------------------------------------

pub type Theme {
  Theme(
    id: String,
    fonts: List(#(String, String)),
    radius: List(#(String, Float)),
    sizing: List(#(String, Float)),
    spacing: List(#(String, Float)),
    colors: List(#(String, List(#(String, String)))),
  )
}

// Theme - W3C Design Tokens --------------------------------------------------

fn theme_to_w3c_design_tokens(theme: Theme) -> Json {
  json.object([
    #(
      theme.id,
      json.object(
        list.flatten([
          [
            w3c_fonts(theme),
            w3c_radius(theme),
            w3c_spacing(theme),
            w3c_sizing(theme),
          ],
          w3c_colors(theme),
        ]),
      ),
    ),
  ])
}

fn w3c_fonts(theme: Theme) -> #(String, Json) {
  w3c_definitions(
    group: "font",
    type_: "fontFamily",
    value_to_json: json.string,
    values: theme.fonts,
  )
}

fn w3c_colors(theme: Theme) -> List(#(String, Json)) {
  list.map(theme.colors, fn(variant_data) {
    let #(variant, variant_colors) = variant_data

    w3c_definitions(
      group: variant,
      type_: "color",
      values: variant_colors,
      value_to_json: fn(color_channels) {
        color_channels
        |> string.replace(" ", ",")
        |> fn(x) { "rgb(" <> x <> ")" }
        |> json.string()
      },
    )
  })
}

fn w3c_radius(theme: Theme) -> #(String, Json) {
  w3c_definitions(
    group: "radius",
    type_: "borderRadius",
    value_to_json: json.float,
    values: theme.radius,
  )
}

fn w3c_sizing(theme: Theme) -> #(String, Json) {
  w3c_definitions(
    group: "sizing",
    type_: "dimension",
    value_to_json: json.float,
    values: theme.sizing,
  )
}

fn w3c_spacing(theme: Theme) -> #(String, Json) {
  w3c_definitions(
    group: "spacing",
    type_: "spacing",
    value_to_json: json.float,
    values: theme.spacing,
  )
}

fn w3c_definitions(
  group group: String,
  type_ type_: String,
  value_to_json value_to_json: fn(a) -> Json,
  values values: List(#(String, a)),
) -> #(String, Json) {
  #(
    group,
    json.object(
      values
      |> list.map(fn(value_data) {
        let #(value_name, value) = value_data

        #(
          value_name,
          json.object([
            #("$type", json.string(type_)),
            #("$value", value_to_json(value)),
          ]),
        )
      }),
    ),
  )
}

// Theme - Figma --------------------------------------------------------------

fn theme_to_figma(theme: Theme) -> Json {
  [
    #("name", json.string(theme.id)),
    #(
      "variables",
      [
        figma_fonts(theme.fonts),
        figma_spacings(theme.spacing),
        figma_sizings(theme.sizing),
        figma_radius(theme.radius),
        figma_colors_json(theme.colors),
      ]
        |> list.flatten()
        |> json.preprocessed_array(),
    ),
  ]
  |> json.object()
}

fn figma_fonts(theme_fonts: List(#(String, String))) -> List(json.Json) {
  theme_fonts
  |> list.map(fn(font_data) {
    let #(font, value) = font_data

    json.object([
      #("name", json.string("font/" <> font)),
      #("type", json.string("STRING")),
      #("scopes", json.array(["FONT_FAMILY"], json.string)),
      #("valuesByMode", json.object([#("1:0", json.string(value))])),
    ])
  })
}

fn figma_spacings(theme_spacings: List(#(String, Float))) -> List(json.Json) {
  theme_spacings
  |> list.map(fn(spacing_data) {
    let #(spacing, value) = spacing_data

    json.object([
      #("name", json.string("spacing/" <> spacing)),
      #("type", json.string("STRING")),
      #("scopes", json.array(["WIDTH_HEIGHT", "GAP"], json.string)),
      #("valuesByMode", json.object([#("1:0", json.float(value))])),
    ])
  })
}

fn figma_sizings(theme_sizings: List(#(String, Float))) -> List(json.Json) {
  theme_sizings
  |> list.map(fn(sizing_data) {
    let #(sizing, value) = sizing_data

    json.object([
      #("name", json.string("sizing/" <> sizing)),
      #("type", json.string("FLOAT")),
      #("scopes", json.array(["WIDTH_HEIGHT"], json.string)),
      #("valuesByMode", json.object([#("1:0", json.float(value))])),
    ])
  })
}

fn figma_radius(theme_radius: List(#(String, Float))) -> List(json.Json) {
  theme_radius
  |> list.map(fn(radius_data) {
    let #(radius, value) = radius_data

    json.object([
      #("name", json.string("radius/" <> radius)),
      #("type", json.string("FLOAT")),
      #("scopes", json.array(["CORNER_RADIUS"], json.string)),
      #("valuesByMode", json.object([#("1:0", json.float(value))])),
    ])
  })
}

fn figma_colors_json(
  theme_colors: List(#(String, List(#(String, String)))),
) -> List(json.Json) {
  theme_colors
  |> list.flat_map(fn(variant_tuple) {
    let #(variant, variant_colors) = variant_tuple

    variant_colors
    |> list.map(fn(color_data) {
      let #(color, color_channels) = color_data
      let assert [r, g, b] = string.split(color_channels, " ")
      let assert Ok(r) = int.parse(r)
      let assert Ok(g) = int.parse(g)
      let assert Ok(b) = int.parse(b)

      json.object([
        #("name", json.string(variant <> "/" <> color)),
        #("description", json.string("")),
        #("type", json.string("COLOR")),
        #("scopes", json.array(["ALL_SCOPES"], json.string)),
        #(
          "valuesByMode",
          json.object([
            #(
              "1:0",
              json.object([
                #("r", json.float(int.to_float(r) /. 255.0)),
                #("g", json.float(int.to_float(g) /. 255.0)),
                #("b", json.float(int.to_float(b) /. 255.0)),
                #("a", json.float(1.0)),
              ]),
            ),
          ]),
        ),
      ])
    })
  })
}

// Theme - Decoder ------------------------------------------------------------

fn theme_decoder() -> Decoder(Theme) {
  dynamic.decode6(
    Theme,
    dynamic.field("id", dynamic.string),
    dynamic.field(
      "fonts",
      dynamic.list(dynamic.decode2(
        pair.new,
        dynamic.field("font", dynamic.string),
        dynamic.field("value", dynamic.string),
      )),
    ),
    dynamic.field(
      "radius",
      dynamic.list(dynamic.decode2(
        pair.new,
        dynamic.field("radius", dynamic.string),
        dynamic.field("value", px_decoder()),
      )),
    ),
    dynamic.field(
      "sizing",
      dynamic.list(dynamic.decode2(
        pair.new,
        dynamic.field("sizing", dynamic.string),
        dynamic.field("value", px_decoder()),
      )),
    ),
    dynamic.field(
      "spacing",
      dynamic.list(dynamic.decode2(
        pair.new,
        dynamic.field("spacing", dynamic.string),
        dynamic.field("value", px_decoder()),
      )),
    ),
    dynamic.field(
      "colors",
      dynamic.list(dynamic.decode2(
        pair.new,
        dynamic.field("variant", dynamic.string),
        dynamic.field(
          "colorScale",
          dynamic.list(dynamic.decode2(
            pair.new,
            dynamic.field("color", dynamic.string),
            dynamic.field("value", dynamic.string),
          )),
        ),
      )),
    ),
  )
}

fn px_decoder() -> Decoder(Float) {
  fn(input: dynamic.Dynamic) {
    input
    |> dynamic.string()
    |> result.then(fn(value) {
      value
      |> string.replace("px", "")
      |> int.parse()
      |> fn(r) {
        case r {
          Ok(v) -> Ok(int.to_float(v))
          Error(_) ->
            Error([
              dynamic.DecodeError(
                expected: "An integer followed by 'px'",
                found: value,
                path: [],
              ),
            ])
        }
      }
    })
  }
}

// Effects --------------------------------------------------------------------

fn query_themes(
  on_response: fn(Result(List(Theme), dynamic.DecodeErrors)) -> msg,
) -> Effect(msg) {
  effect.from(fn(dispatch) {
    query_themes_ffi()
    |> dynamic.list(theme_decoder())
    |> on_response
    |> dispatch
  })
}

fn download_json(name: String, json: Json) -> Effect(msg) {
  effect.from(fn(_) { download_json_ffi(name, json.to_string(json)) })
}

@external(javascript, "./w_exporter.ffi.mjs", "queryThemes")
fn query_themes_ffi() -> dynamic.Dynamic

@external(javascript, "./w_exporter.ffi.mjs", "debugJson")
fn debug_json(json: String) -> Nil

@external(javascript, "./w_exporter.ffi.mjs", "downloadJson")
fn download_json_ffi(filename: String, json: String) -> Nil
