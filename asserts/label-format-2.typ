#import "../lib.typ" as el
#set page(height: auto, margin: 35pt)

#let emoji = (emoji.alien, emoji.book.orange, emoji.butterfly, emoji.cloud.storm, el.LOOP)
#show: el.default-enum-list.with(
  label-format: (
    emoji,
    box.with(stroke: 1pt + blue, inset: 1pt),
    auto,
  ),
)
+ #lorem(5)
  + #lorem(5)
    + #lorem(5)
  + #lorem(5)
+ #lorem(5)
+ #lorem(5)
+ #lorem(5)
+ #lorem(5)



