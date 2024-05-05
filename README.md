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
  - [Border Radius](#border-radius)
- [Javascript API](#javascript-api)
  - [Using built-in colors](#using-built-in-colors)
  - [Defining custom color scales](#defining-custom-color-scales)
  - [Generating color scales](#generating-color-scales)
  - [Generating spacing and border radius values](#generating-spacing-and-border-radius-values)
  - [Base Styles](#base-styles)
- [Theme Sampler](#theme-sampler)
- [Theme Debugger](#theme-debugger)
- [Tailwind Plugin](#tailwind-plugin)
- [Related Libraries](#related-libraries)
  - [Elm](#elm)
  - [Gleam](#gleam)
- [Next Steps](#next-steps)



# Design Tokens

## CSS Variables

While `w-theme` is just a schema, there is tooling and libraries that rely on a specific implementation of this schema through CSS variables.


```css
:root {
  --w-font-heading: sans-serif; 
  --w-base-bg: 255 255 255;
  --w-primary-text: 0 0 255;
  --w-spacing-xs: 0.1rem;
  --w-radius-xs: 0.1rem;
}
```

<details>
  <summary>This is a sample of the schema CSS variables, you can see a complete example here.</summary>

```css
:root {

  /* defining color schema is important for controlling native browser widgets */

  color-schema: light;

  /* the id variable is used for w-theme debugger */

  --w-id: "my theme";

  /* Font Family Variables */
  --w-font-heading: serif; 
  --w-font-text: sans-serif; 
  --w-font-code: monospace; 

  /* Spacing and Border Radius variables follow a "size scale" that is tailwind compatible */

  --w-spacing-xs: 0.25rem;
  --w-spacing-sm: 0.5rem;
  --w-spacing-md: 0.75rem;
  --w-spacing-lg: 1rem;
  --w-spacing-xl: 1.5rem;
  --w-spacing-2xl: 2.5rem;
  --w-spacing-3xl: 4rem;

  --w-radius-xs: 0.125rem;
  --w-radius-sm: 0.25rem;
  --w-radius-md: 0.375rem;
  --w-radius-lg: 0.5rem;
  --w-radius-xl: 0.75rem;
  --w-radius-2xl: 1rem;
  --w-radius-3xl: 1.5rem;

  /* Each variant of our palette follows a "color scale" that is inspired by radix-ui */

  --w-base-bg: 252 252 253;
  --w-base-bg-subtle: 249 249 251;
  --w-base-tint: 232 232 236;
  --w-base-tint-subtle: 240 240 243;
  --w-base-tint-strong: 224 225 230;
  --w-base-accent: 205 206 214;
  --w-base-accent-subtle: 217 217 224;
  --w-base-accent-strong: 185 187 198;
  --w-base-solid: 139 141 152;
  --w-base-solid-subtle: 150 152 162;
  --w-base-solid-strong: 128 131 141;
  --w-base-solid-text: 255 255 255;
  --w-base-text-subtle: 96 100 108;
  --w-base-text: 28 32 36;

  --w-primary-bg: 251 253 255;
  --w-primary-bg-subtle: 244 250 255;
  --w-primary-tint: 213 239 255;
  --w-primary-tint-subtle: 230 244 254;
  --w-primary-tint-strong: 194 229 255;
  --w-primary-accent: 142 200 246;
  --w-primary-accent-subtle: 172 216 252;
  --w-primary-accent-strong: 94 177 239;
  --w-primary-solid: 0 144 255;
  --w-primary-solid-subtle: 5 148 260;
  --w-primary-solid-strong: 5 136 240;
  --w-primary-solid-text: 255 255 255;
  --w-primary-text-subtle: 13 116 206;
  --w-primary-text: 17 50 100;

  --w-secondary-bg: 255 252 254;
  --w-secondary-bg-subtle: 254 247 251;
  --w-secondary-tint: 251 220 239;
  --w-secondary-tint-subtle: 254 233 245;
  --w-secondary-tint-strong: 246 206 231;
  --w-secondary-accent: 231 172 208;
  --w-secondary-accent-subtle: 239 191 221;
  --w-secondary-accent-strong: 221 147 194;
  --w-secondary-solid: 214 64 159;
  --w-secondary-solid-subtle: 220 72 166;
  --w-secondary-solid-strong: 207 56 151;
  --w-secondary-solid-text: 255 255 255;
  --w-secondary-text-subtle: 194 41 138;
  --w-secondary-text: 101 18 73;

  --w-success-bg: 251 254 252;
  --w-success-bg-subtle: 244 251 246;
  --w-success-tint: 214 241 223;
  --w-success-tint-subtle: 230 246 235;
  --w-success-tint-strong: 196 232 209;
  --w-success-accent: 142 206 170;
  --w-success-accent-subtle: 173 221 192;
  --w-success-accent-strong: 91 185 139;
  --w-success-solid: 48 164 108;
  --w-success-solid-subtle: 53 173 115;
  --w-success-solid-strong: 43 154 102;
  --w-success-solid-text: 255 255 255;
  --w-success-text-subtle: 33 131 88;
  --w-success-text: 25 59 45;

  --w-warning-bg: 253 253 249;
  --w-warning-bg-subtle: 254 252 233;
  --w-warning-tint: 255 243 148;
  --w-warning-tint-subtle: 255 250 184;
  --w-warning-tint-strong: 255 231 112;
  --w-warning-accent: 228 199 103;
  --w-warning-accent-subtle: 243 215 104;
  --w-warning-accent-strong: 213 174 57;
  --w-warning-solid: 255 230 41;
  --w-warning-solid-subtle: 255 234 82;
  --w-warning-solid-strong: 255 220 0;
  --w-warning-solid-text: 71 59 31;
  --w-warning-text-subtle: 158 108 0;
  --w-warning-text: 71 59 31;

  --w-danger-bg: 255 252 252;
  --w-danger-bg-subtle: 255 247 247;
  --w-danger-tint: 255 219 220;
  --w-danger-tint-subtle: 254 235 236;
  --w-danger-tint-strong: 255 205 206;
  --w-danger-accent: 244 169 170;
  --w-danger-accent-subtle: 253 189 190;
  --w-danger-accent-strong: 235 142 144;
  --w-danger-solid: 229 72 77;
  --w-danger-solid-subtle: 236 83 88;
  --w-danger-solid-strong: 220 62 66;
  --w-danger-solid-text: 255 255 255;
  --w-danger-text-subtle: 206 44 49;
  --w-danger-text: 100 23 35;
}
```

</details>


## Colors

We can safely say that colors are the star of the show of any theme.
Our theme specification is made of a *color palette of 6 colors* and each color is made of a *scale of 12 variations*.
This might seem like _a lot_ of available colors, but this was decided through a lot of real world experimentation and minimalistic color scales ended up relying on other factors such as opacity for achieving the flexibility needed for building rich UI's.
This ends up becoming a huge pain to maintain and opacity is _not_ an ideal way of mixing colors.
With this set of colors available, we're confident that you can build rich interfaces without opting for escape hatches of your design system.

### Color Palette
> a.k.a "color variants"

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

#### Accent

- **accent** — useful for dividers, borders and other small UI elements.
- **accent-subtle** — subtle variation, useful for "pressed" states.
- **accent-strong** — stronger variation, useful for "hovered" states.

#### Solid

- **solid** — useful for solid elements such as buttons.
- **solid-subtle** — subtle variation, useful for "pressed" states.
- **solid-strong** — stronger variation, useful for "hovered" states.
- **solid-text** — contrasting color ensuring legibility of text over solid backgrounds

#### Text

- **text** — the main text color of your application.
- **text-subtle** — subtler variation for secondary text.

Both **text colors** are guaranteed to be **accessible** over any **background** and **tint** colors.
**Accent** colors are not made for background usage, they should be used for single color elements.
**Solid** colors should use **solid-text** as it's text color for proper accessibility.

> [!Note]
> We use "color channels" on our CSS variable colors instead of a defined color space. So we can:
> - Create transparent variations of any colors like this `rgb(--var(--w-base-bg) / 0.5)`
> - Be [tailwindcss compatible]() so you can use their colors using tailwind's opacity functions `bg-primary/50`
>
> So, remember to always use the colors variables like
> - ```rgb(--var(--w-primary-solid))```
> - Or ```rgb(--var(--w-primary-solid) / 0.5)```

<details>
<summary>Our color scale was largely inspired by radix-colors, see the differences.</summary>

Radix Colors are built using a 1-12 scale with semantic meaning given through [documentation](https://www.radix-ui.com/colors).

- We prefer semantic names are used instead of their number based naming.
- We prefer consistency across the main color spaces, so our **tint**, **accent** and **solid** colors have the same tones available.
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

The quickest way to create a theme is to use one of our [built-in colors](https://github.com/georgesboris/w-theme/tree/main/src/w/colors.js).

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
wt.setTheme(theme);

// grab theme CSS content and apply it to other elements (e.g. through a class)
wt.getCSSVariables(theme);
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
  borderRadius: {
    xs: "0.2rem",
    sm: "0.3rem",
    ...
  }
})

const otherTheme = wt.theme({
  spacingScale: 1.2,
  borderRadiusScale: 0.2
})
```

#### Base styles

When using our `setTheme` function you also get the benefit of a few utilities like:

- Set most elements to use `font-text` as font family
- Set `h1, h2, h3, h4, h5, h6` elements use `font-heading`
- Set `code` element use 
- Selectors `[data-w-palette="primary"], .w-primary` to automatically apply a few palette related styles to their children:
  - `background-color` will be set to the tinted color
  - `border-color` will be set to the `accent` color
  - `color` will be set to the related variant
  -  `:hover, :active` will change background to strong and subtle
- Previous selectors plus `.w-solid` will automatically apply:
  - `background` will be set to `solid`
  - `color` will be set to `solid-text`
  - `:hover, :active` will change background to strong and subtle

You can disable all or some of these base styles by passing in a secondary object to the `setTheme` function:

```js
import wt from "w-theme"

wt.setTheme(myTheme, {
  baseStyles: true,
  baseSelectors: false
})
```

Also, you can get access to just these base styles through the `getCSSBaseStyles` function.

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

> [!WARNING]
> Work in progress…

## Related Libraries

### [Elm](https://elm-lang.org)

- [elm-theme](https://package.elm-lang.org/packages/georgesboris/elm-theme/latest/) — A fully compliant w-theme library for Elm applications with support for automatically switching dark/light modes, defining and extending themes with type-safety and more.
- [elm-widgets](https://package.elm-lang.org/packages/georgesboris/elm-widgets/latest/) — A library of UI elements themed through w-theme.
- [elm-book](https://package.elm-lang.org/packages/georgesboris/elm-book/latest/) — A documentation library themed through w-theme.

### [Gleam](https://gleam.run)

- **TBD** :detective:

## Next Steps

- [ ] Publish on NPM
  - Needed to properly test tailwind integration
- [ ] Finalize our theme debugger
  - Could use some love and right now it is not packaged as a web component, it is manually added to our example project.
- [ ] Finalize our theme sampler
  - The idea here is to package the current "example" folder so all that markup is created through the theme sampler
- [ ] Generating colors
  - We currently have scripts that generate colors through radix's colors and also through radix's custom CSS export
  - The idea is to vendor that algorithm, add our small changes to the output and have it be accessed through our JS API

