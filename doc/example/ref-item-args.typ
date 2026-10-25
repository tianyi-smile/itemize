#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.config.ref
#show link: set text(fill: orange)
#set enum(numbering: "1.a.i.")
#show: el.default-enum-list
+ #lorem(5)
  + #el.item(ref-numbering: "(a)", supplement: [Euler]) <item:a> *Euler*  #lorem(5)
  + #lorem(5) <item:b>
    + #el.item(ref-numbering: (full: true)) #lorem(5)
    + #lorem(5) <item:b-s>
  + #lorem(5)
Test: @item:a, @item:b[Item], @item:b-s.
