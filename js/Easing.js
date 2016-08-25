var Type, assertType, isType, type;

assertType = require("assertType");

isType = require("isType");

Type = require("Type");

type = Type("Easing");

type.defineValues(function() {
  return {
    _cache: Object.create(null)
  };
});

type.initInstance(function() {
  this.set("linear", function(t) {
    return t;
  });
  this.set("quad", function(t) {
    return t * t;
  });
  return this.set("out.quad", this.out("quad"));
});

type.defineGetters({
  names: function() {
    return Object.keys(this._cache);
  }
});

type.defineMethods({
  set: function(name, ease) {
    assertType(name, String);
    assertType(ease, Function);
    if (this._cache[name]) {
      throw Error("Easing named '" + name + "' already exists!");
    }
    this._cache[name] = ease;
  },
  get: function(name) {
    var ease;
    assertType(name, String);
    ease = this._cache[name];
    if (ease) {
      return ease;
    }
    throw Error("Easing named '" + name + "' does not exist!");
  },
  bezier: require("bezier"),
  out: function(ease) {
    if (isType(ease, String)) {
      ease = this.get(ease);
    }
    return function(t) {
      return 1 - ease(1 - t);
    };
  },
  inout: function(ease) {
    if (isType(ease, String)) {
      ease = this.get(ease);
    }
    return function(t) {
      if (t < 0.5) {
        return ease(t * 2) / 2;
      }
      return 1 - ease((1 - t) * 2) / 2;
    };
  },
  reverse: function(ease) {
    if (isType(ease, String)) {
      ease = this.get(ease);
    }
    return function(t) {
      return 1 - ease(t);
    };
  }
});

module.exports = type.construct();

//# sourceMappingURL=map/Easing.map
