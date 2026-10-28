#import "../../lib.typ" as el

#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  it
}

#set page(height: auto, margin: 2em, width: 12cm)

#[
  = Cards with left accent border
  #show: el.default-list.with(
    body-format: (
      stroke: (
        (left: 3pt + rgb("#7a4fb3"), rest: 1pt + rgb("#e3e7ec")),
        (left: 3pt + rgb("#9cafc8"), rest: 1pt + rgb("#e3e7ec")),
      ),
      inset: (5pt,),
      radius: (8pt,),
    ),
    // label-format: [],
    label-width: .5em,
  )
  - Color

    #lorem(15)
    - Primitive

      #lorem(6)
    - Semantic

      #lorem(2)
  - Text
    - Font
    - Style
]
