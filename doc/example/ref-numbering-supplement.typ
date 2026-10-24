#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show link: set text(fill: orange)
#set enum(numbering: "1.a.")
#[
  #show: el.default-enum-list.with(
    ref-numbering: "(1).(a)", 
    supplement: [Assumption]
  )
  + #lorem(2) <item:ass>
    + #lorem(2) 
    + #lorem(2) <item:ass-s>
  + #lorem(2)
]
#[
  #show: el.default-enum-list.with(
    ref-numbering: "1.a", 
    supplement: [#sym.section]
  )
  + #lorem(2) 
  + #lorem(2) <item:sec>
    + #lorem(2) <item:sec-s>
    + #lorem(2)
]
Test: @item:ass, @item:ass-s.

Test: @item:sec, @item:sec-s.
