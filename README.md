# PostCSS Sparrow Clamp Fallback

A PostCSS plugin that creates fallback of `clamp()` for you.

```css
/* Before transformations */
.foo {
  font-size: clamp(20px, 2vw, 40px);
}
```

```css
/* After transformations */
@media (width <= 1000px) {
  .foo{
   font-size: 20px; /*min*/
  }
}

.foo{
  font-size: 2vw;
}

@media (width >= 2000px) {
.foo{
   font-size: 40px; /*max*/
  }
}
```

## Why do I need this plugin?

`clamp()` is a very powerful tool for creating a responsive design.  Nevertheless, its support is limited at the moment. As of Sept 2020, this rule is only supported by [77% of all browsers](https://caniuse.com/?search=clamp()).

This plugin will help you transform `clamp()` with the combination of `min()` and `max()` or media queries for more browser support.

## Installation

This plugin require you to use [PostCSS Sparrow](https://www.npmjs.com/package/postcss-sparrow) for matching with selectors you want.

Download both `postcss-sparrow` and this plugin through NPM.

```shell

npm i postcss postcss-sparrow postcss-sparrow-clamp-fallback

```

Then import this plugin as the callback for [PostCSS Sparrow](https://www.npmjs.com/package/postcss-sparrow).

```javascript
//postcss.config.js
module.exports = {
  plugins: [
    //Other plugins...

    require('postcss-sparrow')({
      transformations: [
        {
          selectors: ['*'],
          inclusion: true,
          callbacks: [
            require('postcss-sparrow-clamp-fallback')({
              fallback: 'minmax'
            })
          ]
        }
      ]
    })
  ]
}
```

## API Reference

### `options.fallback` : String

Choose the way to fallback `clamp()`. Set it to `'minmax'` to fallback with the combination of `min()` and `max()`; set it to `'media'` to fallback with media queries.

This option is default to `'minmax'`.
