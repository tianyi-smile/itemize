#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.default-enum-list.with(fill: red,)
+ #lorem(2)
  + #el.item(label-format: (
      inset: 2pt, 
      stroke: red, 
      width-style: (amount: "label-width", stretched: true)
    )) 
    #lorem(2)
    + #lorem(2)
    + #lorem(2)
  + #lorem(2)
+ #lorem(2)
