import gleam/list
import gleam/result
import gleam/string

// Types

pub type FontPalette {
  FontPalette(name: String, heading: Font, text: Font, code: Font)
}

pub type Font {
  Font(name: String, css: String, css_import: String, href: String)
}

// Palettes

pub fn palettes() -> List(FontPalette) {
  list.map(font_pairs_hrefs, font_palette_from_hrefs)
}

pub fn default_palette() {
  font_palette_from_hrefs(#(
    "https://fonts.google.com/specimen/Playfair+Display",
    "https://fonts.google.com/specimen/Source+Sans+Pro",
  ))
}

// Building Palettes

fn font_palette_from_hrefs(pair: #(String, String)) -> FontPalette {
  let #(font_heading_href, font_text_href) = pair
  let font_heading = font_from_href(font_heading_href)
  let font_text = font_from_href(font_text_href)
  let font_code =
    font_from_href("https://fonts.google.com/specimen/JetBrains+Mono")

  FontPalette(
    name: font_heading.name <> " + " <> font_text.name,
    heading: font_heading,
    text: font_text,
    code: font_code,
  )
}

fn font_from_href(href: String) -> Font {
  let name =
    href
    |> string.split("/")
    |> list.last()
    |> result.unwrap("")
    |> string.replace(each: "+", with: " ")

  Font(
    href: href,
    css: "\"" <> name <> "\"",
    css_import: string.replace(name, each: " ", with: "+"),
    name: name,
  )
}

// Palettes List
// Based on https://www.pagecloud.com/blog/best-google-fonts-pairings

const font_pairs_hrefs: List(#(String, String)) = [
  #(
    "https://fonts.google.com/specimen/Playfair+Display",
    "https://fonts.google.com/specimen/Source+Sans+Pro",
  ),
  #(
    "https://fonts.google.com/specimen/Playfair+Display",
    "https://fonts.google.com/specimen/Source+Sans+Pro",
  ),
  #(
    "https://fonts.google.com/specimen/Quattrocento",
    "https://fonts.google.com/specimen/Quattrocento+Sans",
  ),
  #(
    "https://fonts.google.com/specimen/Quattrocento",
    "https://fonts.google.com/specimen/Fanwood+Text",
  ),
  #(
    "https://fonts.google.com/specimen/Oswald",
    "https://fonts.google.com/specimen/Quattrocento",
  ),
  #(
    "https://fonts.google.com/specimen/Fjalla+One",
    "https://fonts.google.com/specimen/Libre+Baskerville",
  ),
  #(
    "https://fonts.google.com/specimen/Lustria",
    "https://fonts.google.com/specimen/Lato",
  ),
  #(
    "https://fonts.google.com/specimen/Cormorant+Garamond",
    "https://fonts.google.com/specimen/Proza+Libre",
  ),
  #(
    "https://fonts.google.com/specimen/Oswald",
    "https://fonts.google.com/specimen/EB+Garamond",
  ),
  #(
    "https://fonts.google.com/specimen/Libre+Baskerville",
    "https://fonts.google.com/specimen/Source+Sans+Pro",
  ),
  #(
    "https://fonts.google.com/specimen/Cinzel",
    "https://fonts.google.com/specimen/Fauna+One",
  ),
  #(
    "https://fonts.google.com/specimen/Sacramento",
    "https://fonts.google.com/specimen/Alice",
  ),
  #(
    "https://fonts.google.com/specimen/Yeseva+One",
    "https://fonts.google.com/specimen/Josefin+Sans",
  ),
  #(
    "https://fonts.google.com/specimen/Libre+Baskerville",
    "https://fonts.google.com/specimen/Josefin+Sans",
  ),
  #(
    "https://fonts.google.com/specimen/Cardo",
    "https://fonts.google.com/specimen/Josefin+Sans",
  ),
  #(
    "https://fonts.google.com/specimen/Lora",
    "https://fonts.google.com/specimen/Roboto",
  ),
  #(
    "https://fonts.google.com/specimen/Spectral",
    "https://fonts.google.com/specimen/Karla",
  ),
  #(
    "https://fonts.google.com/specimen/Halant",
    "https://fonts.google.com/specimen/Nunito+Sans",
  ),
  #(
    "https://fonts.google.com/specimen/Karla",
    "https://fonts.google.com/specimen/Karla",
  ),
  #(
    "https://fonts.google.com/specimen/Lora",
    "https://fonts.google.com/specimen/Merriweather",
  ),
  #(
    "https://fonts.google.com/specimen/Roboto",
    "https://fonts.google.com/specimen/Nunito",
  ),
  #(
    "https://fonts.google.com/specimen/Quicksand",
    "https://fonts.google.com/specimen/Quicksand",
  ),
  #(
    "https://fonts.google.com/specimen/Ubuntu",
    "https://fonts.google.com/specimen/Open+Sans",
  ),
  #(
    "https://fonts.google.com/specimen/Montserrat",
    "https://fonts.google.com/specimen/Hind",
  ),
  #(
    "https://fonts.google.com/specimen/Nunito",
    "https://fonts.google.com/specimen/PT+Sans",
  ),
  #(
    "https://fonts.google.com/specimen/Oswald",
    "https://fonts.google.com/specimen/Merriweather",
  ),
  #(
    "https://fonts.google.com/specimen/Montserrat",
    "https://fonts.google.com/specimen/Cardo",
  ),
  #(
    "https://fonts.google.com/specimen/Montserrat",
    "https://fonts.google.com/specimen/Crimson+Text",
  ),
  #(
    "https://fonts.google.com/specimen/Open+Sans",
    "https://fonts.google.com/specimen/Open+Sans+Condensed",
  ),
  #(
    "https://fonts.google.com/specimen/Nunito",
    "https://fonts.google.com/specimen/Nunito",
  ),
  #(
    "https://fonts.google.com/specimen/Arvo",
    "https://fonts.google.com/specimen/Lato",
  ),
  #(
    "https://fonts.google.com/specimen/Abril+Fatface",
    "https://fonts.google.com/specimen/Poppins",
  ),
  #(
    "https://fonts.google.com/specimen/Playfair+Display",
    "https://fonts.google.com/specimen/Source+Sans+Pro",
  ),
  #(
    "https://fonts.google.com/specimen/Karla",
    "https://fonts.google.com/specimen/Inconsolata",
  ),
  #(
    "https://fonts.google.com/specimen/Ultra",
    "https://fonts.google.com/specimen/Slabo+27px",
  ),
  #(
    "https://fonts.google.com/specimen/Nixie+One",
    "https://fonts.google.com/specimen/Ledger",
  ),
  #(
    "https://fonts.google.com/specimen/Stint+Ultra+Expanded",
    "https://fonts.google.com/specimen/Pontano+Sans",
  ),
  #(
    "https://fonts.google.com/specimen/Amatic+SC",
    "https://fonts.google.com/specimen/Andika",
  ),
  #(
    "https://fonts.google.com/specimen/Unica+One",
    "https://fonts.google.com/specimen/Crimson+Text",
  ),
  #(
    "https://fonts.google.com/specimen/Philosopher",
    "https://fonts.google.com/specimen/Muli",
  ),
  #(
    "https://fonts.google.com/specimen/Source+Sans+Pro",
    "https://fonts.google.com/specimen/Source+Serif+Pro",
  ),
  #(
    "https://fonts.google.com/specimen/Fjalla+One",
    "https://fonts.google.com/specimen/Cantarell",
  ),
  #(
    "https://fonts.google.com/specimen/Work+Sans",
    "https://fonts.google.com/specimen/Open+Sans",
  ),
  #(
    "https://fonts.google.com/specimen/Hind",
    "https://fonts.google.com/specimen/Open+Sans",
  ),
  #(
    "https://fonts.google.com/specimen/Nunito",
    "https://fonts.google.com/specimen/Open+Sans",
  ),
  #(
    "https://fonts.google.com/specimen/Oxygen",
    "https://fonts.google.com/specimen/Source+Sans+Pro",
  ),
  #(
    "https://fonts.google.com/specimen/PT+Sans",
    "https://fonts.google.com/specimen/Cabin",
  ),
  #(
    "https://fonts.google.com/specimen/Roboto+Condensed",
    "https://fonts.google.com/specimen/Cabin",
  ),
  #(
    "https://fonts.google.com/specimen/Raleway",
    "https://fonts.google.com/specimen/Open+Sans",
  ),
  #(
    "https://fonts.google.com/specimen/Roboto",
    "https://fonts.google.com/specimen/Lora",
  ),
]
