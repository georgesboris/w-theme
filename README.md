# w-theme

> A theme schema designed for intuitive use without sacrificing flexibility

## Color Palette

Every theme is built using a palette of 6 colors.

- **Base** — used for most of the content, the main background, text colors, etc.
- **Primary** ­— used for content highlights with a contrasting color, sometimes called _"accent"_ color.
- **Secondary** — used as an alternative to the primary color, giving flexibility to your designs.
- **Success** — used for positive content. _e.g. success feedbacks, confirm buttons, …_
- **Warning** ­— used for cautionary content. _e.g. non critical warning messages_
- **Danger** — used for errors and destructive content. _e.g. failure feedbacks, delete buttons, …_
 
## Color Scale

Each color is defined using a scale with 12 steps.

- bg
- bg-subtle
- tint-subtle
- tint
- tint-strong
- detail-subtle
- detail
- detail-strong
- solid-subtle
- solid
- solid-strong
- solid-text
- text-subtle
- text

This scale is largely inspired by [radix-colors](https://radix-ui.com/colors), the differences being:

- semantic names are used instead of their number based naming.
- `bg-subtle` is _always_ darker than `bg`, while radix's 2nd color contrast differs between light and dark mode.
- `solid-text` is not an official color on the radix scale, it is supposed to be implied depending on the color used (most colors use white as contrast color but some hand-picked colors use a darker tone). We made it an official color so it is easier to build UI's without knowing the color that is being used.

In fact, you can pass the CSS output of [radix's scale builder](#) directly to a [helper script](#) we have available.
We're currently working on a theme builder that will make this process easier, without relying on anything radix related.

## Font Families

- Heading
- Text
- Code

## Border Radius

- xs
- sm
- md
- lg
- xl
- 2xl
- 3xl

## Spacing

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

