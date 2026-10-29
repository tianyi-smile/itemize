#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.default-enum-list.with(first-line-inset: 1em)
+ #lorem(15)

  Paragraph two: #lorem(15)
+ $ a^2 + b^2 = c^2 $ // no first line
  #lorem(15) 
