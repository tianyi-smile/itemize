#import "@preview/itemize:0.2.0" as el
#set page(height: auto, margin: 25pt, width: 12cm)
#set par(justify: true)
#let circled-enum = el.default-enum.with(
  body-indent: (1.5em, auto),
  label-baseline: (.7em, auto),
  label-format: it => {
    if it.level == 1 {
      let c = if calc.odd(it.n) {
        green
      } else {
        blue
      }
      [#box(circle(width: 2em, stroke: c + 2pt), baseline: .7em)#h(-1.3em)#it.body]
    } else {
      it.body
    }
  },
)



#circled-enum[
  // <= 9 items
  + Euler's identity: $e^(i pi) + 1 = 0$

    #lorem(15)

  + Newton's Second Law of Motion: $bold(F) = m bold(a)$
    + #lorem(5)
    + #lorem(5)
  + Pythagorean Theorem: $c^2 = a^2 + b^2$
    - #lorem(5)
    - #lorem(5)
  + The Schrödinger Equation: $i planck.reduce frac(partial, partial t) Psi(bold(r), t) = hat(H) Psi(bold(r), t)$

    #lorem(5)
]
