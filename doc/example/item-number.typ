#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.default-enum-list.with(label-align: left)
+ #lorem(2)
+ #el.item[#sym.section] #lorem(2) Current enum number is 2.
+ #lorem(2)
+ #el.item(skipped: true, [#sym.section]) #lorem(2) Current enum number is 3.
+ #lorem(2)
