#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.default-enum-list
Paragraph
+ #lorem(2)
+ #el.item(body-format: (inner: (emph,)), fill: red) #lorem(2)
+ #lorem(2)
