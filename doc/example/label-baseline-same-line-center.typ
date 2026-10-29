#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#set list(marker: [#context box(stroke: text.fill, height: 1.2em, width: 1.2em)])
#show: el.default-enum-list.with(
  size: (1.5em, auto, 1.5em),
  fill: (red, blue, red),
  label-baseline: (same-line-style: "center"),
)
- #lorem(5)
  - - #lorem(10)
