#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#let item = [
  + #lorem(5)
    + #lorem(5)
    + + #lorem(5)
    + - #lorem(5)
  + #lorem(5)
]

#show: el.set-default()
#set enum(numbering: "(1).(a).(i)")
#item

// change the label color
#show: el.set-default(fill: (red, blue, green, auto))
#item

// change the label size
#show: el.set-default(size: (20pt, 16pt, 14pt, auto))
#item

// change the body-format and indent
#show: el.set-default(indent: (auto, 1em),  body-format: (strong,))
#item

// change the border of the item body
#show: el.set-default(body-format: (stroke: (red, auto), inset: (5pt, auto)))
#item

// use the default style
#show: el.set-default()
#item
