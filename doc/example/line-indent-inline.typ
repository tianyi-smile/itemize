#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#set par(first-line-indent: (amount: 1em, all: true), hanging-indent: 1em)
#table(
  columns: (1fr, 1fr), 
  table.header([*itemize*], [*native*]),
  [
    #show: el.default-enum-list.with()
    + #lorem(10)

      #lorem(10)
    + #lorem(10)
  ], 
  [
    #enum(
      enum.item[
        #lorem(10)

        #lorem(10)
      ],
      enum.item[#lorem(10)] // not apply, since it is not `par`
    )#el.itemize-prevent-label

  ]
)
