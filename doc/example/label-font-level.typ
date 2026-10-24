#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#let label-font = ((name: "DejaVu Sans Mono", covers: "latin-in-cjk"), "Noto Serif CJK SC")
#show: el.default-enum-list.with(font: label-font)
#set enum(numbering: "（1）")
+ #lorem(2)
+ #lorem(2)
  + #lorem(2)
  + #lorem(2)
