
# easing v3.1.1 ![stable](https://img.shields.io/badge/stability-stable-4EBA0F.svg?style=flat)

```coffee
Easing = require "easing"

Easing.linear
Easing.quad
Easing.pow 3
Easing.bezier 0, 0, 1, 1
Easing.elastic 0.8

# Modify the output of an easing function
Easing.flipXY easeFn
Easing.flipX easeFn
Easing.flipY easeFn
Easing.inout easeFn

# Composition scoping
easeOutQuad = Easing -> @flipXY @quad
```
