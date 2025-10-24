
#import "../lib.typ" as el
#import "helper.typ": *
#import "@preview/codly:1.3.0": codly-init
#show: codly-init

#set page(margin: 45pt)

#set page(footer: {
  set align(center)
  context counter(page).display("1/1", both: true)
})

#show link: set text(fill: orange)

#show raw.where(text: "cheq"): link("https://typst.app/universe/package/cheq", "cheq")

#let raw-box = it => {
  box(fill: gray.lighten(85%), stroke: 1pt + blue.lighten(75%), inset: 2pt, baseline: 2pt)[#it]
}

#show raw.where(block: false): raw-box

#[
  #v(4cm)
  #set align(center)
  #text(size: 3em)[*Itemize*]


  #v(1em)

  ver0.2.0

  #v(1em)
  https://github.com/tianyi-smile

  #v(2em)

  #box(width: 50%)[
    A typst package for users to easily customize and format enumerations and lists.
  ]
]

#pagebreak()

#outline()


#set heading(numbering: "1.1")
#set par(justify: true)

#set raw(lang: "typc")



= Overview

The `itemize` package allows users to easily customize and format enumerations and lists. To use this package, include the following at the beginning of your document:

```typst
#import "@preview/itemize:0.2.0" as el
```

Use the method `default-enum-list` to override the native behavior of `enum` and `list` by adding the following at the beginning of your document:

```typst
#show: el.default-enum-list
```

Now you can use `enum` and `list` as usual. Below is a comparison.
#example(
  style: "v",
  ```
  #let item-test = [
    + one $vec(1, 1, 1)$
      $
        x^2 + y^2 = z^2
      $
    + #rect(height: 2em, width: 2em) #lorem(2)
    + #block(stroke: 1pt)[two $vec(1, 1, 1,)$]
    + $ (a + b)^2 = a^2 + 2a b + b^2 $
    + + #lorem(2)
    + - #lorem(2)
      - #lorem(2)
  ]
  #table(
    columns: (1fr, 1fr),
    [native], [itemize],
    [
      #item-test
    ],
    [
      #show: el.default-enum-list
      #item-test
    ],
  )
  ```,
)

#show: el.config.checklist.with(extras: true, symbol-map: ("!": [⚠️], "N": [🆕]), baseline: "center")

#show: el.default-enum-list.with(
  checklist: true,
  auto-label-width: (auto, "each"),
  fill: (purple, green, red, blue, orange, el.LOOP),
  list-config: (
    label-align: (auto, center),
  ),
  body-format: (
    inner: (
      fill: auto,
      stroke: (1pt + red, auto),
      radius: (5pt, auto),
      inset: (5pt, auto),
    ),
  ),
)

#show: el.config.ref



#include "intro1.typ"

#include "intro2.typ"

#include "intro3.typ"

#include "intro4.typ"




