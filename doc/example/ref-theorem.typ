#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#let theorem(doc) = {
  let number = context counter(figure.where(kind: "thm")).display("1")
  figure(
    kind: "thm",
    supplement: "Theorem",
    block(
      stroke: (left: 4pt + blue, rest: 1pt + blue),
      inset: 5pt,
      width: 100%,
      {
        set align(left)
        [
          #set text(fill: blue)
          #strong[Theorem #number.]
        ]
        h(.65em, weak: true)
        set enum(numbering: "1).a)")
        show: el.default-enum-list.with(
          supplement: it => if it.level in (1, 2) {
            [Theorem #number #it.body]
          } else { it.body },
          ref-numbering: (numbering: "(1).(a)", full: true),
        )
        doc
      },
    ),
  )
}
#theorem([
  #lorem(5) The following conclusions are hold.
  + + #lorem(2) <item:thmA1>
    + #lorem(2)
  + #lorem(2)
])
See @item:thmA1.
