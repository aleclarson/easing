
assertType = require "assertType"
isType = require "isType"
Type = require "Type"

type = Type "Easing"

type.defineValues ->

  _cache: Object.create null

type.initInstance ->
  @set "linear", (t) -> t
  @set "quad", (t) -> t * t
  @set "out.quad", @out "quad"

type.defineGetters

  names: -> Object.keys @_cache

type.defineMethods

  set: (name, ease) ->
    assertType name, String
    assertType ease, Function

    if @_cache[name]
      throw Error "Easing named '#{name}' already exists!"

    @_cache[name] = ease
    return

  get: (name) ->
    assertType name, String
    ease = @_cache[name]
    return ease if ease
    throw Error "Easing named '#{name}' does not exist!"

  bezier: require "bezier"

  out: (ease) ->
    ease = @get ease if isType ease, String
    return (t) -> 1 - ease 1 - t

  inout: (ease) ->
    ease = @get ease if isType ease, String
    return (t) ->
      return ease(t * 2) / 2 if t < 0.5
      return 1 - ease((1 - t) * 2) / 2

  reverse: (ease) ->
    ease = @get ease if isType ease, String
    return (t) -> 1 - ease t

module.exports = type.construct()
