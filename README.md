# w-theme

> A theme schema designed for intuitive use without sacrificing flexibility

- [Generating themes](generating-themes)
- [Design Tokens](design-tokens)
  - [CSS Variables](css-variables)
  - [Color Palette](color-palette)
  - [Color Scale](color-scale)
  - [Font Families](font-families)
  - [Spacing](spacing)
  - [Rounded Corners](rounded-corners)
- [Tailwind Plugin]()
- [Related Libraries]()
  - [Elm]
    - [elm-theme]
    - [elm-widgets]
    - [elm-book]
  - [Gleam]
    - [lustre_ui]

# Creating a theme

> [!NOTE]
> - Using the javascript api to create CSS strings
> - Generating color scales through color sample
> - Built-in themes and colors

# Design Tokens

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

- bg
- bg-subtle

#### Tint

- tint
- tint-subtle
- tint-strong

#### Detail

- detail-subtle
- detail
- detail-strong

#### Solid

- solid-subtle
- solid
- solid-strong
- solid-text

#### Text

- text
- text-subtle

> [!NOTE]
> This color scale schema is largely inspired by [radix-colors](https://radix-ui.com/colors), the differences being:
> - semantic names are used instead of their number based naming.
> - `bg-subtle` is _always_ darker than `bg`, while radix's 2nd color contrast differs between light and dark modes.
> - `solid-text` is not an official color on the radix scale, it is supposed to be implied depending on the color used (most colors use white as contrast color but some hand-picked colors use a darker tone). We made it an official color so it is easier to build UI's without knowing the color that is being used.
>
> In fact, you can pass the CSS output of [radix's scale builder](#) directly to a [helper script](#) we have available.
> We're currently working on a theme builder that will make this process easier, without relying on anything radix related.

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
## Rounded Corners
a.k.a. "border radius"

- xs
- sm
- md
- lg
- xl
- 2xl
- 3xl

# Tailwind Integration

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


## Elm

- elm-theme

