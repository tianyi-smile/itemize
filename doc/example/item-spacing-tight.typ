#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.default-enum-list.with(
  item-spacing: it => {
    if it.level == 1 {
      if not it.e.tight {
        (below: 1fr)
      } else { auto }
    } else { auto }
  },
)
#lorem(10)
#block(stroke: red, height: 3.5cm, width: 100%)[
  *Tight*:
  + Answer one
  + Answer two
  + Answer three
  #lorem(5)
]
#block(stroke: red, height: 3.5cm, width: 100%)[
  *Not tight*:
  + Answer one

  + Answer two
  + Answer three
  #lorem(5)
]
