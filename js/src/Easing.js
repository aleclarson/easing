var Easing, NamedFunction, assert, assertType, define, isType;

NamedFunction = require("NamedFunction");

assertType = require("assertType");

isType = require("isType");

assert = require("assert");

define = require("define");

module.exports = Easing = NamedFunction("Easing", function(name) {
  var ease;
  assertType(name, String);
  ease = Easing.cache[name];
  assert(ease, "Easing named '" + name + "' does not exist!");
  if (!ease.value) {
    ease.value = ease.init();
    ease.init = null;
  }
  return ease.value;
});

define(Easing, {
  out: function(ease) {
    if (isType(ease, String)) {
      ease = Easing(ease);
    }
    return function(t) {
      return 1 - ease(1 - t);
    };
  },
  inout: function(ease) {
    if (isType(ease, String)) {
      ease = Easing(ease);
    }
    return function(t) {
      if (t < 0.5) {
        return ease(t * 2) / 2;
      }
      return 1 - ease((1 - t) * 2) / 2;
    };
  },
  flipY: function(ease) {
    if (isType(ease, String)) {
      ease = Easing(ease);
    }
    return function(t) {
      return 1 - ease(t);
    };
  },
  bezier: require("bezier"),
  cache: {
    value: Object.create(null)
  },
  register: function(name, ease) {
    assert(!Easing.cache[name], "Easing named '" + name + "' already exists!");
    Easing.cache[name] = ease;
  }
});

Easing.register("linear", {
  value: function(t) {
    return t;
  }
});

Easing.register("quad", {
  value: function(t) {
    return t * t;
  }
});

Easing.register("out.quad", {
  init: function() {
    return Easing.out("quad");
  }
});

//# sourceMappingURL=../../map/src/Easing.map
