#import "../lib.typ" as el
#set page(height: auto, margin: 35pt)

#set text(size: .8em)

#import "@preview/numbly:0.1.0": numbly
#set enum(
  numbering: numbly(
    "{1:A}",
    "{2:1}.",
    "{3:a})",
  ),
  full: true, // add this if use `numbly`
)
#show: el.default-enum-list.with(
  label-format: it => {
    if it.level == 1 {
      set text(size: 20pt, fill: blue, weight: "bold")
      set align(center)
      let number = box(stroke: 1pt + blue, inset: 5pt, width: 25pt)[#it.body]
      let height = measure(number).height
      move(dy: height)[#number]
    } else {
      it.body
    }
  },
  enum-spacing: ((above: .5em, below: 2.5em), auto),
  item-spacing: (-.5em, auto),
  auto-base-level: true,
)
#lorem(10)
+ #lorem(10)
  - #lorem(10)
  - #lorem(10)
+ #lorem(20)
  + #lorem(5)
  + + #lorem(5)
    + #lorem(5)
  + #lorem(5)
+ #lorem(20)
#lorem(10)
