
#import "../lib.typ" as el
#set page(height: auto, margin: 35pt)


#let item-test = [
  + one $vec(1, 1, 1)$
    $
      x^2 + y^2 = z^2
    $
  + #rect(height: 2em, width: 2em) #lorem(2)
  + #block(stroke: 1pt)[two $vec(1, 1, 1,)$]
  + $ (a + b)^2 = a^2 + 2a b + b^2 $
  + + #lorem(2)
  + - #lorem(2)
    - #lorem(2)
]
#table(
  columns: (1fr, 1fr),
  [native], [itemize],
  [
    #item-test
  ],
  [
    #show: el.default-enum-list
    #item-test
  ],
)
