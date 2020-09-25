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
    }

    @media only screen and (max-width: 600px) {
  body {
    background-color: lightblue;
  }
}
    `
  })

  describe('if clamp() is found', function () {
    describe('if fallback method is set to minmax', function () {
      it('should replace the clamp() with the combination of min() and max()', async function () {
        const result = await postcss([
          sparrow({
            transformations: [
              {
                selectors: ['*'],
                inclusion: true,
                callbacks: [
                  plugin({
                    fallback: 'minmax'
                  })
                ]
              }
            ]
          }),
          sparrow({
            transformations: [
              {
                selectors: ['*'],
                inclusion: true,
                callbacks: [
                  require('postcss-sparrow-props-filter')({
                    props: ['background-color'],
                    inclusion: true,
                    callbacks: [
                      (decl) => {
                        console.log(decl)
                      }
                    ]
                  }),
                  require('postcss-sparrow-props-filter')({
                    props: ['font-size'],
                    inclusion: true,
                    callbacks: [
                      (decl) => {
                        console.log(decl)
                      },
                      (decl) => {
                        expect(decl.value).to.match(/^max/)
                        expect(decl.value).to.match(/min/)
                      }
                    ]
                  })
                ]
              }
            ]
          })
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
