#import "@preview/layout-ltd:0.1.0": *
#show: layout-limiter.with(max-iterations: 3)

#set page(height: auto, margin: 15pt, width: 12cm)

#import "../../lib.typ" as el

#show link: set text(fill: orange)

#show: el.default-enum-list
#set enum(numbering: "a.A.1.", full: true)
#set heading(numbering: "(1.a)")
#show: el.config.ref
= List-ref
- #el.item([*#sym.section*], supplement: [Assumption])<l:my> #lorem(15)
See: @l:my.

= Supplement with prefix and suffix
#[
  #show: el.config.ref.with(supplement: (prefix: [第], suffix: [项]), numbering: "(a).(A)")
  + #lorem(5)
  + #lorem(5) <item:mya>
  See @item:mya.
]

= Ref: item
+ #lorem(5)
  + #el.item(ref-numbering: "(a)(A)", supplement: [Euler])<item:a> *Euler*  #lorem(5)
  + #lorem(5) <item:b>
    + #lorem(5)
    + #lorem(5)
  + #lorem(5)
+ #lorem(5)

See @item:a and @item:b[Item].
= Relative-reference
#show: el.config.ref.with(full: "rel")
+ #lorem(5) <p:a>
  + #lorem(5) <p:b>
  + #lorem(5)
    + #lorem(5) <p:c>
    + #lorem(5) Rel-ref: @p:a, @p:b and @p:c
  + #lorem(5) Rel-ref: @p:a, @p:b and @p:c
    + #lorem(5) Rel-ref: @p:a, @p:b and @p:c
  #lorem(10)
  + Rel-ref: @p:a, @p:b and @p:c
+ #lorem(5) Rel-ref: @p:a, @p:b and @p:c
  + Rel-ref: @p:a, @p:b and @p:c
#lorem(5)
+ #lorem(5) Rel-ref: @p:a, @p:b and @p:c
+ #lorem(5)

#[
  #show: el.default-enum-list.with(
    supplement: it => {
      [Heading: #numbering(heading.numbering, ..counter(heading).at(it.target)).#it.body]
    },
  )

  #show: el.config.ref.with(full: true)

  = Target-ref
  + #lorem(2)
    + #lorem(5) <item:testa>
    + #lorem(4)
  + #lorem(3)
  #divider()
  == Sub Heading
  + #lorem(2)
  + #lorem(3)
    + #lorem(5) <item:testb>

  Test: @item:testa

  Test: @item:testb
]
