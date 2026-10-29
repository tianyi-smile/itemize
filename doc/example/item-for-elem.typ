#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.default-enum-list
Paragraph
+ #el.item(fill: red, for-elem: true) #lorem(2)
+ #lorem(2)
Paragraph
+ #el.item(fill: red) #lorem(2)
+ #lorem(2)
Paragraph
