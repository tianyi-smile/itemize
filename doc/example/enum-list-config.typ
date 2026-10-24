#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.default-enum-list.with(
  enum-config: (fill: (red, auto)), // For level 1, enum's labels are colored by red
  list-config: (fill: (blue, auto)), // For level 1, list's labels are colored by blue
  fill: green, // For subsequent levels, all labels are colored by green
)
+ enum level one
  - list level one
    + enum level two
    - list level two
  Paragraph
  + enum level two
    - list level one
- list level one
  + enum level one
