#import "../lib.typ" as el
#set page(height: auto, margin: 25pt, width: 12cm)
#set par(justify: true)
#import "@preview/catppuccin:1.0.1": get-flavor
#let flavor = get-flavor("latte")
#let palette = flavor.colors

#let color-list = (
  palette.values().map(v => v.rgb)
)
#let fill-color(n) = {
  color-list.at(calc.rem-euclid(n, 13))
}
// #show: catppuccin.with(flavors.frappe)
#let square-enum = el.default-enum-list.with(
  label-baseline: (amount: "center", same-line-style: "center"),
  enum-config: (
    fill: (white, auto),
    label-align: (center + horizon, auto),
    label-width: (1.2em, auto),
    label-format: it => {
      if it.level == 1 {
        box(
          fill: fill-color(it.n),
          // inset: 5pt,
          radius: 3pt,
          width: 1.2em,
          height: 1.2em,
        )[#it.body]
      } else {
        it.body
      }
    },
    body-format: (
      style: (fill: rgb("#3c2948")),
    ),
  ),
)

#set enum(numbering: "1.a")

#square-enum[
  // <= 99
  + #lorem(15)

    #lorem(5)
  + + #lorem(15)
    + #lorem(15)
  + #lorem(5)
  + - #lorem(5)
    - #lorem(5)
  90. #lorem(15)
]
