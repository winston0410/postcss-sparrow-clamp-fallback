import {
  identity,
  createFallback
} from './purescript/Helper/index.js'

export default (config) => (decl) => {
  const options = {
    fallback: config.fallback
  }

  return createFallback(options.fallback)
}
