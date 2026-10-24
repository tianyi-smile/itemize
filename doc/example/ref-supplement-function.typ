#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show link: set text(fill: orange)
#set enum(numbering: "1.a.A.", full: true)
#show: el.default-enum-list
+ #lorem(2) <item:default0>
  + #lorem(2) 
  + #lorem(2) 
+ #lorem(2)
Paragraph
+ + #el.item(elem-tag: "ref:mark") #lorem(2) <item:mark0>
  + #lorem(2) 
    + #lorem(2) <item:default1>
    + #lorem(2)
  + #lorem(2) <item:mark1>

#[
  #show: el.config.ref.with(
    numbering: "(1).(a).(A)", 
    supplement: it => if it.at("elem-tag", default: none) == "ref:mark" {
      set text(style: "italic", fill: red)
      [#sym.section #std.numbering("-1-a-A", ..it.numbers)]
    } else {
      it.body // use default
    }
  )
  Customize:
  - Test (default): @item:default0, @item:default1
  - Test (ref-mark): @item:mark0, @item:mark1.
]
Default:
- Test (default): @item:default0, @item:default1
- Test (ref-mark): @item:mark0, @item:mark1.
