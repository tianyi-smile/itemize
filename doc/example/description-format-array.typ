#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.default-enum-list.with(description-config: (
  term-format: (emph,),
  format: (text.with(fill: red), strong, none),
))
- / CPU: #lorem(10)
  + / ABC: #lorem(10)
  + / DEFF: #lorem(10)
- / GPU: #lorem(10)
