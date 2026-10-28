#import "../../lib.typ" as el

#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  it
}

#set page(height: auto, margin: 2em, width: 12cm)

#let v-line = context {
  let height = if page.height == auto {
    12cm // debug
  } else {
    page.height
  }
  box(outset: (top: height, bottom: height), stroke: 1pt + gray.lighten(50%))
}
#[
  = Resumed numbering with unified label width
  #let resuming-enum = el.default-enum-list.with(
    auto-resuming: true, // enable resume enum number
    auto-label-width: "each", // enable sharing the maximum label width for each level
  )
  #set enum(numbering: "(1.I.i)")
  #block(clip: true, inset: (y: 5pt))[
    #resuming-enum[
      + #v-line#lorem(15)
        + #v-line#lorem(5)
        + #lorem(5)
          + #v-line#lorem(5)
          + #lorem(5)
        paragraph
        + + #lorem(5) (Resume)
        + #lorem(5)
      + #lorem(5)
        + #lorem(5) (Resume)
          + #lorem(5) (Resume)
    ]
  ]
]
