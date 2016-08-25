
# easing v2.0.0 ![stable](https://img.shields.io/badge/stability-stable-4EBA0F.svg?style=flat)

```coffee
Easing = require "easing"

# Get cached easing functions
ease = Easing.get "linear"
ease 0 # => 0
ease 1 # => 1

# Cache your own easing functions
Easing.set "custom", (t) -> Math.pow t, 2

Easing.names # => [ "linear", "quad", "quad.out", "custom" ]

# Comes with these easing modifiers
easeOut = Easing.out ease
easeIn = Easing.in ease
easeInOut = Easing.inout ease
easeReversed = Easing.reverse ease
```
