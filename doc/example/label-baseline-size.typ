#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#set list(marker: [#box(stroke: red, height: 1em, width: 1em)])
#show: el.default-enum-list.with(
  size: (1.5em, auto, 2em),
  label-baseline: "center",
)
- #lorem(5)
  - - #lorem(5)
- #lorem(5)
