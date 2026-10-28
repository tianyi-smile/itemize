#import "@preview/layout-ltd:0.1.0": *
#show: layout-limiter.with(max-iterations: 3)

#set page(height: auto, margin: 15pt, width: 12cm)

#import "../../lib.typ" as el

#let test = [
  #set par(justify: true)
  - / #box([Windows]): #lorem(10)

      #lorem(10)
  - / MacOS: #lorem(6)
  - / Linux: #lorem(6)
  + / Markdown: #lorem(10)
  + / Latex: #lorem(6)
  + / Typst: #lorem(6)
]

#let desc-list(body, ..args) = el.default-enum-list(
  description-config: (
    enable-first-par: false,
    term-format: (strong,),
    ..args.named(),
  ),
  body,
)

#table(
  [
    *Plain style description list: *
    #desc-list[#test]
  ],
  [
    *Horizontal style description list: *
    #desc-list(style: "horizontal")[#test]
  ],
  [
    *Hanging style description list: *
    #desc-list(style: "hanging")[#test]
  ],
  [
    *Stacked style description list: *
    #desc-list(style: "stacked", separator: (prefix: context block(above: 0pt, below: par.leading)))[#test]
  ],
  [
    #show: el.default-enum-list.with(
      checklist: true,
      description-config: (
        term-format: (strong,),
        checklist: true,
      ),
    )
    *Checklist style description list: *
    + / [ ]: #lorem(12)
    + / [-]: #lorem(8)
  ],
)
