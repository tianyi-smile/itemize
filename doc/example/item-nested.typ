#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.default-enum-list
Paragraph
+ #lorem(2)
+ #el.item(fill: red) #lorem(2)
  + #lorem(2)
+ #el.item(body-format: (style: (fill: blue))) #lorem(2)
  + #lorem(2)
  #lorem(2)
+ #lorem(2)
