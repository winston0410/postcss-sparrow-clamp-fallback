import {
  // createFallback,
  filterDeclByValue
} from './utilities/Helper.js'

export default (config) => (decl) => {
  const options = {
    fallback: config.fallback
  }

  // console.log('Callback running')
  return filterDeclByValue(decl)(options)
  // return createFallback(options.fallback)
}
