#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.default-enum-list.with(ref-numbering: (numbering: "(1).(a)", full: true))
#show: el.config.ref
#set enum(numbering: "1.a.")
+ #lorem(2)
+ #lorem(2)
  + #lorem(2)
  + #lorem(2) <item:full>

Test: @item:full.
