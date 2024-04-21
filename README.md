# w-theme

> A theme schema designed for consistency and flexibility with support for light and dark modes.


## Table of Contents

- [Design Tokens](#design-tokens)
  - [CSS Variables](#css-variables)
  - [Colors](#colors)
    - [Color Palette](#color-palette)
    - [Color Scale](#color-scale)
  - [Font Families](#font-families)
  - [Spacing](#spacing)
  - [Border Radius](border-radius)
- [Javascript API](#javascript-api)
  - [Using built-in colors](#using-built-in-colors)
  - [Generating color scales](#generating-color-scales)
  - [Defining custom color scales](#defining-custom-color-scales)
  - [Generating spacing and border radius values](#generating-spacing-and-border-radius-values)
- [Theme Sampler](#theme-sampler)
- [Theme Debugger](#theme-debugger)
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
  --w-base-bg: 255 255 255;
  --w-primary-text: 0 0 255;
  --w-spacing-xs: 0.1rem;
  --w-radius-xs: 0.1rem;
}
```

> [!Note]
> We use "color channels" on our CSS variable color instead of a defined color space. So we can:
> - Create transparent variations of any colors like this `rgb(--var(--w-base-bg) / 0.5)`
> - Be [tailwindcss compatible]() so people can use their colors using tailwind's builtin opacity functions `bg-primary/50`
>
> So, remember to always use the colors variables through a namespace function like `rgb(--var(--w-primary-solid))`

## Colors

We can safely say that colors are the star of the show of any theme.
Our theme specification is made of a *color palette of 6 colors* and each color is made of a *scale of 12 variations*.
This might seem like _a lot_ of available colors, but this was decided through a lot of real world experimentation and minimalistic color scales ended up relying on other factors such as opacity for achieving the flexibility needed for building rich UI's.
This ends up becoming a huge pain to maintain and opacity is _not_ an ideal way of mixing colors.
With this set of colors available, we're confident that you can build rich interfaces without opting for escape hatches of your design system.

### Color Palette
a.k.a "color variants"

Every theme is built using a palette of 6 colors.

- **Base** — used for most of the content, the main background, text colors, etc.
- **Primary** ­— used for content highlights with a contrasting color, sometimes called _"accent"_ color.
- **Secondary** — used as an alternative to the primary color, giving flexibility to your designs.
- **Success** — used for positive content. _e.g. success feedbacks, confirm buttons, …_
- **Warning** ­— used for cautionary content. _e.g. non critical warning messages_
- **Danger** — used for errors and destructive content. _e.g. failure feedbacks, delete buttons, …_
 
### Color Scale

Each color is defined using a scale with 12 steps.

#### Background

- **bg** — the main background of your ui
- **bg-subtle** — an alternate, slightly darker, color of your main background. useful for creating depth.

#### Tint

- **tint** — useful for subtle backgrounds of some UI elements.
- **tint-subtle** — subtler variation, useful for "pressed" states.
- **tint-strong** — stronger variation, useful for "hovered" states.

#### Detail

- **detail** — useful for dividers, borders and other small UI elements.
- **detail-subtle** — subtle variation, useful for "pressed" states.
- **detail-strong** — stronger variation, useful for "hovered" states.

#### Solid

- **solid** — useful for solid elements such as buttons.
- **solid-subtle** — subtle variation, useful for "pressed" states.
- **solid-strong** — stronger variation, useful for "hovered" states.
- **solid-text** — contrasting color ensuring legibility of text over solid backgrounds

#### Text

- **text** — the main text color of your application.
- **text-subtle** — subtler variation for secondary text.

Both **text colors** are guaranteed to be **accessible** over any **background** and **tint** colors.
**Detail** colors are not made for background usage, they should be used for single color elements.
**Solid** colors should use **solid-text** as it's text color for proper accessibility.

<details>
<summary>Our color scale was largely inspired by radix-colors, see the differences.</summary>

Radix Colors are built using a 1-12 scale with semantic meaning given through [documentation](https://www.radix-ui.com/colors).

- We prefer semantic names are used instead of their number based naming.
- We prefer consistency across the main color spaces, so our **tint**, **detail** and **solid** colors have the same tones available.
- We included the contrasting `solid-text` into our scale, instead of relying on [different implied values for some colors](https://www.radix-ui.com/colors/docs/palette-composition/understanding-the-scale#steps-910-solid-backgrounds).
- We 
- `bg-subtle` is _always_ darker than `bg`, while radix's 2nd color contrast differs between light and dark modes.
- `solid-text` is not an official color on the radix scale, it is supposed to be implied depending on the color used (most colors use white as contrast color but some hand-picked colors use a darker tone). We made it an official color so it is easier to build UI's without knowing the color that is being used.

</details>

## Font Families

> [!NOTE]
> Docs in progress…

- Heading
- Text
- Code

## Spacing

The most important thing about spacing variables is to use `rem` based values. This way your whole interface gets properly spaced when the user decides to increase their default font value for accessibility reasons.
Also, you can even play around with base font values across different pages of your applications and get great looking results! For instance, maybe your marketing website would benefit from larger fonts and buttons, you can make that happen by just adjusting the `font-size` attribute of your `html` element. :sparkles:

The scale chosen here was deeply inspired by [TailwindCSS](https://tailwindcss.com/docs/customizing-spacing).
The idea of using naming based values instead of number based is that you can even integrate w-theme with tailwind and still be able to use both scales interchangeably (e.g `p-4 m-sm`)

- xs
- sm
- md
- lg
- xl
- 2xl
- 3xl

## Border Radius

Just as spacing values, we advise the usage of `rem` based values so that your border radius will scale consistently.

- xs
- sm
- md
- lg
- xl
- 2xl
- 3xl

The default border radius we provide are usually 50% of the size of the related spacing variable, that way you can usually get good results when pairing them.

```
.button {
  padding: var(--w-spacing-md);
  border-radius: var(--w-radius-md);  
}
```

The scale chosen here was deeply inspired by [TailwindCSS](https://tailwindcss.com/docs/border-radius).
In fact, you can integrate our scale into your tailwind theme with no surprises! Just be aware of one small translation:

```css
.rounded-sm  /* --w-radius-xs (our "xs" becomes tailwind's "sm") */
.rounded     /* --w-radius-sm (our "sm" becomes tailwind's default) */
.rounded-md  /* --w-radius-md (things are named equally starting from here) */
...
```


# Javascript API

Use our provided API to quickly declare themes and their related CSS.

```
npm i -D w-theme
```

> [!NOTE]
> You should mostly use our Javascript API for code-generation (css/js/html).
> This library is not optimized to be used as part of your production application.
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

> [!WARNING]
> Work in progress…

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

#### Generating spacing and border radius values

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

#### Base styles

When using our `setGlobalTheme` function you also get the benefit of a few utilities like:

- Set most elements to use `font-text` as font family
- Set `h1, h2, h3, h4, h5, h6` elements use `font-heading`
- Set `code` element use 
- We set selectors such as `[data-w-palette="primary"], .w-primary` to automatically apply a few palette related styles to their children.
  - Background will be set to the tinted color of the related palette
  - `border-color` will be set to the `detail` color
  - Background and border colors will be set to their related variant
  - Text colors will be set to the related variant


# Theme Sampler

We provide a web-component that can be placed anywhere in your application and it will inherit the currently available tokens.
This is a great way to test out different themes or debug design token inheritance in real applications.

> [!WARNING]
> Work in progress…

# Theme Debugger

We provide a drop-in script that can be used to debug your design tokens on live applications.
This can be extremelly useful for debugging existing applications and visualizing design tokens live.

> [!WARNING]
> Work in progress…


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

- [elm-theme](https://package.elm-lang.org/packages/georgesboris/elm-theme/latest/) — A fully compliant w-theme library from Elm applications with support for automatically switching dark/light modes.
- [elm-widgets](https://package.elm-lang.org/packages/georgesboris/elm-widgets/latest/) — A library of UI elements themed through w-theme.
- [elm-book](https://package.elm-lang.org/packages/georgesboris/elm-book/latest/) — A documentation library themed through w-theme.

### Gleam

- **TBD** :detective:

