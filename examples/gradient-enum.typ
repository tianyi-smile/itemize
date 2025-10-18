#import "../lib.typ" as el

#import "@preview/shadowed:0.2.0": shadowed

#set page(height: auto, margin: 25pt, width: 12cm)
#set par(justify: true)

// See Erin E. Sullivan https://codepen.io/erinesullivan/pen/qGrdGV 
#let linear-gradient = (color1, color2, n, m) => {
  gradient.linear(
    space: rgb,
    rgb(..(color1.components(alpha: false)), n),
    rgb(..color2.components(alpha: false), m),
    angle: 135deg,
  )
}
#let gradient-enum = el.default-enum.with(
  indent: (1em, 0em),
  item-format: it => {
    if it.level == 1 {
      shadowed(radius: 5pt, inset: (bottom: 12pt, top: -12pt, left: -2em, right: 12pt), it.body)
    } else {
      it.body
    }
  },

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
  10. #lorem(10)
  + #lorem(10)
]
