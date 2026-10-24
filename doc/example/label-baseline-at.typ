#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#let cap-L = text(size: 3em)[L]
#show: el.default-enum-list.with(
  label-baseline: (at: horizon, relative-to: (cap-L, "center")),
  size: (2em, auto),
  label-format: (stroke: red),
  fill: (red, auto),
)
- #cap-L #lorem(2)
