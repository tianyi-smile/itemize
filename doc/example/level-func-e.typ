#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#show: el.default-enum-list.with(
  fill: it => {
    let last-e(color) = if it.n == it.n-last { red } else { color }
    if it.e.tight {
      last-e(purple)
    } else {
      last-e(blue)
    }
  },
)
*tight*
+ tight #lorem(2)
+ tight #lorem(2)
+ tight #lorem(2)

*not-tight*
+ tight #lorem(2)

+ tight #lorem(2)
+ tight #lorem(2)