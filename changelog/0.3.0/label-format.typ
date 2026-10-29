#import "@preview/layout-ltd:0.1.0": *
#show: layout-limiter.with(max-iterations: 3)

#set page(height: auto, margin: 15pt, width: 12cm)

#import "../../lib.typ" as el

#show: el.default-enum-list.with(
  // body-format: (stroke: red), // debug
  label-format: (
    stroke: (red, blue),
    align: center + horizon,
    width-style: (amount: 1.2em, stretched: true),
    height-style: (amount: 1.2em, stretched: true),
    radius: 1em,
  ),
)
#set enum(numbering: "1.A")
+ #lorem(15)
  + #lorem(15)
  + #lorem(6)
+ #lorem(6)
