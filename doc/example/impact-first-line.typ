#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#let test = [
  + #el.item([$vec(a, b, c)$]) #lorem(10)
]
#table(
  columns: (1fr, 1fr),
  table.header([`impact-first-line: false`], [`impact-first-line: true`]),
  [
    #show: el.default-enum-list
    #test
  ],
  [
    #show: el.default-enum-list.with(label-baseline: (impact-first-line: true))
    #test
  ],
)
