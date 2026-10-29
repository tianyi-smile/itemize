#import "@preview/layout-ltd:0.1.0": *
#show: layout-limiter.with(max-iterations: 3)

#set page(height: auto, margin: 15pt, width: 12cm)

#import "../../lib.typ" as el
#let test = [
  + #el.item([$vec(a, b, c)$]) #lorem(10)
]
*Impact First Line*
#table(
  columns: (1fr, 1fr),
  table.header([*impact-first-line: false*], [*impact-first-line: true*]),
  [
    #show: el.default-enum-list
    #test
  ],
  [
    #show: el.default-enum-list.with(label-baseline: (impact-first-line: true))
    #test
  ],
)
#set list(marker: [#circle(width: 1em, fill: red)])
#show: el.default-enum-list.with(body-format: (stroke: (red, auto)))
#[
  - #el.item(label-baseline: "center") #lorem(20)
]
#[
  - #el.item(label-baseline: "bottom-item") #lorem(20)
]
#[
  - #el.item(label-baseline: (same-line-style: "bottom-label"))
    - #el.item(label-format: (stroke: blue), [$vec(1, 1, 1)$]) #lorem(20)
    #lorem(10)
]
