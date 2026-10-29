#import "../helper.typ": *

#show: el.config.ref.with(no-label-warning: true)

#show: m.mantys(
  ..toml("../../typst.toml"),
  show-outline: true,
  show-index: false,
  title: [`itemize`],
)

#set page(
  paper: "a4",
  margin: (left: 1.6cm + 6mm, right: 1.6cm - 5mm, y: 2.2cm),
  footer: context {
    if counter(page).get().first() > 1 [
      #set text(8pt, fill: splash.seaborn.dark.gray)
      *`itemize`* #el.adv.version #h(1fr) #counter(page).display()
    ]
  },
)
#set par(justify: true)
#set raw(lang: "typ")
#show raw.where(block: true): block.with(stroke: splash.seaborn.dark.gray.lighten(50%) + .5pt, inset: 5pt, width: 100%)

#set heading(numbering: "I.1.1.1.")

// #outline()

= Overview

== Basic usage
The `itemize` package allows users to easily customize #m.builtin("enum") and #m.builtin("list"). To use this package, include the following at the beginning of your document:

```typst
#import "@preview/itemize:0.3.0" as el
```
Use the method @cmd:default-enum-list to override the native behavior of #m.builtin("enum") and #m.builtin("list") by adding the following at the beginning of your document:

```typst
#show: el.default-enum-list
```
to apply all #m.builtin("enum") and #m.builtin("list") in your document.
Or use
```typst
#el.default-enum-list()[
  /* content */
]
```
to only apply the #m.builtin("enum") and #m.builtin("list") in `/* content */`.

#warning-alert()[
  #m.changed(0,3,0)`itemize:0.3.0` requires at least Typst 0.15.1.
]

Now you can use #m.builtin("enum") and #m.builtin("list") as usual. `itemize` revises some default behaviors of #m.builtin("enum") and #m.builtin("list") (of Typst 0.15.1):

- Labels on the same line are now aligned with the list;
- If the label has no baseline, bottom alignment is used by default (which better fits common usage).

Below is a comparison.

#example(read("../example/native.typ"))




#let important-svg = ```
<svg width="100" height="100" viewBox="-20 0 120 100" xmlns="http://www.w3.org/2000/svg">
  <circle cx="50" cy="50" r="38" fill="none" stroke="#E8833A" stroke-width="5"/>
  <path d="M50 30 L50 58" stroke="#E8833A" stroke-width="6.5" stroke-linecap="round"/>
  <circle cx="50" cy="70" r="5.5" fill="#E8833A"/>
</svg>
```.text
#let enhance-svg = ```
<svg width="100" height="100" viewBox="-20 0 120 100" xmlns="http://www.w3.org/2000/svg">
  <circle cx="50" cy="50" r="38" fill="none" stroke="#50B86C" stroke-width="5"/>
  <path d="M50 22 L50 62" stroke="#50B86C" stroke-width="5.5" stroke-linecap="round"/>
  <path d="M37 40 L50 22 L63 40" fill="none" stroke="#50B86C" stroke-width="5.5" stroke-linecap="round" stroke-linejoin="round"/>
  <path d="M35 68 L50 78 L65 68" fill="none" stroke="#50B86C" stroke-width="5" stroke-linecap="round" stroke-linejoin="round"/>
</svg>
```.text
#let new-svg = ```
<svg width="100" height="100" viewBox="-10 -3 100 100" xmlns="http://www.w3.org/2000/svg">
  <rect x="10" y="28" width="80" height="50" rx="8" fill="none" stroke="#4A90D9" stroke-width="5"/>
  <text x="50" y="65" font-family="Arial, sans-serif" font-size="28" font-weight="bold" fill="#4A90D9" text-anchor="middle" letter-spacing="2">NEW</text>
</svg>
```.text
#let minor-svg = ```
<svg width="100" height="100" viewBox="-20 0 120 100" xmlns="http://www.w3.org/2000/svg">
  <circle cx="50" cy="50" r="38" fill="none" stroke="#9B7ED8" stroke-width="5"/>
  <circle cx="50" cy="43" r="10" fill="none" stroke="#9B7ED8" stroke-width="5.5"/>
  <path d="M46 53 L46 66" stroke="#9B7ED8" stroke-width="5.5" stroke-linecap="round"/>
  <path d="M54 53 L54 67" stroke="#9B7ED8" stroke-width="5.5" stroke-linecap="round"/>
</svg>
```.text
#let important-image = image(bytes(important-svg), width: 1.2em)
#let enhance-image = image(bytes(enhance-svg), width: 1.2em)
#let new-image = image(bytes(new-svg), width: 1.2em)
#let minor-image = image(bytes(minor-svg), width: 1.2em)
#show: el.config.checklist.with(
  extras: true,
  symbol-map: (
    "!": [#important-image],
    "N": [#new-image],
    "E": [#enhance-image],
    "M": [#minor-image],
  ),
  baseline: "center",
)



#include "part01.typ"


#include "part02.typ"

#include "part03.typ"


#include "../API/api-doc.typ"
