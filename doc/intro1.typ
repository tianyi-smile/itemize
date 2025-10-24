
#import "../lib.typ" as el

#import "helper.typ": *


// #import "@preview/tidy:0.4.3"






= Basic Features and Model Introduction

== Features
The `itemize` package currently offers the following features:
+ Compatibility with native `enum` and `list` behaviors in most cases, along with fixes for certain native bugs (or providing alternative choices), such as #link("https://github.com/typst/typst/issues/1204", [`typst/issue#1204`]) and #link("https://github.com/typst/typst/issues/529", [`typst/issue#529`]).
+ Customization of `enum` and `list` _label_\s and _bodie_\s by *level* and *item*:
  - Horizontal spacing settings: `indent`, `body-indent`, `label-indent`, `enum-margin` (`is-full-width`).
  - Vertical spacing settings: `item-spacing`, `enum-spacing`.
  - Label formatting settings: `..args(text-style)`, `label-align`, `label-baseline`, `label-width`.
    - Customize labels in any way: `label-format`.
  - Alignment styles for labels between items: `auto-label-width`.
  - Body formatting settings: `hanging-indent`, `line-indent`.
    - Set text and border styles for the body: `body-format`.
+ Enhanced `enum` features:
  - Reference functionality for `enum` numbering.
  - Resume functionality for `enum` numbering.
+ Enhanced `list` features:
  - Terms-like functionality: Temporarily change the marker of the current item using the `item` method.
  - Checklist (similar to the `cheq` package).

== Main Methods

The package `itemize` primarily provides the following methods:
=== Two Styles of enum-list

- `default`-style (Typst's native style):  `default-enum-list`, `default-enum`, `default-list`
- `paragraph`-style: `paragraph-enum-list`, `paragraph-enum`, `paragraph-list`

By default, the `default-*` methods indent paragraphs after the `label`, while the `paragraph-*` methods align paragraphs with the `label`. See the example below:
#[
  #let test = [
    + #lorem(10)

      #lorem(10)
      + #lorem(10)

        #lorem(10)
      + #lorem(10)
    + #lorem(10)
    - #lorem(10)
      - #lorem(10)
    + - + - #lorem(10)
  ]
  #table(
    columns: (1fr, 1fr),
    [
      default-style
      ```typ
      #set enum(numbering: "(A).(I).(i)")
      #show: el.default-enum-list
      ```
    ],
    [
      paragraph-style
      ```typ
      #set enum(numbering: "(A).(I).(i)")
      #show: el.paragraph-enum-list
      ```
    ],

    [
      #set enum(numbering: "(A).(I).(i)")
      #show: el.default-enum-list.with(auto-base-level: true)
      #test
    ],
    [
      #set enum(numbering: "(A).(I).(i)")
      #show: el.paragraph-enum-list.with(auto-base-level: true)
      #test
    ],
  )
]

The differences between `*-enum-list`, `*-enum`, and `*-list` are:
- `*-enum-list` can uniformly configure both `enum` and `list`, while allowing separate configuration through parameters:
  - `enum-config` for `enum`
  - `list-config` for `list`
- `*-enum` only configures `enum`, leaving nested `list` styles unchanged
- `*-list` only configures `list`, leaving nested `enum` styles unchanged

For details, see @enum-list-feature.

=== Enum Numbering References

To enable this feature, add the following at the beginning of your document:

```typst
#show: el.config.ref
```

In the `enum` items you want to reference, label them with `<some-label>`, and then use `@some-label` to reference the enum number of that item.

Example (taken from: https://github.com/typst/typst/issues/779#issuecomment-2702268234 with minor modification)
#example(
  ```
  #show: el.config.ref.with(supplement: "Item")
  #show link: set text(fill: orange)
  #set enum(numbering: "(E1)", full: true)
  #show: el.default-enum-list

  Group axioms:
  + Associativity <ax:ass>
  + Existence of identity element <ax:id>
  + Existence of inverse element <ax:inv>

  #set enum(numbering: "1.a", full: true)
  #set math.equation(numbering: "(1.1)")
  Another important list:
  + Newton's laws of motion are three physical laws that relate the motion of an object to the forces acting on it.
    + A body remains at rest, or in motion at a constant speed in a straight line, unless it is acted upon by a force.
    + The net force on a body is equal to the body's acceleration multiplied by its mass.
    + If two bodies exert forces on each other, these forces have the same magnitude but opposite directions. <newton-third>
  + Another important force is hooks law: <hook1>
    $ arrow(F) = -k arrow(Delta x). $ <eq:hook> #el.elabel[hook2]
  + $F = m a$ <eq:c> #el.elabel("eq:ma")

  We covered the three group axioms @ax:ass[], @ax:id[] and @ax:inv[].

  It is important to remember Newton's third law @newton-third[], and Hook's law @hook1. In @hook2 we gave Hook's law in @eq:hook. Note that @eq:ma[Conclusion] is a simplified version.
  ```,
)

- [>] Note. For the label `<hook2>`, you cannot directly write `<hook2>`, as this would label `<hook2>` to the equation. Use the method `elabel` to label it. The same applies to `eq:c`.

- The method `elabel(<some-label>)` is equivalent to `elabel("some-label")`, and can sometimes be written as `elabel[some-label]` (provided the latter can be parsed as a string).

For more details, see @ref-num.
=== Resuming Enum Numbering
- To enable this feature, set the `auto-resuming` parameter to `auto` in `*-enum-list` (or `*-enum`).

  - [>] Note: This feature cannot be nested. Do not set `auto-resuming` to `auto` within another.
- Use the method `resume()` to continue using the enum numbers from the previous enum at the same level.

  #example(
    ```
    #show: el.default-enum-list.with(auto-resuming: auto)
    + #lorem(5)
      + #lorem(5)
      + #lorem(5)
      #lorem(5)
    + #lorem(5)
      #el.resume() // -> 3
      + #lorem(5)
      + #lorem(5)
    + #lorem(5)
      + + #lorem(5)
    ```,
  )
- Alternatively, use `resume-label(<some-label>)` to label the enum to resume, then use `resume-list(<some-label>)` in the desired enum to continue numbering.
  - If the following is added to the document:
    ```typst
    #show: el.config.ref-resume
    ```
    You can use `@some-label` instead of `resume-list(<some-label>)`.

  #example(
    ```
    #show: el.config.ref-resume
    #let auto-resume = el.default-enum-list.with(auto-resuming: auto)
    #auto-resume[
      + #lorem(5)
        + #lorem(5)
        + #lorem(5)
        - #lorem(5)
        #el.resume() // continue
        + #lorem(5) #el.resume-label(<resume:demo>)
      #lorem(5)
      @resume:demo // resume the enum labelled with `resume:demo`
      + #lorem(5)
    ]
    ```,
  )

- Alternatively, use `auto-resume-enum(auto-resuming: true)[...]` to ensure all `enum` items within `[...]` continue numbering from the previous items. For example:

  #example(
    ```
    #let resume-enum(doc) = el.default-enum-list(auto-resuming: auto)[
      #el.auto-resume-enum(auto-resuming: true, doc)
    ]
    #resume-enum[
      + #lorem(5)
          + #lorem(5)
          + #lorem(5)
            + #lorem(5)
          - #lorem(5)
          + #lorem(5)
            + #lorem(5)
      #lorem(5)
      + #lorem(5)
    ]
    ```,
  )

=== Terms-like Functionality

Now, you can use the `item` method within a `list` to temporarily change the marker of the current item. For example:

#example(
  ```
  #show: el.default-enum-list
  - #el.item[#sym.ast.square] #lorem(2)
  - #el.item[①] #lorem(2)
  ```,
)
=== Checklist
- To enable this feature, set the `checklist` parameter to `true` in `*-enum-list` (or `*-list`), for example:

  ```typst
  #show: el.default-enum-list.with(checklist: true)
  ```
  Now you can use:
  #example(
    ```typst
    #show: el.default-enum-list.with(checklist: true)
    - [x] checked #lorem(2)
    - [ ] unchecked #lorem(2)
    - [/] incomplete #lorem(2)
    - [-] canceled #lorem(2)
    ```,
  )
- Alternatively, you can enable and configure checklist-related features using the `config.checklist` method:
  ```typst
  #show: el.config.checklist
  ```
  #example(
    ```typst
    #show: el.config.checklist
    #show: el.default-enum-list
    - [x] checked #lorem(2)
    - [ ] unchecked #lorem(2)
    - [/] incomplete #lorem(2)
    - [-] canceled #lorem(2)
    ```,
  )
  For related configuration methods, see @checklist.



== Model <model>

The diagram below illustrates the model for `enum` and `list` in `itemize`.
- `enum` and `list` consist of multiple items.
- Each item is composed of a `label` and a `body`:
  - `label`: The enum number or list marker.
  - `body`: The content following the label.
- Level (`level`): Starts from 1, and increments if an item contains nested items.
- Item index (`n`): Starts from 1. The position of items in the same level.


#import "@preview/lilaq:0.5.0" as lq
#import "@preview/tiptoe:0.3.1"
#let line-arrow(x, y, ..args) = lq.line(
  tip: tiptoe.stealth,
  x,
  y,
  ..args,
)

#[
  #set text(1.2em)
  #show: lq.set-grid(
    stroke: none,
  )
  #set align(center)

  #lq.diagram(
    xaxis: none,
    yaxis: none,
    height: 20cm,
    width: 14cm,
    title: lq.title(position: bottom, [default-enum-list]),
    lq.rect(0, 13, height: 1, width: 10)[#align(center + horizon, [Preceding Text])],
    lq.line((0, 13), (0, 4.5), stroke: (dash: "loosely-dotted", thickness: 1.5pt)),
    lq.line((10, 13), (10, 4.5), stroke: (dash: "loosely-dotted", thickness: 1.5pt)),

    lq.rect(1, 5.5, height: 6.5, width: 8, stroke: (dash: "loosely-dotted", thickness: 1.5pt, paint: red)),
    // lq.line((9, 12), (9, 5.5), stroke: (dash: "loosely-dotted", thickness: 1.5pt, paint: red)),

    // enum-spacing.above
    line-arrow((5, 13), (5, 12)),
    lq.place(5.5, 12.5, align: left)[enum-spacing.above],
    // Item 1: Paragraph 1
    lq.place(0.86, 12.35, align: left)[#text(fill: fuchsia)[label-width]],
    lq.rect(1, 11.5, height: 0.5, width: 1.5, inset: 2pt, stroke: fuchsia)[#align(right + horizon, [label])],
    line-arrow((10, 11.25), (9, 11.25)),
    lq.place(7.9, 11, align: left)[enum-margin],
    lq.plot((2.99, 9, 9, 4, 4, 3, 3), (12, 12, 10.5, 10.5, 11.5, 11.5, 12.015), mark: none, stroke: 1.5pt),
    lq.place(5, 11.25, align: left)[Item 1: Paragraph 1],

    line-arrow((3, 11.75), (2.5, 11.75), stroke: green.darken(30%)),
    lq.place(1.95, 11.25, align: left)[#text(fill: green.darken(30%))[body-indent]],
    line-arrow((4, 10.75), (3, 10.75)),
    lq.place(2.5, 10.25, align: left)[hanging-indent],
    // arrow((1, 11.75), (1.5, 11.75), stroke: orange),
    // lq.place(0., 11.25, align: left)[#text(fill: orange)[label-indent]],
    line-arrow((0, 11.75), (1, 11.75), stroke: purple),
    lq.place(0, 12., align: left)[#text(fill: purple)[indent]],


    // par.spacing
    line-arrow((5, 10.5), (5, 9.5)),
    lq.place(5.5, 10, align: left)[par.spacing],
    // Item 1: Paragraph 2
    lq.plot((5, 9, 9, 4, 4, 5, 5), (9.5, 9.5, 8, 8, 9, 9, 9.515), mark: none, stroke: 1.5pt),
    lq.place(5, 8.75, align: left)[Item 1: Paragraph 2],
    line-arrow((5, 9.25), (3, 9.25)),
    lq.place(1.25, 9.25, align: left)[line-indent],

    // item-spacing
    line-arrow((5, 8), (5, 7)),
    lq.place(5.5, 7.5, align: left)[item-spacing],

    // Item 2: Paragraph
    lq.rect(1, 6.5, height: 0.5, width: 1.5, inset: 2pt, stroke: fuchsia)[#align(right + horizon, [label])],
    lq.plot((3, 9, 9, 4, 4, 3, 3), (7, 7, 5.5, 5.5, 6.5, 6.5, 7.015), mark: none, stroke: 1.5pt),
    lq.place(5, 6.25, align: left)[Item 2: Paragraph],

    // enum-spacing.below
    line-arrow((5, 5.5), (5, 4.5)),
    lq.place(5.5, 5, align: left)[enum-spacing.below],

    lq.rect(0, 3.5, height: 1, width: 10)[#align(center + horizon, [Following Text])],
  )

]


#[
  #set text(1.2em)
  #show: lq.set-grid(
    stroke: none,
  )
  #set align(center)
  #lq.diagram(
    xaxis: none,
    yaxis: none,
    height: 20cm,
    width: 14cm,
    title: lq.title(position: bottom, [The `label-indent` of default-enum-list], label: <label-indent>),
    lq.rect(0, 13, height: 1, width: 10)[#align(center + horizon, [Preceding Text])],
    lq.line((0, 13), (0, 4.5), stroke: (dash: "loosely-dotted", thickness: 1.5pt)),
    lq.line((10, 13), (10, 4.5), stroke: (dash: "loosely-dotted", thickness: 1.5pt)),

    lq.rect(1, 5.5, height: 6.5, width: 8, stroke: (dash: "loosely-dotted", thickness: 1.5pt, paint: red)),
    // lq.line((9, 12), (9, 5.5), stroke: (dash: "loosely-dotted", thickness: 1.5pt, paint: red)),

    // enum-spacing.above
    line-arrow((5, 13), (5, 12)),
    lq.place(5.5, 12.5, align: left)[enum-spacing.above],
    // Item 1: Paragraph 1
    lq.place(1.36, 12.35, align: left)[#text(fill: fuchsia)[label-width]],
    lq.rect(1.5, 11.5, height: 0.5, width: 1.5, inset: 2pt, stroke: fuchsia)[#align(right + horizon, [label])],
    line-arrow((10, 11.25), (9, 11.25)),
    lq.place(7.9, 11, align: left)[enum-margin],
    lq.plot((3.5, 9, 9, 4, 4, 3.5, 3.5), (12, 12, 10.5, 10.5, 11.5, 11.5, 12.015), mark: none, stroke: 1.5pt),
    lq.place(5, 11.25, align: left)[Item 1: Paragraph 1],

    line-arrow((3.5, 11.75), (3, 11.75), stroke: green.darken(30%)),
    lq.place(1.95, 11.25, align: left)[#text(fill: green.darken(30%))[body-indent]],
    line-arrow((4, 10.75), (3, 10.75)),
    lq.place(2.5, 10.25, align: left)[hanging-indent],
    line-arrow((1, 11.75), (1.5, 11.75), stroke: orange),
    lq.place(0., 11.25, align: left)[#text(fill: orange)[label-indent]],
    line-arrow((0, 11.75), (1, 11.75), stroke: purple),
    lq.place(0, 12., align: left)[#text(fill: purple)[indent]],


    // par.spacing
    line-arrow((5, 10.5), (5, 9.5)),
    lq.place(5.5, 10, align: left)[par.spacing],
    // Item 1: Paragraph 2
    lq.plot((5, 9, 9, 4, 4, 5, 5), (9.5, 9.5, 8, 8, 9, 9, 9.515), mark: none, stroke: 1.5pt),
    lq.place(5, 8.75, align: left)[Item 1: Paragraph 2],
    line-arrow((5, 9.25), (3, 9.25)),
    lq.place(1.25, 9.25, align: left)[line-indent],

    // item-spacing
    line-arrow((5, 8), (5, 7)),
    lq.place(5.5, 7.5, align: left)[item-spacing],

    // Item 2: Paragraph
    lq.rect(1.5, 6.5, height: 0.5, width: 1.5, inset: 2pt, stroke: fuchsia)[#align(right + horizon, [label])],
    lq.plot((3.5, 9, 9, 4, 4, 3.5, 3.5), (7, 7, 5.5, 5.5, 6.5, 6.5, 7.015), mark: none, stroke: 1.5pt),
    lq.place(5, 6.25, align: left)[Item 2: Paragraph],

    // enum-spacing.below
    line-arrow((5, 5.5), (5, 4.5)),
    lq.place(5.5, 5, align: left)[enum-spacing.below],

    lq.rect(0, 3.5, height: 1, width: 10)[#align(center + horizon, [Following Text])],
  )


]

#pagebreak()

Code Example:
#example(
  style: "v",
  ```
  #set align(center)
  #set par(justify: true)
  #block(width: 60%, stroke: 1pt + red, inset: 5pt)[
    #set align(left)
    #show: el.default-enum-list.with(
      indent: 1em,
      label-align: right,
      label-width: 3em,
      body-indent: 1em,
      hanging-indent: 2em,
      line-indent: 4em,
      is-full-width: false,
      enum-margin: 4em,
      enum-spacing: 3em,
      item-spacing: 2.5em,
    )
    Preceding Text. #lorem(30)

    1. Item 1: Paragraph 1. #lorem(30)

      Paragraph 2. #lorem(30)

    100. Item 2. #lorem(30)

    Following Text. #lorem(30)
  ]
  ```,
)

