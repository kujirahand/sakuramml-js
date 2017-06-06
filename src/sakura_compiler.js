const Parser = require('./skr_parser')

export class Eevent {
  constructor (time, len, status, v1, v2) {
    this.time = time
    this.len = len
    this.status = status
    this.v1 = v1
    this.v2 = v2
  }
}

export class Track {
  constructor () {
    this.no = 0
    this.ch = 0
    this.events = []
  }
}

export default class SakuraMML {
  constructor () {
    this.nodes = null
    this.index = 0
    this.tracks = [new Track()]
  }
  compile (src) {
    this.parse(src)
    this.run()
    return this
  }
  eof () {
    return (this.index >= this.nodes.length)
  }
  parse (src) {
    this.nodes = Parser.parse()
  }
  run () {
    while (!this.eof()) {
      const n = this.nodes[this.index]
      if (!n) {
        this.index++
        continue
      }
      switch (n.type) {
        case 'nop':
          break
      }
      this.index++
    }
  }
}
