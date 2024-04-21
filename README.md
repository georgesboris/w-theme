# w-theme

> A theme schema designed for intuitive use without sacrificing flexibility



## Table of Contents

- [Design Tokens](#design-tokens)
  - [CSS Variables](#css-variables)
  - [Color Palette](#color-palette)
  - [Color Scale](#color-scale)
  - [Font Families](#font-families)
  - [Spacing](#spacing)
  - [Border Radius](border-radius)
- [Javascript API](#javascript-api)
  - [Using built-in colors](#using-built-in-colors)
  - [Generating color scales](#generating-color-scales)
  - [Defining custom color scales](#defining-custom-color-scales)
  - [Generating spacings and border radius](#generating-spacings-and-border-radius)
- [Tailwind Plugin](#tailwind-plugin)
- [Related Libraries](#related-libraries)
  - [Elm](#elm)
  - [Gleam](#gleam)



# Design Tokens

## CSS Variables

While `w-theme` is just a schema, there is tooling and libraries that rely on a specific implementation of this schema through CSS variables.

This is a sample of the schema CSS variables, you can see a complete example [here](#TODO).

```css
:root {
  --w-font-heading: sans-serif; 
  --w-base-bg: white;
  --w-primary-text: blue;
  --w-spacing-xs: 0.1rem;
  --w-radius-xs: 0.1rem;
}
```


## Color Palette
a.k.a "color variants"

Every theme is built using a palette of 6 colors.

- **Base** — used for most of the content, the main background, text colors, etc.
- **Primary** ­— used for content highlights with a contrasting color, sometimes called _"accent"_ color.
- **Secondary** — used as an alternative to the primary color, giving flexibility to your designs.
- **Success** — used for positive content. _e.g. success feedbacks, confirm buttons, …_
- **Warning** ­— used for cautionary content. _e.g. non critical warning messages_
- **Danger** — used for errors and destructive content. _e.g. failure feedbacks, delete buttons, …_
 
## Color Scale

Each color is defined using a scale with 12 steps.

#### Background

- **bg** — the main background of your ui
- **bg-subtle** — an alternate, slightly darker, color of your main background. useful for creating depth.

#### Tint

- **tint** — the base tinted color.
- **tint-subtle** — subtler variation, useful for "pressed" states.
- **tint-strong** — stronger variation, useful for "hovered" states.

#### Detail

- **detail** — subtler variation, useful for "pressed" states.
- **detail-subtle** — 
- **detail-strong** — stronger variation, useful for "hovered" states.

#### Solid

- **solid** — ...
- **solid-subtle** — ...
- **solid-strong** — ...
- **solid-text** — ...

#### Text

- **text** — ...
- **text-subtle** — ...

<details>
<summary>Our color scale was largely inspired by [radix-colors](https://radix-ui.com/colors), see the differences</summary>
- semantic names are used instead of their number based naming.
- `bg-subtle` is _always_ darker than `bg`, while radix's 2nd color contrast differs between light and dark modes.
- `solid-text` is not an official color on the radix scale, it is supposed to be implied depending on the color used (most colors use white as contrast color but some hand-picked colors use a darker tone). We made it an official color so it is easier to build UI's without knowing the color that is being used.
</details>

## Font Families

- Heading
- Text
- Code

## Spacing

- xs
- sm
- md
- lg
- xl
- 2xl
- 3xl

## Border Radius

- xs
- sm
- md
- lg
- xl
- 2xl
- 3xl



# Javascript API

Use our provided API to quickly declare themes and their related CSS.

```
npm i -D w-theme
```

> [!NOTE]
> You should mostly use our Javascript API for code-generation (css/js/html).
> It is not optimized to be used as part of your production application.
> However, you're free to use it on the browser for theme exploration sandboxes, etc.


#### Using built-in colors

The quickest way to create a theme is to use one of our [built-in colors](https://github.com/georgesboris/w-theme/tree/main/colors/light).

```js
import wt from "w-theme"

const theme = wt.theme({
  base: "slate",
  primary: "cyan",
  secondary: "plum",
  fontFamilies: {
    heading: "Papyrus"
  }
})

// set theme on the body of your document
wt.setGlobalTheme(theme);

// grab theme CSS content and create custom 
wt.getCSSVariables(theme);
```

#### Generating color scales

> [!CAUTION]
> Generating colors is still under development.

You can pass in custom values and new color scales will be generated from theme.
Any format recognizable by [color.js](https://colorjs.io/) can be used.

```js
import wt from "w-theme"

const theme = wt.theme({
  primary: "#0A4",
  secondary: "rgb(0, 200, 100)"
})
```

#### Defining custom color scales

You can also bypass our colors completely and pass in your custom color scale.

```js
import wt from "w-theme"

const theme = wt.theme({
  primary: {
    bg: "#fff"
    "bg-subtle": "#fafafa",
    ...
  },
})
```

#### Generating spacings and border radius

Just as colors, you can pass in both a complete set of values to your spacings and rounded colors.
However, you can also pass in a scale value that will be used to auto-generate all other values.

```js
import wt from "w-theme"

const theme = wt.theme({
  spacing: {
    xs: "0.1rem",
    sm: "0.125rem",
    ...
  },
  radius: {
    xs: "0.2rem",
    sm: "0.3rem",
    ...
  }
})

const otherTheme = wt.theme({
  spacingScale: 1.2,
  radiusScale: 0.2
})
```

# Tailwind Plugin

```bash
npm i -D w-theme
```

Then set it up as a [tailwind plugin](https://tailwindcss.com/docs/plugins).

```js
// tailwind.config.js

module.exports = {
  plugins: [
    require("w-theme/tailwindcss")
  ]
}
```


## Related Libraries

### Elm

- [elm-theme](https://package.elm-lang.org/packages/georgesboris/elm-theme/latest/) — Quickly create themes and propagate them to parts of your application.
- [elm-widgets](https://package.elm-lang.org/packages/georgesboris/elm-widgets/latest/) — A library of UI elements themed through w-theme.
- [elm-book](https://package.elm-lang.org/packages/georgesboris/elm-book/latest/) — A documentation library themed through w-theme.

### Gleam

- **TBD** :detective:

