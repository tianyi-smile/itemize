#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show link: set text(fill: orange)
#set enum(numbering: "1.a.")
#show: el.default-enum-list
+ #lorem(2) <item:ass1>
  + #lorem(2) 
  + #lorem(2) <item:ass1-s>
+ #lorem(2)
Paragraph

+ #lorem(2) 
+ #lorem(2) <item:sec1>
  + #lorem(2) <item:sec1-s>
  + #lorem(2)
#[
  #show: el.config.ref.with(
    numbering: "(1).(a)", 
    supplement: [Assumption]
  )
  - Test: @item:ass1, @item:ass1-s.
  - Test: @item:sec1, @item:sec1-s.
]
Paragraph

#[
  #show: el.config.ref.with(
    numbering: "1.a", 
    supplement: [#sym.section]
  )
  - Test: @item:ass1, @item:ass1-s.
  - Test: @item:sec1, @item:sec1-s.
]
Paragraph
// default
- Test: @item:ass1, @item:ass1-s.
- Test: @item:sec1, @item:sec1-s.
