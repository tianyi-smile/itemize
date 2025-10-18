#import "../lib.typ" as el
#set page(height: auto, margin: 35pt)

#show: el.default-enum-list.with(auto-resuming: auto)
+ #lorem(5)
  + #lorem(5)
  + #lorem(5)
  #lorem(5)
+ #lorem(5)
  #el.resume() // -> 3
  + #lorem(5)
  + #lorem(5)
+ #lorem(5)
  + + #lorem(5)
