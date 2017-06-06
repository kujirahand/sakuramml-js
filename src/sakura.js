const Compiler = require('./sakura_compiler')

export function sakuraCompileToObj (src) {
  const skr = new Compiler()
  return skr.compile(src)
}
