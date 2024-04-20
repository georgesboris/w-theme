# w-theme

> A theme schema designed for intuitive use without sacrificing flexibility

## Color Palette

Every theme is built using a set of 6 colors.

- **Base** — used for most of the content, the main background, text colors, etc.
- **Primary** ­— used for content highlights with a contrasting color, sometimes called _"accent"_ color.
- **Secondary** — used as an alternative to the primary color, giving flexibility to your designs.
- **Success** — used for positive content. _e.g. success feedbacks, confirm buttons, …_
- **Warning** ­— used for cautionary content. _e.g. non critical warning messages_
- **Danger** — used for errors and destructive content. _e.g. failure feedbacks, delete buttons, …_
 
## Color Scale

- bg
- bg-soft
- tint-soft
- tint
- tint-strong
- detail-soft
- detail
- detail-strong
- solid-soft
- solid
- solid-strong
- text-soft
- text

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

