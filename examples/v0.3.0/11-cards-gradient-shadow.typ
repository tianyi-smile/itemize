#import "../../lib.typ" as el

#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  it
}

#set page(height: auto, margin: 2em, width: 12cm)

#[
  = Gradient-numbered cards with shadow
  // See Erin E. Sullivan https://codepen.io/erinesullivan/pen/qGrdGV
  #let linear-gradient = (color1, color2, n, m) => {
    gradient.linear(
      rgb(..color1.components(alpha: false), n),
      rgb(..color2.components(alpha: false), m),
      angle: 135deg,
    )
  }
  #import "@preview/shadowed:0.4.0": shadow
  #set par(justify: true)
  #let gradient-enum = el.default-enum.with(
    indent: (2em, auto),
    body-format: (
      outer: (
        radius: (5pt, auto),
        inset: ((y: 2em), auto),
        format: it => {
          if it.level == 1 {
            block(above: 2em, below: 0pt)
            shadow(
              blur: 8pt,
              dx: 12pt,
              spread: (left: -10pt, right: -12pt),
              fill: rgb(89, 85, 101, 25%),
              radius: 4pt,
              block(
                fill: white,
                radius: 4pt,
                inset: (bottom: -12pt, top: -32pt, left: -2em, right: 12pt),
                outset: (left: -2em),
                it.body,
              ),
            )
          } else {
            it.body
          }
        },
      ),
    ),

    label-align: (bottom + right, auto),
    size: (1.5em, auto),
    label-format: it => {
      if it.level == 1 {
        let i = calc.rem-euclid(it.n, 10) + 1
        let (n, m) = if i in range(1, 6) {
          (i * 20%, i * 20%)
        } else {
          (100% - (i - 5) * 10%, 100% - (i - 5) * 10%)
        }
        box(
          fill: linear-gradient(rgb("#83e4e2"), rgb("#a2ed56"), 100%, 100%),
          height: 2em,
          width: 2em,
          radius: (bottom-right: 0pt, rest: .5em),
          box(
            height: 2em,
            width: 2em,
            radius: (bottom-right: 0pt, rest: .5em),
            inset: (bottom: 5pt, right: 3pt),
            fill: linear-gradient(rgb("#a2ed56"), rgb("#fddc32"), n, m),
            [*#it.body*],
          ),
        )
      } else {
        it.body
      }
    },
  )
  #gradient-enum[
    + #lorem(5)

      #lorem(15)
      + #lorem(5)
      + #lorem(5)
    + #lorem(15)
      - #lorem(5)
      - #lorem(5)
    10. #lorem(15)
  ]
]
