#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show link: set text(fill: orange)
#show: el.config.ref
#set enum(numbering: "(1).(a)")
#show: el.default-enum-list
+ #lorem(5)
  + #lorem(5)
  + $a^2+b^2 = c^2$ #el.elabel(<item:eq>) // use `elabel`, otherwise it will label the equation.
+ #lorem(5) <item:one>
The Conclusion @item:one and the equation in @item:eq[Item] are important.
