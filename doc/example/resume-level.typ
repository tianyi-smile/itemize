#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.default-enum-list.with(auto-resuming: auto)
#let emph-enum = el.item(body-format: (whole: (stroke: red, inset: 1pt)))
+ #lorem(5)
  + #emph-enum #lorem(5)
  + #lorem(5)
+ #lorem(5)
  #el.resume() // -> 3
  + #emph-enum #lorem(5) (resume)
  + #lorem(5)
+ #lorem(5)
  + #lorem(5)
