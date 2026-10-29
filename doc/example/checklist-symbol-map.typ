#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.default-enum-list.with(fill: blue, checklist: true)
#show: el.config.checklist.with(
  symbol-map: (" ": emoji.checkmark, "A": emoji.a),
)
- [ ] #lorem(5)
- [A] #lorem(5)

#let box-sym(fill: white, stroke: rgb("#616161"), radius: .1em, body) = box(
  stroke: .05em + stroke,
  fill: fill,
  height: 1em,
  width: 1em,
  radius: radius,
)[#body]
#show: el.config.checklist.with(
  fill: blue,
  solid: luma(95%),
  symbol-map: it => (
    " ": box-sym(fill: it.solid, stroke: it.fill, radius: .2em, []),
    "x": box-sym(fill: it.fill, stroke: it.fill, radius: .2em, [#text(fill: white)[#emoji.checkmark]]),
    "A": box-sym(fill: it.fill, stroke: it.fill, radius: .2em, [#text(fill: white)[A]]),
  ),
)
- [ ] #lorem(5)
- [x] #lorem(5)
- [A] #lorem(5)
