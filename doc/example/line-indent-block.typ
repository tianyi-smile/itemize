#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.default-enum-list.with(
  line-indent: 1em, 
  hanging-indent: 2em
)
+ #block(stroke: 1pt)[
    #lorem(10)

    #lorem(10)
  ]
  #lorem(10)
+ #lorem(10)
  #table([#lorem(10)], [#lorem(10) $ a $ #lorem(10)])
