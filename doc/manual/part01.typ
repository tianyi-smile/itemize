#import "../helper.typ": *

#let colors = splash.seaborn.dark.values()
#show: el.default-enum-list.with(
  fill: colors,
  checklist: true,
  tight-mode: ("never-tight", auto),
  tight-item-mode: "always-tight",
  description-config: (
    term-format: (strong,),
    // separator: it => {
    //   if it.style == "plain" { [#strong([:]) ] } else { auto }
    // },
  ),
)

== Features

- [N] *New features* in version 0.3.0.
- [E] *Enhancements* in version 0.3.0.
- [!] *Breaking changes* in version 0.3.0.
- [M] *Minor changes* in version 0.3.0.

Using `itemize`, you can customize the _label_\s and _bodie_\s of #m.builtin("enum") and #m.builtin("list") for each *level* and each *item*. Currently, the package offers the following features:
- / Item label formatting:
    - Setting the _text style_ of item label: @cmd:default-enum-list.args
    - Setting the indentation for the label: @cmd:default-enum-list.label-indent
    - Label alignment: @cmd:default-enum-list.label-align
    - [N] Horizontal movement of the label: @cmd:default-enum-list.label-inset
    - [E] Vertical movement of the label: @cmd:default-enum-list.label-baseline
    - Setting the label width: @cmd:default-enum-list.label-width
      - Allow different #m.builtin("enum") and #m.builtin("list") to share the maximum label width: @cmd:default-enum-list.auto-label-width
    - Formatting the label in any way: @cmd:default-enum-list.label-format
      - [N] Support setting the _border_ of the label.
    - [N] Setting the step size for #m.builtin("enum") numbers: @cmd:default-enum-list.step
- / Item body formatting:
    - Setting the indentation between the item label and the item body: @cmd:default-enum-list.body-indent
    - [N] Setting the item body margin: @cmd:default-enum-list.body-margin
      - [!] Removed `enum-margin` and `is-full-width` (the latter can be achieved with `body-format: (whole: (width: 100%))`).
    - Formatting the body in any way: @cmd:default-enum-list.body-format
      - [!] `item-format` is removed; use `body-format` instead.
- / Horizontal spacing setting:
    - The indentation of the item: @cmd:default-enum-list.indent
      - [M] The border of the whole item will be affected by this setting.
- / Vertical spacing setting:
    - Setting the above and below spacing of whole #m.builtin("enum") or #m.builtin("list"): @cmd:default-enum-list.whole-spacing
      - [N] Configure compact mode: @cmd:default-enum-list.tight-mode
      - [N] Use the configuration method @cmd:config:auto-detect-tight to enable the compact mode between the list and the paragraph below it.
      - [!] `enum-spacing` is renamed to `whole-spacing`.
    - [E] Setting the above and below spacing of each item: @cmd:default-enum-list.item-spacing
      - [N] Configure compact mode: @cmd:default-enum-list.tight-item-mode
- / Body paragraph setting:
    - [N] Setting the indentation of the first line for first paragraph in item body: @cmd:default-enum-list.first-line-inset
    - Setting the line indentation and hanging indentation for paragraphs in item body: @cmd:default-enum-list.line-indent, @cmd:default-enum-list.hanging-indent
      - [N] For the `default-*` methods, add @cmd:default-enum-list.hanging-type to set the hanging indent type.
      - [M] The `line-indent` and `hanging-indent` parameters are independent of `par.first-line-indent`, `par.hanging-indent`.
      - [!] Paragraphs inside `block-level` elements that appear in the item body are not processed.
- / Referencing #m.builtin("enum") number and item label:
    - Enable references to #m.builtin("enum") numbers by configuring through the method @cmd:config:ref.
      - [N] Support relative form references.
    - [N] Allow using @cmd:default-enum-list.ref-numbering and @cmd:default-enum-list.supplement to set citation styles for different #m.builtin("enum")s.
    - [N] Support referencing item labels for #m.builtin("enum") and #m.builtin("list").
- / Resuming #m.builtin("enum") number:
    - Enable through the parameter @cmd:default-enum-list.auto-resuming, and use in conjunction with the methods @cmd:resume, @cmd:resume-label, @cmd:resume-list, @cmd:auto-resume-enum.
- / Different styles of description list:
    - Checklist: Enable through the parameter @cmd:default-enum-list.checklist, and configure through the method @cmd:config:checklist.
    - [E] Terms-like description list: Change the item label of the current item (#m.builtin("list") or #m.builtin("enum")) using the @cmd:item method.
    - [N] Horizontal description list, hanging description list, stacked description list, plain description list
      - Using the syntax `+ / term: description` and `- / term: description`
      - Configure through the argument @cmd:default-enum-list.description-config.
- [N]
  / Inline list: Interpret the list content as paragraphs: @cmd:inline-enum-list (@cmd:inline-enum, @cmd:inline-list)
- / Individual setting:
    - [N] Set the style for the current item separately through the @cmd:item method.
    - [N] Use @cmd:item to set `tag` and `elem-tag` attributes, then format items or lists with these attributes.
- [N]
  / Initial support for RTL typesetting:


#let colors = splash.seaborn.dark.values()
#show: el.inline-enum-list.with(
  fill: colors,
  checklist: true,
  tight-mode: ("never-tight", auto),
  tight-item-mode: "always-tight",
  description-config: (
    term-format: (strong,),
    // separator: it => {
    //   if it.style == "plain" { [#strong([:]) ] } else { auto }
    // },
  ),
)


== Override #m.builtin("enum") and #m.builtin("list")

The `itemize` package primarily provides the following methods to override the native #m.builtin("enum") and #m.builtin("list"):

- `default`-style (Typst's native style):  @cmd:default-enum-list, @cmd:default-enum, @cmd:default-list
- `paragraph`-style: @cmd:paragraph-enum-list, @cmd:paragraph-enum, @cmd:paragraph-list
  - This is equivalent to using `default-enum-list.with(hanging-type: "paragraph")`.
- `inline`-style: @cmd:inline-enum-list, @cmd:inline-enum, @cmd:inline-list
  - Any `block-level` elements appearing in the item body are laid out flush left.
  - Contents at every level of the list span the full width of the parent container.
  - Because of this paragraph behavior, some features of `default-enum-list` (`default-enum`, `default-list`) no longer take effect (`label-baseline`, `border` of `body-format`, `body-margin`, `auto-label-width`, and `auto-resuming`).

You can freely customize the styles of #m.builtin("enum") and #m.builtin("list") through the parameters provided by these methods.

By default, the `default-*` methods indent paragraphs after the item label, while the `paragraph-*` methods align paragraphs with the item label.
`inline-*` methods interpret the list content as paragraphs.

#warning-alert[
  `itemize` currently does not support exporting to HTML format (see https://github.com/tianyi-smile/itemize/issues/18).
]

See the examples below:
#[
  #let test = [
    + #lorem(8)

      #lorem(8)
      + #lorem(8)

        #lorem(8)
      + #lorem(8)
    + #lorem(8)
    - #lorem(8)
      - #lorem(8)
    + - + - #lorem(8)
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
      #show: el.default-enum-list
      #test
    ],
    [
      #set enum(numbering: "(A).(I).(i)")
      #show: el.paragraph-enum-list
      #test
    ],
  )
]

#[
  #let test = [
    #set block(stroke: red) // debug
    #lorem(8)
    $
      a^2 + b^2 = c^2
    $
    + #lorem(8)
      $
        a^2 + b^2 = c^2
      $
      #lorem(8)
      + #lorem(8)

        #lorem(8)
      + #lorem(8)
        #block[*Block:* #lorem(8)]
    + #lorem(8)
    - #lorem(8)
      - #lorem(8)
    + - + - #lorem(8)
  ]
  #table(
    columns: (1fr, 1fr),
    [
      default-inline
      ```typ
      #set enum(numbering: "(A).(I).(i)")
      #show: el.inline-enum-list
      ```
    ],
    [
      paragraph-inline
      ```typ
      #set enum(numbering: "(A).(I).(i)")
      #show: el.inline-enum-list.with(hanging-type: "paragraph")
      ```
    ],

    [
      #set enum(numbering: "(A).(I).(i)")
      #show: el.inline-enum-list
      #test
    ],
    [
      #set enum(numbering: "(A).(I).(i)")
      #show: el.inline-enum-list.with(hanging-type: "paragraph")
      #test
    ],
  )
]

#info-alert[
  The differences between `*-enum-list` (@cmd:default-enum-list, @cmd:paragraph-enum-list, @cmd:inline-enum-list), `*-enum` (@cmd:default-enum, @cmd:paragraph-enum, @cmd:inline-enum), and `*-list` (@cmd:default-list, @cmd:paragraph-list, @cmd:inline-list) are:
  - `*-enum-list` shares the same level counter of #m.builtin("enum") and #m.builtin("list"), and can uniformly configure both #m.builtin("enum") and #m.builtin("list"), while allowing separate configuration through parameters:
    - `enum-config` for #m.builtin("enum") (@cmd:default-enum-list.enum-config);
    - `list-config` for #m.builtin("list") (@cmd:default-enum-list.list-config).
  - `*-enum` only configures #m.builtin("enum"), leaving nested #m.builtin("list") styles unchanged.
  - `*-list` only configures #m.builtin("list"), leaving nested #m.builtin("enum") styles unchanged.
]



== Model

The diagram below illustrates the model for #m.builtin("enum") and #m.builtin("list") in `itemize`.
- #m.builtin("enum") and #m.builtin("list") consist of multiple items.
- Each item is composed of a `label` and a `body`:
  - `label` (`item label`): The enum number or list marker
    - Also, including the spacings: `label-indent`, `body-indent`.
  - `body` (`item body`): The content following the label.
- Level (`level`): Starts from 1, and increments if an item contains nested items.
- Item index (`n`): Starts from 1. The index of items in the same level.

#info-alert[
  #m.changed((0, 3, 0)) Now (since version 0.3.0), each of the `default-*`, `paragraph-*`, and `inline-*` methods will have a separately maintained level counter. When the method is used, its level will start counting from 1 again. If you want to use the level counting from `itemize 0.2.0` (where a single level counter is maintained throughout the entire document), you need to set the parameter `auto-base-level` (@cmd:default-enum-list.auto-base-level) to `false`.
]

#info-alert[
  In `itemize`, the #strong([level])s of #m.builtin("enum") and #m.builtin("list") are divided into the following concepts:
  - `absolute level`: includes both #m.builtin("enum") and #m.builtin("list"); each level of nesting increases the level by 1, for example:
    ```typ
    + level one
      - level two
        + level three
      Paragraph
      + level two
    - level one
    ```
  - `relative enum level`: only counts the nesting levels of #m.builtin("enum");
  - `relative list level`: only counts the nesting levels of #m.builtin("list").
    ```typ
    + enum level one
      - list level one
        + enum level two
        - list level two
      Paragraph
      + enum level two
        - list level one
    - list level one
      + enum level one
    ```
]
#info-alert[
  - Each `*-enum-list` method independently maintains the `absolute level`, `relative enum level`, and `relative list level`. The levels within the method use the `absolute level`; additionally, the `enum-config` parameter uses the `relative enum level`, and the `list-config` parameter uses the `relative list level`.
  - The implementation does not use Typst's `counter` or `state` (to avoid one extra layout iteration).
  - Each `*-enum` method independently maintains the `relative enum level`; the levels within the method use the `relative enum level`.
  - Similarly, each `*-list` method independently maintains the `relative list level`; the levels within the method use the `relative list level`.
]
// TODO
#import "@preview/lilaq:0.6.0" as lq
#import "@preview/tiptoe:0.4.0"
#let line-arrow(x, y, ..args) = lq.line(
  tip: tiptoe.stealth,
  x,
  y,
  ..args,
)

#[
  #show: lq.set-grid(
    stroke: none,
  )
  #set align(center)
  #lq.diagram(
    xaxis: none,
    yaxis: none,
    height: 20cm,
    width: 14cm,
    title: lq.title(position: bottom, [@cmd:default-enum-list]),
    lq.rect(0, 13, height: 1, width: 10)[#align(center + horizon, [Preceding Text])],
    lq.line((0, 13), (0, 4.5), stroke: (dash: "loosely-dotted", thickness: 1.5pt)),
    lq.line((10, 13), (10, 4.5), stroke: (dash: "loosely-dotted", thickness: 1.5pt)),

    lq.line((3, 12), (3, 5.5), stroke: (dash: "loosely-dotted", thickness: 1.5pt, paint: fuchsia)),

    lq.rect(1, 5.5, height: 6.5, width: 8, stroke: (dash: "loosely-dotted", thickness: 1.5pt, paint: red)),

    // enum-spacing.above
    line-arrow((5, 13), (5, 12)),
    lq.place(5.5, 12.5, align: left)[#show link: set text(fill: black); @cmd:default-enum-list.whole-spacing[!].above],
    // Item 1: Paragraph 1
    lq.place(1.2, 12.25, align: left)[#show link: set text(fill: fuchsia); @cmd:default-enum-list.label-width[!]],
    lq.rect(1.5, 11.5, height: 0.5, width: 1, inset: 2pt, stroke: fuchsia)[#align(right + horizon, [label])],

    lq.line((1.5, 12), (1.5, 11.5), stroke: (dash: "loosely-dotted", thickness: 1.5pt, paint: fuchsia)),
    line-arrow((1, 11.75), (1.5, 11.75), stroke: green),
    lq.place(0.1, 11.25, align: left)[#show link: set text(fill: green); @cmd:default-enum-list.label-indent[!]],

    line-arrow((10, 8.75), (9, 8.75)),
    lq.place(7.9, 8.5, align: left)[#show link: set text(fill: black); @cmd:default-enum-list.body-margin[!].right],

    line-arrow((1, 8.75), (3, 8.75)),
    lq.place(0.8, 8.5, align: left)[#show link: set text(fill: black); @cmd:default-enum-list.body-margin[!].left],

    lq.plot((2.99, 9, 9, 4, 4, 3, 3), (12, 12, 10.5, 10.5, 11.5, 11.5, 12.015), mark: none, stroke: 1.5pt),
    lq.place(5, 11.25, align: left)[Item 1: Paragraph 1],

    line-arrow((3, 11.75), (2.5, 11.75), stroke: green.darken(30%)),
    lq.place(1.95, 11.25, align: left)[#show link: set text(
        fill: green.darken(30%),
      ); @cmd:default-enum-list.body-indent[!]],
    line-arrow((4, 10.75), (3, 10.75)),
    lq.place(2.5, 10.25, align: left)[@cmd:default-enum-list.hanging-indent[!]],

    line-arrow((0, 11.75), (1, 11.75), stroke: purple),
    lq.place(0, 12., align: left)[#show link: set text(fill: purple); @cmd:default-enum-list.indent[!]],

    // par.spacing
    line-arrow((5, 10.5), (5, 9.5)),
    lq.place(5.5, 10, align: left)[par.spacing],
    // Item 1: Paragraph 2
    lq.plot((5, 9, 9, 4, 4, 5, 5), (9.5, 9.5, 8, 8, 9, 9, 9.515), mark: none, stroke: 1.5pt),
    lq.place(5, 8.75, align: left)[Item 1: Paragraph 2],
    line-arrow((5, 9.25), (3, 9.25)),
    lq.place(3.25, 9.5, align: left)[@cmd:default-enum-list.line-indent[!]],

    // item-spacing
    line-arrow((5, 8), (5, 7)),
    lq.place(5.5, 7.5, align: left)[@cmd:default-enum-list.item-spacing[!]],

    // Item 2: Paragraph
    lq.rect(1.5, 6.5, height: 0.5, width: 1, inset: 2pt, stroke: fuchsia)[#align(right + horizon, [label])],
    lq.plot((3, 9, 9, 4, 4, 3, 3), (7, 7, 5.5, 5.5, 6.5, 6.5, 7.015), mark: none, stroke: 1.5pt),
    lq.place(5, 6.25, align: left)[Item 2: Paragraph],

    // enum-spacing.below
    line-arrow((5, 5.5), (5, 4.5)),
    lq.place(5.5, 5, align: left)[#show link: set text(fill: black); @cmd:default-enum-list.whole-spacing[!].below],

    lq.rect(0, 3.5, height: 1, width: 10)[#align(center + horizon, [Following Text])],
  )

]


#pagebreak()

Code Example:
#example(read("../example/default-enum-list-args.typ"))
