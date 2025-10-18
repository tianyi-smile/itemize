#import "../lib.typ" as el

#set page(height: auto, margin: 25pt, width: 12cm)
#set par(justify: true)

#let align-label(doc) = el.default-enum-list(
  auto-label-width: auto,
  // debug
  // body-format: (
  //   inner: (
  //     stroke: (left: 1pt + blue) ,
  //     outset: it => {
  //       if it.n < it.n-last or it.level >= 2 {
  //         (bottom: 2em + it.n * 5em)
  //       }
  //     }
  //   ),
  // ),
  el.auto-label-item(form: (none, "all"), doc),
)

#set enum(numbering: "(1.1)")
#align-label[
  + #lorem(15)
    + #lorem(5)
    + #lorem(5)
      + #lorem(5)
      + #lorem(5)
    #lorem(5)
    100. #lorem(5)
      10. #lorem(20)
  + #lorem(5)
    + #lorem(5)
    #lorem(15)
    10. #lorem(5)
      20. #lorem(5)
]