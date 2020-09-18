const postcss = require('postcss')
const sparrow = require('postcss-sparrow')
const chai = require('chai')
const sinon = require('sinon')
const expect = chai.expect
const plugin = require('../dist/index.cjs.js')

describe('postcss-sparrow-clamp-fallback', function () {
  let css, beforeDeclCount

  beforeEach(function () {
    css = `
    body{
      padding: 5px;
    }

    a{
      letter-spacing: 20px;
      font-size: clamp(20px, 2vw, 40px);
    }`
  })

  describe('if clamp() is found', function () {
    describe('if fallback method is set to minmax', function () {
      it('should replace the clamp() with the combination of min() and max()', async function () {
        plugin({
          fallback: 'minmax'
        })()
        const result = await postcss([

        ])
          .process(css, {
            from: undefined
          })
      })
    })

    // describe('if fallback method is set to media-queries', function () {
    //   it('should replace the clamp() with media-queries', async function () {
    //     const result = await postcss([
    //
    //     ])
    //       .process(css, {
    //         from: undefined
    //       })
    //   })
    // })
  })
})
