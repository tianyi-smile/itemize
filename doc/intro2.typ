
#import "../lib.typ" as el
#import "helper.typ": *
#import "@preview/lilaq:0.5.0" as lq
#import "@preview/tiptoe:0.3.1"
#let line-arrow(x, y, ..args) = lq.line(
  tip: tiptoe.stealth,
  x,
  y,
  ..args,
)


= Detailed Feature Introduction

== `*-enum-list` Methods <enum-list-feature>

The parameters for `default-enum-list` and `paragraph-enum-list` are similar. The following examples focus on `default-enum-list`.

```typst
#let default-enum-list(
  doc: any,
  // horizontal spacing
  indent: array | auto | function | length = auto,
  body-indent: array | auto | function | length = auto,
  label-indent: array | auto | function | length = auto,
  is-full-width: bool = true,
  enum-margin: array | auto | function | length = auto,
  // vertical spacing
  enum-spacing: array | auto | dictionary | length = auto,
  item-spacing: array | auto | function | length = auto,
  // body style
  hanging-indent: array | auto | function | length = auto,
  line-indent: array | auto | function | length = auto,
  body-format: dictionary | none = none,
  // label style
  ..args: arguments,
  label-align: array | alignment | auto | function = auto,
  label-baseline: auto | dictionary | function | length | "center" | "top" | "bottom" = auto,
  label-width: array | auto | dictionary | function | length = auto,
  label-format: array | function | none = none,

  auto-base-level: bool = false,
  checklist: array | bool = false,
  auto-resuming: auto | bool | none = none,
  auto-label-width: array | bool | "all" | "each" | "list" | "enum" | auto | none | = none,
  // seperate setting of enum and list
  enum-config: dictionary = (:),
  list-config: dictionary = (:),
)
```

This method allows customizing the _labels_ and _bodies_ of enums and lists by *level* and *item*.

=== Horizontal Spacing Settings: `indent`, `body-indent`, `label-indent`, `enum-margin` (`is-full-width`)
- `indent`, `body-indent`: Control the *enum and list indentation* and *spacing* between the `label` and `body` for each level. Unless `auto` is used, these spacings cannot be changed via `#set enum` or `#set list`.
- `is-full-width`: Default is `true`, setting the `body` width to `100%`. This may temporarily fix the bug where block-level equations in the item are not center-aligned in some cases (not an ideal solution).
- `enum-margin`: Controls the *right margin* for each level of enum and list. For this parameter to take effect, #highlight[set `is-full-width` to `false`]. If `auto`, the item width for the current level is `auto` (native `enum` and `list` behavior).
=== Vertical Spacing Settings: `item-spacing`, `enum-spacing`
- `enum-spacing`: Controls the *spacing above and below*  enum and list. Can be
  + a `length` (same spacing above and below)
  + or a `dictionary` with form `(above: len1, below: len2)`.
- `item-spacing`: Controls the *spacing between items* for each level.
- `label-indent`: Sets the *indentation* for the first line of an item. Refer to @model.
=== Label Formatting Settings: `..args(text-style)`, `label-align`, `label-baseline`, `label-width`, `label-format`
- `..args`: Allows passing any named arguments of `text` to format the text style of `label`. Unless `auto` is used, the text style of `label` cannot be changed via `#set text`.
  #example(
    ```
    #show: el.default-enum-list.with(
      fill: (red, purple, auto), // level 1: red, level 2: purple, others: current text color
      size: 1.2em,
      weight: "bold",
    )
    #set text(fill: blue)
    + #lorem(5)
      + + #lorem(5)
    + #lorem(5)
    ```,
  )
- `label-align`: The `alignment` that enum numbers and list markers should have. Unless `auto` is used, it cannot be be changed via `#set enum(number-align: ...)`. For native `list`, it has no such property (default is `right`).

  #example(
    ```
    #show: el.default-enum-list.with(label-align: center)
    + #lorem(5)
    100. #lorem(5)
      - #lorem(5)
      - #el.item[一] #lorem(5)
    + #lorem(5)
    ```,
  )
- `label-baseline`: An amount to shift the label baseline by. It can be taken
  + `length`, `auto` or `"center"`, `"top"`, `"bottom"`
  + or a `dictionary` with the keys:
    - `amount`: `length`, `auto` or `"center"`, `"top"`, `"bottom"`
    - `same-line-style` : `"center"`, `"top"`, `"bottom"`
    - `alone`: `bool`
  - The first case is interpreted as `(amount: len, same-line-style: "bottom", alone: false)`
  - When the label has a paragraph relationship with the first line of text in the current item, the label baseline will shift based on the value of `amount`.
    - For `"center"`, `"top"`, and `"bottom"`, the label will be aligned to the center, top, or bottom respectively.
      - [>] Note. We use the height of the first character (e.g., [A]) in the first line of the paragraph where the label is located. If you manually set the font style of the paragraph's text, this alignment may not be accurate, It is recommended to use the `style` parameter in `body-format` for adjustments.
    - When the value of `amount` is `auto`, set it to `0pt`.
    - If labels from different levels appear on the same line, their alignment is determined by `same-line-style`.
  - If `alone` is `true`, it will not participate in the alignment of labels on the same line.

  #example(
    ```
    #set list(marker: [#emoji.square])
    #show: el.default-enum-list.with(
      size: (1.5em, auto, 2em),
      label-baseline: "top",
    )
    - #lorem(5)
      - - #lorem(5)
    - #lorem(5)
    ```,
  )

  #example(
    ```
    #set list(marker: [#emoji.square])
    #show: el.default-enum-list.with(
      size: (1.5em, auto, 2em),
      label-baseline: "center",
    )
    - #lorem(5)
      - - #lorem(5)
    - #lorem(5)
    ```,
  )

  #example(
    ```
    #set list(marker: [#emoji.square])
    #show: el.default-enum-list.with(
      size: (1.5em, auto, 2em),
      label-baseline: (amount: "center", same-line-style: "center"),
    )
    - #lorem(5)
      - - #lorem(5)
    - #lorem(5)
    ```,
  )

  - [>] Note. This is different for the text-style `baseline`.

  - [>] Note. These settings generally only apply when the label has a paragraph relationship with the first line of text in the current item, and not all cases satisfy this relationship. For example:
    #example(
      ```
      #set list(marker: [#emoji.square])
      #show: el.default-enum-list.with(
        size: (1.5em, auto, 2em),
        label-baseline: 5pt,
      )
      - #lorem(5)
        - - #rect(height: 3em)[#lorem(5)]
      - #lorem(5)
      ```,
    )

    They only appear to be on the same line; in this case, the `amount` value in `label-baseline` usually does not take effect. However, if it is `"center"`, `"top"`, or `"bottom"`, the label will be aligned with the first paragraph of the current item (not the first line), For example:
    #example(
      ```
      #set list(marker: [#emoji.square])
      #show: el.default-enum-list.with(
        size: (1.5em, auto, 2em),
        label-baseline: "center",
      )
      - #lorem(5)
        - - #rect(height: 3em)[#lorem(5)]
      - #lorem(5)
      ```,
    )

- `label-format`: Customize labels in any way. It takes
  - `none`: Does not take effect
  - `function`
    - The form is: `it => ...`, Access
      - `it.body` to get the label content,
      - `it.level` for the current label's level, and
      - `it.n` for the current label's index
      - `it.n-last` for the last index of the current level
    Example:
    #example(
      ```
      #import "@preview/numbly:0.1.0": numbly
      #set enum(
        numbering: numbly(
          "{1:A}",
          "{2:1}.",
          "{3:a})",
        ),
        full: true, // add this if use `numbly`
      )
      #set text(size: 10pt)
      #show: el.default-enum-list.with(
        label-format: it => {
          if it.level == 1 {
            let text-height = measure([A]).height
            set text(size: 20pt, fill: blue, weight: "bold")
            set align(center)
            let number = box(stroke: 1pt + blue, inset: 5pt, width: 25pt)[#it.body]
            let height = measure(number).height
            move(dy: height)[#number]
          } else {
            it.body
          }
        },
        enum-spacing: ((above: 5pt, below: 25pt), auto),
        item-spacing: (-5pt, auto),
        auto-base-level: true,
      )
      #lorem(10)
      + #lorem(10)
        - #lorem(10)
        - #lorem(10)
      + #lorem(15)
        + #lorem(5)
        + + #lorem(5)
          + #lorem(5)
        + #lorem(5)
      + #lorem(15)
      #lorem(10)
      ```,
    )
  - `array`
    - The (`level-1`)-th element of the array applies to the label at the `level`-th level.
    - Each element in the array can be:
      + A `function` with the form `body => ...`, which applies the label's content to this function.
      + A `content`, which outputs this content directly.
      + `auto` or `none`, which means no processing will be done.
      + An `array`:
        - Its elements follow the meanings of 1, 2, and 3 above.
        - The (`n-1`)-th element of the array applies to the `n`-th item's label at the current level.

    #example(
      ```
      #let emoji = (emoji.alien, emoji.book.orange, emoji.butterfly, emoji.cloud.storm, el.LOOP)
      #show: el.default-enum-list.with(
        label-format: (
          emoji,
          box.with(stroke: 1pt + blue, inset: 1pt),
          auto,
        ),
      )
      + #lorem(5)
        + #lorem(5)
          + #lorem(5)
        + #lorem(5)
      + #lorem(5)
      + #lorem(5)
      + #lorem(5)
      + #lorem(5)
      ```,
    )

    - This method can not only control the style of labels, but also control the content displayed by the current label. In the current version `0.2.x`, we recommend using `enum.numbering` (along with the `numbly` package) to control the output content of labels in `enum`, and `list.marker` to control the output content of labels in `list`.

    - [>] Note. We no longer recommend formatting labels using `enum.numbering` as in ver0.1.x, In complex cases, it may also cause "layout did not converge within 5 attempts".
- `label-width`: Sets the width of the label.
  + `auto`: Uses the native behavior. <label-width:auto>
  + `length`: The width of the label. <label-width:len>
  + `dictionary`, with keys:
    - `amount`: `length`, `auto`, or `"max"`.
    - `style`: `"default"`, `"constant"`, `"auto"`, or `"native"`.

    #show: el.config.ref.with(numbering: "1")

    The @label-width:len[Case] is equivalent to `(amount: len, style: "default")`, where `len` is the specified width value; The @label-width:auto[Case] is equivalent to `(amount: max-width, style: "native")`, where `max-width` is the maximum width of labels at the current level.

  Below we explain their differences.
  Let `max-width` be the maximum width of labels at the current level (also affected by `auto-label-width`). Here, `amount` represents the meaning shown in the diagram (i.e., for the default style, the hanging indent length = `amount` + `body-indent`; for the paragraph style, the hanging indent length = `amount`).
  #[
    #set text(1.2em)
    #show: lq.set-grid(
      stroke: none,
    )
    #set align(center)
    #lq.diagram(
      xaxis: none,
      yaxis: none,
      height: 4cm,
      width: 11cm,

      lq.rect(1, 8, height: 4, width: 8, stroke: (dash: "loosely-dotted", thickness: 1.5pt, paint: red)),
      // Item 1: Paragraph 1
      lq.place(0.86, 12.35, align: left)[#text(fill: fuchsia)[label-width]],
      lq.rect(1, 11.5, height: 0.5, width: 1.5, inset: 2pt, stroke: fuchsia)[#align(
        right + horizon,
        [label],
      )],
      lq.plot((2.99, 9, 9, 2.5, 2.5, 3, 3), (12, 12, 10.5, 10.5, 11.5, 11.5, 12.015), mark: none, stroke: 1.5pt),
      lq.line((1.5, 11.5), (1.5, 8), stroke: (dash: "loosely-dotted", thickness: 1.5pt, paint: gray)),
      lq.place(5, 11.25, align: left)[Item 1: Paragraph 1],

      line-arrow((3, 11.75), (2.5, 11.75), stroke: green.darken(30%)),
      lq.place(1.95, 11.25, align: left)[#text(fill: green.darken(30%))[body-indent]],

      line-arrow((1.5, 11), (1, 11), stroke: green.darken(30%)),
      lq.place(0, 10.25, align: left)[#text(fill: green.darken(30%))[body-indent]],

      line-arrow((1.5, 11), (2.5, 11), stroke: red),
      lq.place(1.75, 10.55, align: left)[#text(fill: red)[amount]],

      // arrow((4, 10.75), (3, 10.75)),
      // lq.place(2.5, 10.25, align: left)[hanging-indent],

      // Item 1: Paragraph 2
      lq.plot((2.5, 9, 9, 2.5, 2.5, 2.5, 2.5), (9.5, 9.5, 8, 8, 9, 9, 9.515), mark: none, stroke: 1.5pt),
      lq.place(5, 8.75, align: left)[Item 1: Paragraph 2],
      // arrow((5, 9.25), (3, 9.25)),
      // lq.place(1.25, 9.25, align: left)[line-indent],
    )
  ]
  - When `style` is `"native"`, the label's width is rendered as `max-width`.
    For example:
    #example(
      ```
      #set par(justify: true)
      #el.default-enum-list(
        label-width: (amount: 2em, style: "native"),
        label-format: (box.with(stroke: 1pt + red),box.with(stroke: 1pt + blue),),
      )[
        1. #lorem(10)
        11. #lorem(10)

          #lorem(15)
          - #lorem(15)
          - #lorem(15)
        1111. #lorem(10)
        111111. #lorem(10)
      ]
      ```,
    )
  - When `style` is `"default"`, if the actual width of the current label is less than `amount`, the label's width is rendered as `amount`; otherwise, the label's width is rendered as its actual width. For example:
    #example(
      ```
      #set par(justify: true)
      #el.default-enum-list(
        label-width: (amount: 2em, style: "default"),
        label-format: (box.with(stroke: 1pt + red),box.with(stroke: 1pt + blue),),
      )[
        1. #lorem(10)
        11. #lorem(10)

          #lorem(15)
          - #lorem(15)
          - #lorem(15)
        1111. #lorem(10)
        111111. #lorem(10)
      ]
      ```,
    )
    This behavior is similar to MS-Word and can also serve as a solution for https://github.com/typst/typst/issues/4126.
  - When `style` is `"constant"`, the label's width is rendered as `amount`. For example:
    #example(
      ```
      #set par(justify: true)
      #el.default-enum-list(
        label-width: (amount: 2em, style: "constant"),
        label-format: (box.with(stroke: 1pt + red),box.with(stroke: 1pt + blue),),
      )[
        1. #lorem(10)
        11. #lorem(10)

          #lorem(15)
          - #lorem(15)
          - #lorem(15)
        1111. #lorem(10)
        111111. #lorem(10)
      ]
      ```,
    )
  - When `style` is `"auto"`, the label's width is rendered as its actual width; in this case, the `amount` value affects the hanging indent of the first line. For example:
    #example(
      ```
      #set par(justify: true)
      #el.default-enum-list(
        label-width: (amount: 2em, style: "auto"),
        label-format: (box.with(stroke: 1pt + red),box.with(stroke: 1pt + blue),),
      )[
        1. #lorem(10)
        11. #lorem(10)

          #lorem(15)
          - #lorem(15)
          - #lorem(15)
        1111. #lorem(10)
        111111. #lorem(10)
      ]
      ```,
    )
    This behavior is like `terms`.

    - Specifically, if `amount` is set to `-body-indent`, the next line of all paragraphs will be aligned to the left edge.

    #example(
      ```
      #set par(justify: true)
      #el.default-enum-list(
        body-indent: 1em,
        label-width: (amount: -1em, style: "auto"),
        label-format: (box.with(stroke: 1pt + red),box.with(stroke: 1pt + blue),),
      )[
        1. #lorem(10)
        11. #lorem(10)

          #lorem(15)
          - #lorem(15)
          - #lorem(15)
        1111. #lorem(10)
        111111. #lorem(10)
      ]
      ```,
    )
  - When `amount` is `auto`, the value of `amount` is calculated as the actual width of the current label; specifically:
    - When `style` is `"default"`, `"constant"`, or `"auto"`, the effect is the same:
    #example(
      ```
      #set par(justify: true)
      #el.default-enum-list(
        label-width: (amount: auto, style: "auto"),
        label-format: (box.with(stroke: 1pt + red),box.with(stroke: 1pt + blue),),
      )[
        1. #lorem(10)
        11. #lorem(10)

          #lorem(15)
          - #lorem(15)
          - #lorem(15)
        1111. #lorem(10)
        111111. #lorem(10)
      ]
      ```,
    )

    - When `style` is `"native"`, the effect is:
    #example(
      ```
      #set par(justify: true)
      #el.default-enum-list(
        label-width: (amount: auto, style: "native"),
        label-format: (box.with(stroke: 1pt + red),box.with(stroke: 1pt + blue),),
      )[
        1. #lorem(10)
        11. #lorem(10)

          #lorem(15)
          - #lorem(15)
          - #lorem(15)
        1111. #lorem(10)
        111111. #lorem(10)
      ]
      ```,
    )
  - When `amount` is `"max"`, the value of `amount` is the maximum actual width of labels at the current level.
  - Currently, the setting of `label-width` is also affected by the format of `label-format`, especially when `label-format` specifies width information. In this case, the actual width of the label will be determined by the width specified in `label-format` (usually set via constructs like `box.with(width: ...)`). It is recommended to set the container width in `label-format` to `auto` and then control it via `label-width`.

=== Body formatting settings: `hanging-indent`, `line-indent`, `body-format`
- `line-indent`, `hanging-indent`: Control the *first-line indentation* (excluding the first paragraph) and *hanging indentation* for paragraphs in each level of the enumerations and lists. Unless `auto` is used, paragraph indentation cannot be changed via `#set par`.
- `body-format`: Sets the *text style* and *border style* of the body. It is a dictionary containing the following keys:
  - `none`: Does not take effect.
  - `style`: A dictionary that can include any named arguments of `text` to format the text style of `body`.
  - `whole`, `outer`, `inner`: Dictionaries used to set the borders of the item.
    - `whole`: Wraps the entire `enum` or `list`
    - `outer`: Wraps the item (including the label)
    - `inner`: Wraps the item (excluding the label)
    - If `whole`, `outer`, or `inner` is omitted, the default is to set the border for `outer`.
    - Supported border properties (consistent with `box` borders):
      - `stroke`
      - `radius`
      - `outset`
      - `fill`
      - `inset`
      - `clip`
    - [>] Note. In ver0.2.x, `inset` with `relative` length is temporarily _not supported_!!!
  - Each value in `style`, `whole`, `outer`, `inner` is also supported `array` and `function` types. See @array-p and @function-p.
  #example(
    ```
    #set par(justify: true)
    #el.default-enum-list(
      body-format: (
        whole: (
          stroke: (1pt + purple, auto), // for level 1
          inset: (5pt, auto), // for level 1
        ),
        outer: (
          stroke: (1pt + green, auto), // for level 1
          inset: (5pt, auto),
        ),
        inner: (
          stroke: (1pt + orange, auto), // for level 1
          inset: (5pt, auto), // for level 1
          fill: orange.lighten(90%) // for level 1
        ),
        style: (fill: (red, blue, black)), // level 1: red, level 2: blue, others: black
      )
    )[
        + #lorem(10)
        + #lorem(10)
          - #lorem(5)
          - + #lorem(5)
            + #lorem(5)
        100. #lorem(10)
        - #lorem(5)
          - #lorem(5)
          - #lorem(5)
        - #lorem(5)
    ]
    ```,
  )

  #example(
    ```typst
    #set par(justify: true)
    #el.default-enum-list(
      body-format: (
        outer: (
          stroke: it => {
            let r = calc.rem-euclid(it.n * 40 + it.level * 60, 255)
            let g = calc.rem-euclid(it.n * 50 + it.level * 50, 255)
            let b = calc.rem-euclid(it.n * 20 + it.level * 20, 255)
            color.rgb(r, g, b)
          },
          inset: 5pt,
        ),
      )
    )[
        + #lorem(5)
        + #lorem(5)
          - #lorem(5)
          - + #lorem(5)
            + #lorem(5)
        + #lorem(5)
          - #lorem(5)
    ]
    ```,
  )
=== `auto-label-width`

Typically, the body indentation between different enums and lists cannot be aligned, mainly because the body indentation is related to the actual (maximum) width of the labels.

To ensure consistent first-line indentation of the body across different enums and lists, you can now set `auto-label-width` to `auto` and use the method `auto-label-item` to align the sublists within.
For example:
#example(
  ```
  #el.default-enum-list(
    auto-label-width: auto,
    body-format: (
      whole: (
        stroke: (1pt + red, 1pt + green, auto),
        inset: (5pt, 5pt, auto),
      ),
      inner: (
        stroke: (1pt + orange, 1pt + orange, auto,),
        inset: (5pt, 5pt, auto),
        fill: orange.lighten(90%)
      ),
      style: (fill: (red, blue, black)),
    ),
  )[
    + #lorem(5) // 不参与
      10. #lorem(5)
    #el.auto-label-item(form: "all")[
      // consider as a new enum-list
      + #lorem(5)
        + #lorem(10)
        + #lorem(10)
        - + #lorem(5)
        - + #lorem(5)
        100. #lorem(10)

      #lorem(5)
      10. #lorem(5)
        + #lorem(5)
        #lorem(5)
        1000. #lorem(5)
    ]
    // 不参与
    100. #lorem(5)
      + #lorem(5)
  ]
  ```,
)
- Parameter `form` of the method `auto-label-item`, which can take the following values:
  - `none`: No processing.
  - `"each" == auto`: `Enum` and `list` are considered separately, i.e., align the label in enums and the label in lists independently.
  - `"enum"`: Only align the label in `enum`.
  - `"list"`: Only align the label in `list`.
  - `"all"`: Align the label in both `enum` and `list`.
  - `array`: Each element can be one of the above values, where the value of the `level-1`-th element represents the alignment method for the label at the `level`-th level.
  - [>] Note. The method `auto-label-item` cannot be nested.

  #example(
    ```
    #el.default-enum-list(
      auto-label-width: auto,
      body-format: (
        whole: (
          stroke: (1pt + red, 1pt + green, auto),
          inset: (5pt, 5pt, auto),
        ),
        inner: (
          stroke: (1pt + orange, 1pt + orange, auto,),
          inset: (5pt, 5pt, auto),
          fill: orange.lighten(90%)
        ),
        style: (fill: (red, blue, black)),
      ),
    )[
      #el.auto-label-item(form: ("all", "each"))[
        // consider as a new enum-list
        + #lorem(5)
          + #lorem(10)
          + #lorem(10)
          - + #lorem(5)
          - + #lorem(5)
          100. #lorem(10)
        + #lorem(5)
        #lorem(5)
        - #lorem(5)
        10. #lorem(5)
      ]
    ]
    ```,
  )
- To align the body indentation throughout the entire document, simply add the following at the beginning of the document:

  ```typst
  #show : el.default-enum-list.with(auto-label-width: "all")
  ```
  The values and meanings of `auto-label-width` are the same as those of the `form` parameter in the `auto-label-item` method.
  - [>] Note. `auto-label-width` can be set once for non `auto` or `none`.

  - [>] Note. In a document, `auto-label-width` only retrieves the actual maximum width of labels at the current level of enums and lists.

=== Passing `array` to Parameters <array-p>

If a method in the `itemize` package accepts an `array` type parameter, then:
- Each element controls the style for the corresponding level of the enum and list.
- The last element's value applies to subsequent levels.
- [N] If the last element of the array is `LOOP`, the values in the array will be used cyclically.
- If the parameter applies to each item, each element in the array can also be an array, where each element applies to the corresponding item.
For example:
#example(
  ```
  #show: el.default-enum-list.with(
    fill: (yellow, blue, auto, el.LOOP),
    weight: "bold",
    body-format: (
      style: (
        fill: (red, (purple, green, el.LOOP), black),
      ),
    ),
  )
  + Level1 One
  + Level1 Two
    + Level2-1
      - Level3 #lorem(5)
        - Level4 #lorem(5)
      - Level3 #lorem(5)
    + Level2-2
      + Level3 #lorem(5)
        + Level4 #lorem(5)
        + Level4 #lorem(5)
    + Level2-3
    + Level2-4
  + Level1 Three
  ```,
)
The meaning is:
- Label styles:
  - Levels 1-3: `yellow`, `blue`, `green`, the current text color (due to `auto`), then cyclically used (because the last element of the array is `LOOP`). Specifically, level 4: `yellow`.
  - All levels: Bold weight.
  - Level 1: `15pt` font size; subsequent levels: `12pt`.
- Body styles:
  - Level 1: `red`.
  - Level 2:
    - First item: `purple`.
    - Second item: `green`.
    - Then cyclically used (because the last element of the array is `LOOP`).
  - Remaining levels: `black`

=== Passing `function` to Parameters <function-p>

If a method in the `itemize` package accepts a `function` type parameter, its form is:

```typst
it => ...
```

- The meaning is:

  - The return value will be used for each level and item.

    - If the return value is an `array`, it will be used for each item.
    - [>] Note. So the parameter taking `array` and `it => array` has different meanings. The parameter taking `array` is used for each level, while the parameter taking `it => array` is used for each item.

  - The parameter `it` in this method typically provides three properties:
    - `level`: The current level;
    - `n`: The current index;
    - `n-last`: The index of the last item in the current level.


- For horizontal spacing parameters (`indent`, `body-indent`, `hanging-indent`, `line-indent`, `label-indent`), `it` also provides additional properties:
  - `label-width`: Captures the label width for levels 1 to the current level.
    - Use `(it.label-width.get)(some-level)` to get the max label width at `some-level`.
    - Or `it.label-width.current` for the current level (equivalent to `(label-width.get)(level)`).
  - `e`: Captures the construction (`enum` or `list`) for levels 1 to the current level. Use `(it.e.get)(some-level)` or `it.e.current`.
  - [!] *Breaking Change*. In ver0.1.x, the `function` form here was:
    ```typst
    (level, label-width, level-type) => length | auto
    ```
    This syntax is no longer supported in ver0.2.x. Now, the unified approach is to use `it.***` for access.

  Here's an example using a `function` to align all `label`s to the left:

  #example(
    ```
    #let ex1 = [
      + #lorem(10)
      + #lorem(10)
        + #lorem(10)
          + #lorem(10)
            + #lorem(10)
          + #lorem(10)
      + #lorem(10)
    ]
    #table(
      rows: 2,
      [
        #set enum(numbering: "(A).(I).(i)", full: true, number-align: left)
        #show: el.default-enum-list
        #ex1
      ],
      [
        #set enum(numbering: "(A).(I).(i)", full: true, number-align: left)
        #let indent-f = it => {
          if it.level >= 2 {
            -(it.label-width.get)(it.level - 1) - (it.e.get)(it.level - 1).body-indent
          } else {
            auto
          }
        }
        #show: el.default-enum-list.with(indent: indent-f)
        #ex1
      ],
    )
    ```,
  )

  Here is another example.

  #example(
    ```
    #let number = (a, b) => {
      (calc.rem-euclid(a * 100 + b * 50, 255), calc.rem-euclid(a * 2 + b * 5, 255), calc.rem-euclid(a * 10 + b * 60, 255))
    }
    #show: el.default-enum-list.with(
      size: it => {
        (it.level + it.n)* 5pt
      },
      body-format: (
        style: (
          fill: it => color.rgb(..number(it.level, it.n)),
          size: it => (10pt, 12pt, 16pt) // The each size of 1-4-th item's body is 10pt, 12pt, 16pt, and others are 16pt.
        ),
      ),
    )
    + #lorem(10)
    + #lorem(10)
      + #lorem(10)
        + #lorem(10)
        + #lorem(10)
      + #lorem(10)
    + #lorem(10)
    ```,
  )

=== `enum-config` and `list-config`
When using the `*-enum-list` method, you can configure `enum` and `list` separately
- `enum-config`: Only applies to `enum`
- `list-config`: Only applies to `list`

- The parameter type is a dictionary, and the currently allowed properties (keys) are:
  - `indent`,
  - `body-indent`,
  - `label-indent`,
  - `is-full-width`,
  - `item-spacing`,
  - `enum-spacing`,
  - `enum-margin`,
  - `hanging-indent`,
  - `line-indent`,
  - `label-width`,
  - `label-align`,
  - `label-baseline`,
  - `label-format`,
  - `body-format`,
  - any named arguments of the function of `text`
- Rules: If both `*-enum-list` and `enum-config` (`list-config`) have the same property set, the rules are:
  - The settings in `enum-config` (`list-config`) take precedence.
  - For properties of function type, a composite operation is used, where the inner function is provided by `enum-config` (`list-config`):
    - `label-format`, `item-format`
  - For properties that are dictionaries composed of multiple attributes, these attributes are merged, and if the same attribute exists, the value from `enum-config` (`list-config`) is used.
    - `body-format`

#example(
  ```
  #set enum(numbering: "A.a.1")
  #show: el.default-enum-list.with(
    indent: (0.5em, 0em),
    label-format: it => {
      if it.level == 1 {
        box(inset: 2pt, fill: blue.lighten(80%))[#it.body]
      } else {
        strong[#it.body]
      }
    },
    body-format: (
      style: (fill: (red, black)),
    ),
    enum-config: (
      fill: (blue, red, purple, el.LOOP),
      label-baseline: "center",
      label-format: it => {
        set align(center + horizon)
        box(stroke: 1pt + blue, inset: 2pt, radius: 1em, width: 1.2em, height: 1.2em)[#it.body]
      },
      body-format: (
        outer: (
          stroke: ((left: 2pt + blue), auto),
        ),
      ),
    ),
    list-config: (
      fill: green,
      label-align: center,
    ),
  )
  + #lorem(5)
    + #lorem(5)
      + #lorem(5)
      + #lorem(5)
        - #lorem(5)
        - #lorem(5)
        - #el.item[Item] #lorem(5)
        - #el.item[Item] #lorem(5)
    + #lorem(5)
    - #lorem(5)
  + #lorem(5)
  ```,
)

=== `auto-base-level`

- [>] In ver0.1.x, we used absolute levels, meaning `*-enum-list`, `*-enum`, and `*-list` always used absolute levels for configuration, rather than treating the current level as 1. This was not intuitive.
- [!] *Breaking change* Now in ver0.2.x, each time you use `*-enum-list`, `*-enum`, or `*-list` to configure `enum` and `list`, the current level is treated as 1.
#example(
  style: "v",
  ```
  #table(
    columns: (1fr, 1fr),
    [ver0.1.x], [ver0.2.x],
    [
      #import "@preview/itemize:0.1.2"
      #show: itemize.default-enum-list
      + $vec(1, 1, 1)$
        + #lorem(4)
          #show: itemize.default-enum-list.with(fill: (red, blue, yellow))
          // colored by yellow
          + #lorem(4)
            + #lorem(4)
          + #lorem(4)
        + #lorem(4)
      + #lorem(4)
    ],
    [
      #show: el.default-enum-list
      + $vec(1, 1, 1)$
        + #lorem(4)
          #show: el.default-enum-list.with(fill: (red, blue, yellow))
          // colored by red
          + #lorem(4)
            // colored by blue
            + #lorem(4)
          + #lorem(4)
        + #lorem(4)
      + #lorem(4)
    ],
  )
  ```,
)
- To maintain compatibility with native behavior, the display of `numbering` and `marker` still uses absolute levels. This means even if you reconfigure `enum.numbering` and `list.marker` in sublists, the display of `numbering` and `marker` in sublists follows the absolute level rules.
  - If `auto-base-level` is set to `true`, then it treats the current level as 1.
  - Note the difference when `enum.full` is set to `true` (only affects the current sublist).

#example(
  style: "v",
  ```
  #table(
    columns: (1fr, 1fr),
    [native (`auto-base-level`: `false`)], [`auto-base-level`: `true`],
    [
      #show: el.default-enum-list
      + $vec(1, 1, 1)$
        + #lorem(4)
          #set enum(numbering: "1.a.i.")
          #show: el.default-enum-list.with(fill: (red, blue, yellow))
          + #lorem(4)
            + #lorem(4)
          + #lorem(4)
        + #lorem(4)
      + #lorem(4)
    ],
    [
      #show: el.default-enum-list
      + $vec(1, 1, 1)$
        + #lorem(4)
          #set enum(numbering: "1.a.i.")
          #show: el.default-enum-list.with(fill: (red, blue, yellow), auto-base-level: true)
          + #lorem(4)
            + #lorem(4)
          + #lorem(4)
        + #lorem(4)
      + #lorem(4)
    ],
  )
  ```,
)

#example(
  style: "v",
  ```
  #table(
    columns: (1fr, 1fr),
    [native (`auto-base-level`: `false`, `full: true`)], [`auto-base-level`: `true`, `full: true`],
    [
      #show: el.default-enum-list
      + $vec(1, 1, 1)$
        + #lorem(4)
          #set enum(numbering: "1.a.i.", full: true)
          #show: el.default-enum-list.with(fill: (red, blue, yellow))
          + #lorem(4)
            + #lorem(4)
          + #lorem(4)
        + #lorem(4)
      + #lorem(4)
    ],
    [
      #show: el.default-enum-list
      + $vec(1, 1, 1)$
        + #lorem(4)
          #set enum(numbering: "1.a.i.", full: true)
          #show: el.default-enum-list.with(fill: (red, blue, yellow), auto-base-level: true)
          + #lorem(4)
            + #lorem(4)
          + #lorem(4)
        + #lorem(4)
      + #lorem(4)
    ],
  )
  ```,
)
