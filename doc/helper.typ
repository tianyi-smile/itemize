#let doc(code, preamble: "", scope: (:), style: "h") = {
  let hv = if style == "h" {
    (columns: (1fr, 1fr))
  } else {
    (rows: 2)
  }
  let inset = if style == "h" {
    (inset: ((right: 2.5pt, rest: 5pt), (left: 2.5pt, rest: 5pt)))
  } else {
    (inset: ((bottom: 2.5pt, rest: 5pt), (top: 2.5pt, rest: 5pt)))
  }
  set text(size: .8em)
  let all = preamble.text + "\n" + code.text
  grid(
    ..hv,
    align: center + horizon,
    ..inset,
    stroke: (1pt + gray.lighten(30%), 1pt + gray.lighten(30%)),
    // radius: (),
    fill: (gray.lighten(30%), gray.lighten(30%)),
    [
      #block(radius: 0.5em, inset: 6pt, fill: white, width: 100%)[
        #set par(justify: false)
        #set align(left)
        #raw(
          code.text,
          lang: "typ",
          block: true,
        )
      ]
    ],
    [
      #block(radius: 0.5em, inset: 6pt, fill: white, width: 100%, breakable: false)[
        #set par(justify: false)
        #set align(left)
        #eval(
          all,
          mode: "markup",
          scope: scope,
        )
      ]
    ],
  )
}

#let example(code, scope: (:), style: "h") = {
  doc(code, preamble: `#import "../lib.typ" as el`, scope: scope, style: style)
}
