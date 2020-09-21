import {
  // createFallback,
  filterDeclByValue
} from './utilities/helper.js'

export default (config) => (decl) => {
  const options = {
    fallback: config.fallback
  }

  // console.log(decl)
  return filterDeclByValue(decl)(options)
  // return createFallback(options.fallback)
}
