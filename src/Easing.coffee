
{ isType, assert, assertType } = require "type-utils"

NamedFunction = require "NamedFunction"
define = require "define"

module.exports =
Easing = NamedFunction "Easing", (name) ->
  assertType name, String
  ease = Easing.cache[name]
  assert ease, "Easing named '#{name}' does not exist!"
  unless ease.value
    ease.value = ease.init()
    ease.init = null
  return ease.value

define Easing,

  out: (ease) ->
    ease = Easing ease if isType ease, String
    return (t) -> 1 - ease 1 - t

  inout: (ease) ->
    ease = Easing ease if isType ease, String
    return (t) ->
      return ease(t * 2) / 2 if t < 0.5
      return 1 - ease((1 - t) * 2) / 2

  flipY: (ease) ->
    ease = Easing ease if isType ease, String
    return (t) -> 1 - ease t

  bezier: require "bezier"

  cache: value: Object.create null

  register: (name, ease) ->
    assert not Easing.cache[name], "Easing named '#{name}' already exists!"
    Easing.cache[name] = ease
    return

Easing.register "linear", value: (t) -> t
Easing.register "quad", value: (t) -> t * t
Easing.register "out.quad", init: -> Easing.out "quad"
