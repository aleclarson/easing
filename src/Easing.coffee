
NamedFunction = require "NamedFunction"
isType = require "isType"

Easing = NamedFunction "Easing", (builder) ->
  ease = builder.call Easing
  return ease if isType ease, Function
  throw TypeError "Expected a Function to be returned!"

Object.assign Easing,

  bezier: require "bezier"

  linear: (t) -> t

  quad: (t) -> t * t

  pow: (e) -> (t) -> Math.pow t, e

  flipXY: (ease) -> (t) -> 1 - ease 1 - t

  flipX: (ease) -> (t) -> ease 1 - t

  flipY: (ease) -> (t) -> 1 - ease t

  elastic: (stretch, dt = 1) -> (t) ->
    stretch * t * dt / (dt + t * stretch)

  inout: (ease) -> (t) ->
    if t < 0.5
    then 0.5 * ease 2 * t
    else 1 - 0.5 * ease 2 * (1 - t)

Object.assign Easing,

  outQuad: Easing -> @flipXY @quad

  outPow: (e) -> Easing.flipXY Easing.pow e

module.exports = Easing
