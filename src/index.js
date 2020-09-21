import {
  createFallback
} from './utilities/helper.js'

export default (config) => (decl) => {
  const options = {
    fallback: config.fallback
  }

  console.log(decl)
  return createFallback(options.fallback)
}
