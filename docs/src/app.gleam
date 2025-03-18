import app/colors
import app/fonts
import gleam/io
import gleam/list
import gleam/pair
import gleam/result
import gleam_community/colour
import lustre
import lustre/attribute as ha
import lustre/effect
import lustre/element.{text}
import lustre/element/html as h
import lustre/event

type Model {
  Model(font_palettes: List(fonts.FontPalette), font_palette: fonts.FontPalette)
}

type Msg {
  OnSelectFontPalette(String)
}

pub fn main() {
  let app =
    lustre.application(
      fn(_) {
        #(
          Model(
            font_palettes: fonts.palettes(),
            font_palette: fonts.default_palette(),
          ),
          effect.none(),
        )
      },
      fn(model, msg) {
        case msg {
          OnSelectFontPalette(palette) -> {
            #(
              Model(
                ..model,
                font_palette: model.font_palettes
                  |> list.find(fn(x) { x.name == palette })
                  |> result.unwrap(model.font_palette)
                  |> io.debug(),
              ),
              effect.none(),
            )
          }
        }
      },
      fn(model) {
        element.fragment([
          h.style([], font_imports(model.font_palette)),
          h.div(
            [
              ha.class("grid grid-cols-12 p-xl gap-xl"),
              ha.class("font-text"),
              ha.style([
                #("--w-font-heading", model.font_palette.heading.css),
                #("--w-font-text", model.font_palette.text.css),
                #("--w-font-code", model.font_palette.code.css),
              ]),
            ],
            [
              h.div([ha.class("col-span-2")], [header()]),
              h.div([ha.class("col-span-4")], [main_content()]),
              h.div([ha.class("col-span-4")], [theme_builder(model)]),
            ],
          ),
        ])
      },
    )

  let assert Ok(_) = lustre.start(app, "#app", Nil)

  Nil
}

fn font_imports(font_palette: fonts.FontPalette) {
  "@import url('https://fonts.googleapis.com/css2?display=block"
  <> font_import_family(font_palette.heading)
  <> font_import_family(font_palette.text)
  <> font_import_family(font_palette.code)
}

fn font_import_family(font: fonts.Font) {
  "&family=" <> font.css_import
}

fn header() {
  h.hgroup([], [
    h.h1([ha.class("font-heading text-3xl")], [text("W Theme")]),
    h.h2([ha.class("text-subtle")], [
      text(
        "A theme schema designed for consistency and flexibility with support for light and dark modes.",
      ),
    ]),
  ])
}

fn theme_builder(model: Model) {
  let base_color_scale = colors.default_base()

  h.article([], [
    h.h1([ha.class("font-heading text-3xl")], [text("Theme Builder")]),
    h.select(
      [ha.value(model.font_palette.name), event.on_input(OnSelectFontPalette)],
      model.font_palettes
        |> list.map(fn(palette) {
          h.option([ha.value(palette.name)], palette.name)
        }),
    ),
    view_color_scale(base_color_scale, base_color_scale),
  ])
}

fn view_color_scale(
  color_scale: colors.ColorScale,
  base_scale: colors.ColorScale,
) {
  let color_base = colour.to_hsla(color_scale.solid)
  let color_hue = color_base.0
  let color_saturation = color_base.1

  h.section(
    [ha.class("flex gap-sm")],
    [
      #(color_scale.bg, color_scale.bg),
      #(color_scale.bg_subtle, color_scale.bg),
      #(color_scale.tint_subtle, color_scale.bg),
      #(color_scale.tint, color_scale.bg),
      #(color_scale.tint_strong, color_scale.bg),
      #(color_scale.accent_subtle, color_scale.bg),
      #(color_scale.accent, color_scale.bg),
      #(color_scale.accent_strong, color_scale.bg),
      #(color_scale.solid_subtle, color_scale.bg),
      #(color_scale.solid, color_scale.bg),
      #(color_scale.solid_strong, color_scale.bg),
      #(color_scale.solid_text, color_scale.solid),
      #(color_scale.text_subtle, color_scale.bg),
      #(color_scale.text, color_scale.bg),
      #(color_scale.shadow, color_scale.bg),
    ]
      |> list.map(fn(pair) {
        let #(color, bg_color) = pair
        let color_norm =
          color
          |> colour.to_hsla
          |> fn(x) {
            let assert Ok(c) =
              colour.from_hsla(color_hue, color_saturation, x.2, 1.0)

            c
          }

        let color_stats =
          colors.color_stats(color_norm, bg_color, base_scale.bg)

        h.div([ha.class("flex flex-col gap-sm")], [
          h.div(
            [
              ha.class("h-lg w-lg"),
              ha.style([#("background", colour.to_css_rgba_string(color))]),
            ],
            [],
          ),
          h.div(
            [
              ha.class("h-lg w-lg"),
              ha.style([#("background", colour.to_css_rgba_string(color_norm))]),
            ],
            [],
          ),
          h.div(
            [ha.class("text-sm")],
            color_stats
              |> list.map(fn(stat) {
                element.fragment([
                  // h.div([ha.class("col-span-4")], [text(pair.first(stat))]),
                  h.div([ha.class("col-span-8")], [text(pair.second(stat))]),
                ])
              }),
          ),
        ])
      }),
  )
}

fn main_content() {
  h.code([ha.class("font-text")], [
    text(
      "
            <h2 id=\"colors\">Colors</h2>
      <p>We can safely say that colors are the star of the show of any theme.
        Our theme specification is made of a <em>color palette of 6 colors</em> and each color is made of a <em>scale of
          12 variations</em>.
        This might seem like <em>a lot</em> of available colors, but this was decided through a lot of real world
        experimentation and minimalistic color scales ended up relying on other factors such as opacity for achieving
        the flexibility needed for building rich UI&#39;s.
        This ends up becoming a huge pain to maintain and opacity is <em>not</em> an ideal way of mixing colors.
        With this set of colors available, we&#39;re confident that you can build rich interfaces without opting for
        escape hatches of your design system.</p>
      <h3 id=\"color-palette\">Color Palette</h3>
      <blockquote>
        <p>a.k.a &quot;color variants&quot;</p>
      </blockquote>
      <p>Every theme is built using a palette of 6 colors.</p>
      <ul>
        <li><strong>Base</strong> — used for most of the content, the main background, text colors, etc.</li>
        <li><strong>Primary</strong> ­— used for content highlights with a contrasting color, sometimes called
          <em>&quot;accent&quot;</em> color.
        </li>
        <li><strong>Secondary</strong> — used as an alternative to the primary color, giving flexibility to your
          designs.</li>
        <li><strong>Success</strong> — used for positive content. <em>e.g. success feedbacks, confirm buttons, …</em>
        </li>
        <li><strong>Warning</strong> ­— used for cautionary content. <em>e.g. non critical warning messages</em></li>
        <li><strong>Danger</strong> — used for errors and destructive content. <em>e.g. failure feedbacks, delete
            buttons, …</em></li>
      </ul>
      <h3 id=\"color-scale\">Color Scale</h3>
      <p>Each color is defined using a scale with 12 steps.</p>
      <h4 id=\"background\">Background</h4>
      <ul>
        <li><strong>bg</strong> — the main background of your ui</li>
        <li><strong>bg-subtle</strong> — an alternate, slightly darker, color of your main background. useful for
          creating depth.</li>
      </ul>
      <h4 id=\"tint\">Tint</h4>
      <ul>
        <li><strong>tint</strong> — useful for subtle backgrounds of some UI elements.</li>
        <li><strong>tint-subtle</strong> — subtler variation, useful for &quot;pressed&quot; states.</li>
        <li><strong>tint-strong</strong> — stronger variation, useful for &quot;hovered&quot; states.</li>
      </ul>
      <h4 id=\"accent\">Accent</h4>
      <ul>
        <li><strong>accent</strong> — useful for dividers, borders and other small UI elements.</li>
        <li><strong>accent-subtle</strong> — subtle variation, useful for &quot;pressed&quot; states.</li>
        <li><strong>accent-strong</strong> — stronger variation, useful for &quot;hovered&quot; states.</li>
      </ul>
      <p><strong>Accent</strong> colors are not made for background or text usage as they&#39;re not guaranteed to have
        proper contrast, they should be used for colored elements.</p>
      <h4 id=\"solid\">Solid</h4>
      <ul>
        <li><strong>solid</strong> — useful for solid elements such as buttons.</li>
        <li><strong>solid-subtle</strong> — subtle variation, useful for &quot;pressed&quot; states.</li>
        <li><strong>solid-strong</strong> — stronger variation, useful for &quot;hovered&quot; states.</li>
        <li><strong>solid-text</strong> — contrasting color ensuring legibility of text over solid backgrounds</li>
      </ul>
      <p><strong>Solid</strong> colors should use <strong>solid-text</strong> as their text color for proper
        accessibility.</p>
      <h4 id=\"text\">Text</h4>
      <ul>
        <li><strong>text</strong> — the main text color of your application.</li>
        <li><strong>text-subtle</strong> — subtler variation for secondary text.</li>
      </ul>
      <p>Both <strong>text colors</strong> are guaranteed to be <strong>accessible</strong> over any
        <strong>background</strong> and <strong>tint</strong> colors.
      </p>
      <h4 id=\"shadow\">Shadow</h4>
      <ul>
        <li><strong>shadow</strong> — a darker shade of the color, useful for coloring shadows.</li>
      </ul>
      <p>Shadows are usually used with alpha values for better effects: <code>rgb(var(--w-base-shadow) / 0.25)</code>
      </p>
      <blockquote>
        <p>[!TIP]
          We use &quot;color channels&quot; on our CSS variable colors instead of a defined color space. So we can:</p>
        <ul>
          <li>Create transparent variations of any colors like this <code>rgb(--var(--w-base-bg) / 0.5)</code></li>
          <li>Be <a href=\"\">tailwindcss compatible</a> so you can use their colors using tailwind&#39;s opacity
            functions <code>bg-primary/50</code></li>
        </ul>
        <p>So, remember to always use the colors variables like</p>
        <ul>
          <li><code>rgb(--var(--w-primary-solid))</code></li>
          <li>Or <code>rgb(--var(--w-primary-solid) / 0.5)</code></li>
        </ul>
        <p>[!NOTE]
          Our color scale was largely inspired by <a href=\"https://www.radix-ui.com/colors\">radix-colors</a>. Do you
          want to know what are the differences?
          Their colors are built using a 1-12 scale with semantic meaning given through documentation.</p>
        <ul>
          <li>Semantic names are used instead of their number based naming.</li>
          <li>We ensure consistency across the main color spaces, so our <strong>tint</strong>, <strong>accent</strong>
            and <strong>solid</strong> colors have the same tones available.</li>
          <li>We included the contrasting <code>solid-text</code> into our scale, instead of relying on <a
              href=\"https://www.radix-ui.com/colors/docs/palette-composition/understanding-the-scale#steps-910-solid-backgrounds\">different
              implied values for some colors</a>.</li>
          <li><code>bg-subtle</code> is <em>always</em> darker than <code>bg</code>, while radix&#39;s 2nd color
            contrast differs between light and dark modes.</li>
          <li><code>solid-text</code> is not an official color on the radix scale, it is supposed to be implied
            depending on the color used (most colors use white as contrast color but some hand-picked colors use a
            darker tone). We made it an official color so it is easier to build UI&#39;s without knowing the color that
            is being used. </li>
          <li><code>shadow</code> is a scale itself in radix and not a color shade.</li>
        </ul>
      </blockquote>
      <h2 id=\"font-families\">Font Families</h2>
      <p>Not a lot to cover regarding our font family tokens. You can define then with fallback values, just like you
        would when defining the <a href=\"https://developer.mozilla.org/en-US/docs/Web/CSS/font-family\">font-family</a>
        css property.</p>
      <pre><code class=\"lang-yaml\">-<span class=\"ruby\"> heading
          </span>-<span class=\"ruby\"> text
          </span>-<span class=\"ruby\"> code</span>
        </code></pre>
      <h2 id=\"font-size\">Font Size</h2>
      <p>The font sizes should be defined using <code>rem</code> values. This way you can control all of your
        interface&#39;s sizes by moving the base value of your font size in a single place.
        The scale chosen here was deeply inspired by <a href=\"https://tailwindcss.com/docs/font-size\">TailwindCSS</a>.
      </p>
      <pre><code class=\"lang-yaml\">-<span class=\"ruby\"> xs
          </span>-<span class=\"ruby\"> sm
          </span>-<span class=\"ruby\"> md
          </span>-<span class=\"ruby\"> lg
          </span>-<span class=\"ruby\"> xl
          </span>-<span class=\"ruby\"> <span class=\"hljs-number\">2</span>xl
          </span>-<span class=\"ruby\"> <span class=\"hljs-number\">3</span>xl
          </span>`
        </code></pre>
      <h2 id=\"font-tracking\">Font Tracking</h2>
      <p>Also known as <strong>letter spacing</strong>. Font tracking controls how each character is spaced to each
        other. These values are defined using <code>em</code> units, so the setting works in relation to the currently
        used font size.
        The scale chosen here was deeply inspired by <a
          href=\"https://tailwindcss.com/docs/letter-spacing\">TailwindCSS</a>.</p>
      <pre><code class=\"lang-yaml\">-<span class=\"ruby\"> xs
          </span>-<span class=\"ruby\"> sm
          </span>-<span class=\"ruby\"> md
          </span>-<span class=\"ruby\"> lg
          </span>-<span class=\"ruby\"> xl
          </span>-<span class=\"ruby\"> <span class=\"hljs-number\">2</span>xl
          </span>-<span class=\"ruby\"> <span class=\"hljs-number\">3</span>xl
          </span>`
        </code></pre>
      <h2 id=\"font-leading\">Font Leading</h2>
      <p>Also known as <strong>line height</strong>. Font tracking controls how each character is spaced to each other.
        These values are defined using <code>em</code> units, so the setting works in relation to the currently used
        font size.
        The scale chosen here was deeply inspired by <a href=\"https://tailwindcss.com/docs/line-height\">TailwindCSS</a>.
      </p>
      <pre><code class=\"lang-yaml\">-<span class=\"ruby\"> xs
          </span>-<span class=\"ruby\"> sm
          </span>-<span class=\"ruby\"> md
          </span>-<span class=\"ruby\"> lg
          </span>-<span class=\"ruby\"> xl
          </span>-<span class=\"ruby\"> <span class=\"hljs-number\">2</span>xl
          </span>-<span class=\"ruby\"> <span class=\"hljs-number\">3</span>xl
          </span>`
        </code></pre>
      <h2 id=\"spacing\">Spacing</h2>
      <p>The most important thing about spacing variables is to use <code>rem</code> based values. This way your whole
        interface gets properly spaced when the user decides to increase their default font value for accessibility
        reasons.
        Also, you can even play around with base font values across different pages of your applications and get great
        looking results! For instance, maybe your marketing website would benefit from larger fonts and buttons, you can
        make that happen by just adjusting the <code>font-size</code> ha of your <code>h</code> element.
        :sparkles:</p>
      <p>The scale chosen here was deeply inspired by <a
          href=\"https://tailwindcss.com/docs/customizing-spacing\">TailwindCSS</a>.
        The idea of using naming based values instead of number based is that you can even integrate w-theme with
        tailwind and still be able to use both scales interchangeably (e.g <code>p-4 m-sm</code>)</p>
      <pre><code class=\"lang-yaml\">-<span class=\"ruby\"> xs
          </span>-<span class=\"ruby\"> sm
          </span>-<span class=\"ruby\"> md
          </span>-<span class=\"ruby\"> lg
          </span>-<span class=\"ruby\"> xl
          </span>-<span class=\"ruby\"> <span class=\"hljs-number\">2</span>xl
          </span>-<span class=\"ruby\"> <span class=\"hljs-number\">3</span>xl
          </span>`
        </code></pre>
      <h2 id=\"sizing\">Sizing</h2>
      <p>Sizing values are mostly used to define widths of elements such as containers, sidebars, modals, etc.
        We advise the usage of <code>rem</code> based values so that your sizings will scale consistently.</p>
      <p>The scale chosen here was deeply inspired by <a href=\"https://tailwindcss.com/docs/container\">TailwindCSS</a>.
      </p>
      <pre><code class=\"lang-yaml\">-<span class=\"ruby\"> xs
          </span>-<span class=\"ruby\"> sm
          </span>-<span class=\"ruby\"> md
          </span>-<span class=\"ruby\"> lg
          </span>-<span class=\"ruby\"> xl
          </span>-<span class=\"ruby\"> <span class=\"hljs-number\">2</span>xl
          </span>-<span class=\"ruby\"> <span class=\"hljs-number\">3</span>xl
          </span>`
        </code></pre>
      <h2 id=\"border-radius\">Border Radius</h2>
      <p>Just as spacing and sizing values, we advise the usage of <code>rem</code> based values so that your border
        radius will scale consistently.</p>
      <ul>
        <li>xs</li>
        <li>sm</li>
        <li>md</li>
        <li>lg</li>
        <li>xl</li>
        <li>2xl</li>
        <li>3xl</li>
      </ul>
      <p>The default border radius we provide are usually 50% of the size of the related spacing variable, that way you
        can usually get good results when pairing them.</p>
      <pre><code><span class=\"hljs-selector-class\">.button</span> {
          <span class=\"hljs-ha\">padding</span>: <span class=\"hljs-built_in\">var</span>(--w-spacing-md);
          <span class=\"hljs-ha\">border-radius</span>: <span class=\"hljs-built_in\">var</span>(--w-radius-md);
          }
        </code></pre>
      <p>The scale chosen here was deeply inspired by <a
          href=\"https://tailwindcss.com/docs/border-radius\">TailwindCSS</a>.
        In fact, you can integrate our scale into your tailwind theme with no surprises! Just be aware of one small
        translation:</p>
      <pre><code class=\"lang-css\"><span class=\"hljs-selector-class\">.rounded-sm</span> <span class=\"hljs-comment\">/*
            --w-radius-xs (our \"xs\" becomes tailwind's \"sm\") */</span>
          <span class=\"hljs-selector-class\">.rounded</span> <span class=\"hljs-comment\">/* --w-radius-sm (our \"sm\"
            becomes tailwind's default) */</span>
          <span class=\"hljs-selector-class\">.rounded-md</span> <span class=\"hljs-comment\">/* --w-radius-md (things are
            named equally starting from here) */</span>
          ...
        </code></pre>
      <h1 id=\"javascript-api\">Javascript API</h1>
      <p>Use our provided API to quickly declare themes and their related CSS.</p>
      <pre><code>npm <span class=\"hljs-selector-tag\">i</span> -D w-theme
        </code></pre>
      <blockquote>
        <p>[!NOTE]
          You should mostly use our Javascript API for code-generation (css/js/h).
          This library is not optimized to be used as part of your production application.
          However, you&#39;re free to use it on the browser for theme exploration sandboxes, etc.</p>
      </blockquote>
      <h4 id=\"using-built-in-colors\">Using built-in colors</h4>
      <p>The quickest way to create a theme is to use one of our <a
          href=\"https://github.com/georgesboris/w-theme/tree/main/src/w/colors.js\">built-in colors</a>.</p>
      <pre><code class=\"lang-js\"><span class=\"hljs-keyword\">import</span> wt from <span
            class=\"hljs-string\">\"w-theme\"</span>

          const <span class=\"hljs-built_in\">theme</span> = wt.<span class=\"hljs-built_in\">theme</span>({
          base: <span class=\"hljs-string\">\"slate\"</span>,
          primary: <span class=\"hljs-string\">\"cyan\"</span>,
          secondary: <span class=\"hljs-string\">\"plum\"</span>,
          fontFamilies: {
          heading: <span class=\"hljs-string\">\"Papyrus\"</span>
          }
          })

          <span class=\"hljs-comment\">// set theme on the body of your document</span>
          wt.setTheme(<span class=\"hljs-built_in\">theme</span>);

          <span class=\"hljs-comment\">// grab theme CSS content and apply it to other elements (e.g. through a
            class)</span>
          wt.getCSSVariables(<span class=\"hljs-built_in\">theme</span>);
        </code></pre>
      <h4 id=\"defining-custom-color-scales\">Defining custom color scales</h4>
      <p>You can also bypass our colors completely and pass in your custom color scale.</p>
      <pre><code class=\"lang-js\"><span class=\"hljs-keyword\">import</span> wt <span class=\"hljs-keyword\">from</span>
          <span class=\"hljs-string\">\"w-theme\"</span>

          <span class=\"hljs-keyword\">const</span> theme = wt.theme({
          primary: {
          bg: <span class=\"hljs-string\">\"<span class=\"hljs-subst\">#fff</span>\"</span>
          <span class=\"hljs-string\">\"bg-subtle\"</span>: <span class=\"hljs-string\">\"<span
              class=\"hljs-subst\">#fafafa</span>\"</span>,
          ...
          },
          })
        </code></pre>
      <h4 id=\"generating-color-scales\">Generating color scales</h4>
      <blockquote>
        <p>[!WARNING]
          Work in progress…</p>
      </blockquote>
      <p>You can pass in custom values and new color scales will be generated from theme.
        Any format recognizable by <a href=\"https://colorjs.io/\">color.js</a> can be used.</p>
      <pre><code class=\"lang-js\"><span class=\"hljs-keyword\">import</span> wt from <span
            class=\"hljs-string\">\"w-theme\"</span>

          const <span class=\"hljs-built_in\">theme</span> = wt.<span class=\"hljs-built_in\">theme</span>({
          primary: <span class=\"hljs-string\">\"#0A4\"</span>,
          secondary: <span class=\"hljs-string\">\"rgb(0, 200, 100)\"</span>
          })
        </code></pre>
      <h4 id=\"generating-spacing-and-border-radius-values\">Generating spacing and border radius values</h4>
      <p>Just as colors, you can pass in both a complete set of values to your spacings and rounded colors.
        However, you can also pass in a scale value that will be used to auto-generate all other values.</p>
      <pre><code class=\"lang-js\">import wt from <span class=\"hljs-string\">\"w-theme\"</span>

          const theme = wt.theme({
          <span class=\"hljs-symbol\"> spacing:</span> {
          <span class=\"hljs-symbol\"> xs:</span> <span class=\"hljs-string\">\"0.1rem\"</span>,
          <span class=\"hljs-symbol\"> sm:</span> <span class=\"hljs-string\">\"0.125rem\"</span>,
          ...
          },
          <span class=\"hljs-symbol\"> borderRadius:</span> {
          <span class=\"hljs-symbol\"> xs:</span> <span class=\"hljs-string\">\"0.2rem\"</span>,
          <span class=\"hljs-symbol\"> sm:</span> <span class=\"hljs-string\">\"0.3rem\"</span>,
          ...
          }
          })

          const otherTheme = wt.theme({
          <span class=\"hljs-symbol\"> spacingScale:</span> <span class=\"hljs-number\">1.2</span>,
          <span class=\"hljs-symbol\"> borderRadiusScale:</span> <span class=\"hljs-number\">0.2</span>
          })
        </code></pre>
      <h4 id=\"base-styles\">Base styles</h4>
      <p>The <code>setBaseStyles</code> function can be used for a few utilities like:</p>
      <ul>
        <li>Set most elements to use <code>font-text</code> as font family</li>
        <li>Set <code>h1, h2, h3, h4, h5, h6</code> elements to use <code>font-heading</code></li>
        <li>Set <code>code</code> element to use <code>font-code</code></li>
        <li>Selectors <code>[data-w-palette=&quot;primary&quot;], .w-primary</code> to automatically apply a few palette
          related styles to their children:<ul>
            <li><code>background-color</code> will be set to the tinted color</li>
            <li><code>border-color</code> will be set to the <code>accent</code> color</li>
            <li><code>color</code> will be set to the related variant</li>
            <li>if the class is added to an <code>a</code> or <code>button</code> tag, the <code>:hover, :active</code>
              will change background to <code>tint-strong</code> and <code>tint-subtle</code></li>
          </ul>
        </li>
        <li>Previous selectors plus <code>.w-solid</code> will automatically apply:<ul>
            <li><code>background</code> will be set to <code>solid</code></li>
            <li><code>color</code> will be set to <code>solid-text</code></li>
            <li>when appropriate, the <code>:hover, :active</code> will change background to <code>solid-strong</code>
              and <code>solid-subtle</code> colors</li>
          </ul>
        </li>
      </ul>
      <p>You can disable styles had base elements by passing in <code>base: false</code> in the options object.
        You can also disable the class related styles by passing in <code>selectors: false</code> to the options object.
      </p>
      <pre><code class=\"lang-js\"><span class=\"hljs-keyword\">import</span> wt <span class=\"hljs-keyword\">from</span>
          <span class=\"hljs-string\">\"w-theme\"</span>

          wt.setBaseStyles({
          base: <span class=\"hljs-literal\">true</span>,
          selectors: <span class=\"hljs-literal\">false</span>
          })
        </code></pre>
      <p>Also, you can get access to just these base styles through the <code>getCSSBaseStyles</code> function, the same
        options apply.</p>
      <h1 id=\"theme-sampler\">Theme Sampler</h1>
      <p>We provide a web-component that can be placed anywhere in your application and it will inherit the currently
        available tokens.
        This is a great way to test out different themes or debug design token inheritance in real applications.</p>
      <pre><code class=\"lang-bash\">&lt;script src=<span
            class=\"hljs-string\">\"https://cdn.jsdelivr.net/gh/georgesboris/w-theme/w-theme-sampler.js\"</span>&gt;<span
            class=\"xml\"><span class=\"hljs-tag\">&lt;/<span class=\"hljs-name\">script</span>&gt;</span></span>

          &lt;div <span class=\"hljs-class\"><span class=\"hljs-keyword\">class</span></span>=<span
            class=\"hljs-string\">\"blue-theme\"</span>&gt;
          <span class=\"xml\"><span class=\"hljs-tag\">&lt;<span class=\"hljs-name\">w-theme-sampler</span>&gt;</span><span
              class=\"hljs-tag\">&lt;/<span class=\"hljs-name\">w-theme-sampler</span>&gt;</span>
            <span class=\"hljs-tag\">&lt;/<span class=\"hljs-name\">div</span>&gt;</span></span>

          &lt;div <span class=\"hljs-class\"><span class=\"hljs-keyword\">class</span></span>=<span
            class=\"hljs-string\">\"red-theme\"</span>&gt;
          <span class=\"xml\"><span class=\"hljs-tag\">&lt;<span class=\"hljs-name\">w-theme-sampler</span>&gt;</span><span
              class=\"hljs-tag\">&lt;/<span class=\"hljs-name\">w-theme-sampler</span>&gt;</span>
            <span class=\"hljs-tag\">&lt;/<span class=\"hljs-name\">div</span>&gt;</span></span>
        </code></pre>
      <blockquote>
        <p>[!WARNING]
          Work in progress… you can see a standalone version of the theme sampler on our examples folder.</p>
      </blockquote>
      <h1 id=\"theme-debugger\">Theme Debugger</h1>
      <p>We provide a drop-in script that can be used to debug your design tokens on live applications.
        This can be extremelly useful for debugging existing applications and visualizing design tokens live.</p>
      <blockquote>
        <p>[!WARNING]
          Work in progress… the example page showcases the development version of our debugger.</p>
      </blockquote>
      <h1 id=\"tailwind-plugin\">Tailwind Plugin</h1>
      <pre><code class=\"lang-bash\">npm <span class=\"hljs-selector-tag\">i</span> -D w-theme
        </code></pre>
      <p>Then set it up as a <a href=\"https://tailwindcss.com/docs/plugins\">tailwind plugin</a>.</p>
      <pre><code class=\"lang-js\"><span class=\"hljs-comment\">// tailwind.config.js</span>

          <span class=\"hljs-keyword\">module</span>.<span class=\"hljs-keyword\">exports</span> = {
          plugins: [
          require(<span class=\"hljs-string\">\"w-theme/tailwindcss\"</span>)
          ]
          }
        </code></pre>
      <p>Our tailwind plugin accepts the following options:</p>
      <pre><code class=\"lang-js\"><span class=\"hljs-keyword\">const</span> options = {
          // disable tailwind's default colors, spacing <span class=\"hljs-keyword\">and</span> border radius
          strict: <span class=\"hljs-literal\">false</span>,
          // disable tailwind's default spacing variables
          strictSpacing: <span class=\"hljs-literal\">false</span>,
          // disable the usage <span class=\"hljs-keyword\">of</span> non-text colors <span class=\"hljs-keyword\">as</span>
          text colors
          // (e.g. tint colors are <span class=\"hljs-keyword\">not</span> valid text colors)
          strictTextColors: <span class=\"hljs-literal\">true</span>,
          // add more color options to tailwind's color options
          extraColors: <span class=\"hljs-meta\">{...}</span>,
          // add base styles (e.g. body background color, text color, heading font families, etc.)
          baseStyles: <span class=\"hljs-literal\">true</span>,
          // add base class styles (e.g. .w-primary <span class=\"hljs-keyword\">and</span> .w-primary-solid)
          baseSelectors: <span class=\"hljs-literal\">true</span>
          }

          module.exports = {
          plugins: [
          require(<span class=\"hljs-string\">\"w-theme/tailwindcss\"</span>)(options)
          ]
          }
        </code></pre>
      <p>You can then use our variables as normal tailwind values like so:</p>
      <pre><code class=\"lang-h\"><span class=\"hljs-tag\">&lt;<span class=\"hljs-name\">button</span> <span
              class=\"hljs-attr\">class</span>=<span class=\"hljs-string\">\"px-md py-sm bg-solid bg-solid-text
              hover:bg-solid-strong active:bg-solid-subtle\"</span>&gt;</span>
          ...
          <span class=\"hljs-tag\">&lt;/<span class=\"hljs-name\">button</span>&gt;</span>
        </code></pre>
      <h2 id=\"related-libraries\">Related Libraries</h2>
      <h3 id=\"-elm-https-elm-lang-org-\"><a href=\"https://elm-lang.org\">Elm</a></h3>
      <ul>
        <li><a href=\"https://package.elm-lang.org/packages/georgesboris/elm-theme/latest/\">elm-theme</a> — A fully
          compliant w-theme library for Elm applications with support for automatically switching dark/light modes,
          defining and extending themes with type-safety and more.</li>
        <li><a href=\"https://package.elm-lang.org/packages/georgesboris/elm-widgets/latest/\">elm-widgets</a> — A library
          of UI elements themed through w-theme.</li>
        <li><a href=\"https://package.elm-lang.org/packages/georgesboris/elm-book/latest/\">elm-book</a> — A documentation
          library themed through w-theme.</li>
      </ul>
      <h3 id=\"-gleam-https-gleam-run-\"><a href=\"https://gleam.run\">Gleam</a></h3>
      <ul>
        <li><strong>TBD</strong> :detective:</li>
      </ul>
    ",
    ),
  ])
}
