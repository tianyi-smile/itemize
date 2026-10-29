#set page(height: auto, margin: 15pt, width: 12cm)
#import "../../lib.typ" as el
#let test = [
  + / CPU: #lorem(6)

      *Description list body*
      #lorem(6)

    *enum body*
    #lorem(6)
  + / GPU: #lorem(6)
]
#let my-desc(enable-first-par) = el.default-enum-list.with(
  line-indent: 1em,
  body-format: (style: (fill: blue) ),
  description-config: (
    term-format: (strong,),
    format: (text.with(fill: red), none),
    enable-first-par: enable-first-par,
  )
)
#table(
  columns: (1fr, 1fr),
  table.header([`enable-first-par: true`], [`enable-first-par: false`]),
  [
    #show: my-desc(true)
    #test
  ],
  [
    #show: my-desc(false)
    #test
  ]
)
