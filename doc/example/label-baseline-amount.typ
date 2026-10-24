#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.default-enum-list.with(
  label-baseline: (amount: -50%, at: bottom), // Here, the radio is relative to the label height
  fill: (red, auto),
)
#set enum(numbering: "A.")
+ #lorem(10)
