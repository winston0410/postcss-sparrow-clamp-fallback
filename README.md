# PostCSS Sparrow Clamp Fallback

[![Known Vulnerabilities](https://snyk.io/test/github/winston0410/postcss-sparrow-clamp-fallback/badge.svg?targetFile=package.json)](https://snyk.io/test/github/winston0410/postcss-sparrow-clamp-fallback?targetFile=package.json) [![Test Coverage](https://api.codeclimate.com/v1/badges/197685e0ce4442a09dc5/test_coverage)](https://codeclimate.com/github/winston0410/postcss-sparrow-clamp-fallback/test_coverage) [![Codacy Badge](https://app.codacy.com/project/badge/Grade/3c9e4b7149f040199bff83165f61ac17)](https://www.codacy.com/manual/winston0410/postcss-sparrow-clamp-fallback/dashboard?utm_source=github.com&utm_medium=referral&utm_content=winston0410/postcss-sparrow-clamp-fallback&utm_campaign=Badge_Grade) 

<!-- [![Maintainability](https://api.codeclimate.com/v1/badges/197685e0ce4442a09dc5/maintainability)](https://codeclimate.com/github/winston0410/postcss-sparrow-clamp-fallback/maintainability) -->

 A PostCSS plugin that creates fallback of `clamp()` for you.

```css
/* Before transformations */
.foo {
  font-size: clamp(20px, 2vw, 40px);
}
```

```css
/* After transformations */
/* If you set fallback: "media" */
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

```css
/* After transformations */
/* If you set fallback: "minmax" */
.foo {
  font-size: max(20px, min(2vw, 40px));
}
```

## Why do I need this plugin?

`clamp()` is a very powerful tool for creating a responsive design. Nevertheless, its support is limited at the moment. As of Sept 2020, this rule is only supported by [77% of all browsers](https://caniuse.com/?search=clamp()).

This plugin will help you transform `clamp()` with the combination of `min()` and `max()` or media queries for more browser support.

### Browser support for various fallback

- Falling back with `min()` and `max()` will give you [87.79% browser support](https://caniuse.com/?search=min()).

- Falling back with `media queries` will give you [98.67% browser support, which would also support up to IE 9](https://caniuse.com/?search=media%20queries)

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
