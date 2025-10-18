
#import "../lib.typ" as el
#import "helper.typ": *


== Referencing Enum Numbers <ref-num>
- To enable this feature, use the following at the beginning of the document:

  ```typst
  #show: el.config.ref
  ```

- [>] Note. The method `ref-enum` in `itemize 0.1.x` will be deprecated in the furture; please use `config.ref` instead.

In the enum item you want to reference, label it with `<some-label>`, and then use `@<some-label>` to reference the enum number of that item.

- [>] Note. If the enum number cannot be retrieved correctly, use the method `elabel(<some-label>)` to label the enum.

#example(
  ```
  #show: el.config.ref
  #set enum(numbering: "(1).(a)")
  #show: el.default-enum-list
  + #lorem(10)
    + #lorem(10)
    + $a^2+b^2 = c^2$ #el.elabel(<item:eq>)
  + #lorem(10) <item:one>
  The Conclusion @item:one and the equation in @item:eq[Item] are important.
  ```,
)

- Configuration Method: The `config.ref` Method
  - `full: auto | bool = auto`: Default is `auto`, using the `full` value from `enum`. `true` displays the full number (including parent levels); `false` displays only the current item's number.
  - `numbering: auto | function | str = auto`: Numbering pattern or formatter. Default is `auto`, using the `numbering` of the referenced `enum`. You can customize the style of the referenced item number.
  - `supplement: any | auto = auto`. Supplemental content for the reference.

  #example(
    ```
    #show: el.config.ref.with(numbering: "1.a", supplement: "Item", full: true)
    #set enum(numbering: "(1).(a)")
    #show: el.default-enum-list
    + #lorem(10)
      + #lorem(10)
      + $a^2+b^2 = c^2$ #el.elabel(<item:eq2>)
    + #lorem(10) <item:two>
    The @item:two and the equation in @item:eq2[Item] are important.
    ```,
  )
== Resuming Enum
Related to this feature is the parameter `auto-resuming` in the methods `*-enum-list` (or `*-enum`), which can take the following values:
- `none`: Disables this feature.
- `auto`: Enables this feature.
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
    - You can also use `resume[...]` to explicitly continue using the enum numbers from the previous level (especially in ambiguous cases) and treat the `[...]` as a new `enum`. For example:
    #example(
      ```
      #show: el.default-enum-list.with(auto-resuming: auto)
      + #lorem(5)
        + #lorem(5)
        + #lorem(5)
        #lorem(5)
      + #lorem(5)
        #el.resume()[
          // consider as a new enum
          + #lorem(5)
          + #lorem(5)
        ] // -> 3
        + #lorem(5)
      + #lorem(5)
      ```,
    )

  - Alternatively, use the method `resume-label(<some-label>)` to label the enum you want to resume, and then use `resume-list(<some-label>)` in the desired enum to continue using the labelled enum numbers.
    - If you use the following in your document:
      ```typst
      #show: el.config.ref-resume
      ```
      You can use `@some-label` instead of `resume-list(<some-label>)`.

    #example(
      ```
      #show: el.default-enum-list.with(auto-resuming: auto)
      + #lorem(5)
        + #lorem(5) #el.resume-label(<resume:a>)
        + #lorem(5)
        + #lorem(5)
        #lorem(5)
      + #lorem(5)
      #lorem(5)
      #el.resume-list(<resume:a>) // -> 4
      + #lorem(5)
      ```,
    )

    #example(
      ```
      #show: el.config.ref-resume
      #show: el.default-enum-list.with(auto-resuming: auto)
      + #lorem(5) #el.resume-label(<resume:level-1>)
        + #lorem(5)
        + #lorem(5)
        #lorem(5)
      + #lorem(5)
        @resume:level-1 // -> 4
        + #lorem(5)
      + #lorem(5)
      ```,
    )

  - Or use the method `auto-resume-enum(auto-resuming: true)[...]`, where all enum numbers within `[...]` will continue from the previous ones.
    - `auto-resuming` can also be an array, where each element indicates whether the enum numbers for the corresponding level should continue from the previous ones.
    #example(
      ```
      #show: el.default-enum-list.with(auto-resuming: auto)
      + #lorem(5)
        #el.auto-resume-enum(auto-resuming: (false, true))[
          // resume sublist from the level 2
          + #lorem(5)
          + #lorem(5)
            + #lorem(5)
          #lorem(5)
          + #lorem(5)
            + #lorem(5)
        ]
      #lorem(5)
      + #lorem(5)
        + #lorem(5)
      ```,
    )
  - The method `isolated-resume-enum[...]` allows the `[...]` to be treated as a new enum with independent numbering, without affecting other enums.
  #example(
    style: "v",
    ```
    #table(
      columns: (1fr, 1fr),
      [Case 1], [Case 2],
      [
        #show: el.default-enum-list.with(auto-resuming: auto)
        + #lorem(5)
          + enumA #lorem(5)
            + enumB #lorem(5)
            + enumB #lorem(5)
          + #lorem(5)
          + #lorem(5)
            + #lorem(5)
            + #lorem(5)
            + #lorem(5)
          #lorem(5)
          #el.resume() // -> 4
          + #lorem(5)
            #el.resume() // -> 4
            + #lorem(5)
        + #lorem(5)
      ],
      [
        #show: el.default-enum-list.with(auto-resuming: auto)
        + #lorem(5)
          + enumA #lorem(5)
            + enumB #lorem(5)
            + enumB #lorem(5)
          #el.isolated-resume-enum()[
            // isolated sub-enum
            + #lorem(5)
            + #lorem(5)
              + #lorem(5)
              + #lorem(5)
              + #lorem(5)
          ]
          #lorem(5)
          // resume enumA
          #el.resume() // -> 2
          + #lorem(5)
            // resume enumB
            #el.resume() // -> 3
            + #lorem(5)
        + #lorem(5)
      ],
    )
    ```,
  )



- `bool`: If `auto-resuming` is set to `true`, all enum numbers will continue from the previous ones. It can also be set as an array, e.g., `(false, true)` means the first level does not enable the resuming feature, while subsequent levels do.
  - [>] Note. Methods with `auto-resuming` set to `true` cannot be nested within `*-enum-list` (or `*-enum`, `*-list`). A document can only have one such method.
  - For small documents like exams, exercises, or CVs, if you need to resume enum numbers throughout the document, you can use the following at the beginning:
    ```typst
    #show : el.default-enum-list.with(auto-resuming: true)
    ```
    We recommend using this only at the document's start. Generally,
    - `el.default-enum-list.with(auto-resuming: true)` and
    - `el.default-enum-list.with(auto-resuming: auto)`
    may interfere with each other.
  - For large documents like books or articles, we recommend not setting `auto-resuming` at the beginning (i.e., leave it as `none`). Instead, set this parameter to `auto` in the required sublists and use it with methods like `resume`, `resume-label`, `resume-list`, or `auto-resume-enum`.
== Terms-like Functionality

In a `list`, you can use the method `item` to change the current list marker. For example:


#example(
  ```
  #show: el.default-list
  - #el.item[#sym.backslash.circle] #lorem(2)
  ```,
)
#example(
  style: "v",
  ```
  #show: el.default-list.with(
    size: (1.2em, auto),
    fill: (yellow.darken(20%), auto),
    // baseline: -0.2em,
    label-width: (amount: 1em, style: "auto"),
    item-spacing: 1.5em,
    // enum-spacing: 1.2em,
    body-format: (
      whole: (inset: 5pt, fill: black),
      style: (fill: white),
    ),
  )
  - #el.item[为什么现在宣布《黑神话：钟馗》？] \
    因为每年8月20日向玩家汇报我们的进展是我们的传统——今年也不例外。

    然而，由于项目目前仅仅是一个空文件夹，几乎没有任何游戏画面可以分享。为了让所有人专注于开发，我们决定制作一个CG短片，让大家知道新项目已经启动。
  - #el.item[为什么现在是钟馗？为什么不先做《黑神话：悟空》的续作？] \
    感谢玩家们的坚定支持，第一部黑神话作品已经安全着陆。在完成与天选之人的旅程后，我们现在希望迈出尝试性的第一步——打造更独特的游戏体验，挑战更大胆的功能，为我们的世界观和叙事设计带来新鲜的想法。

    钟馗是基于这种愿望和其他因素的自然选择。我们相信，在这个新项目中，我们可以做出令人耳目一新的改变，创造新事物，同时认真审视我们过去的缺陷和遗憾。

  - #el.item[对于所有喜爱《黑神话：悟空》的朋友们：西行之旅不会在这里结束。] \
    作为黑神话系列的第二部作品，《黑神话：钟馗》与《黑神话：悟空》相比如何？有什么相似之处和不同之处？
    从名称上看，《黑神话：钟馗》与前作一样，都以中国古代神话和民间传说为基础。

    在类型方面，它仍将是一款标准的单人ARPG，遵循与以前相同的商业模式。

    然而——这次你不会扮演猴子角色。话虽如此，我们仍在探索和实验悟空与钟馗之间的具体差异。所以放轻松——让我们先让自己印象深刻，然后再呈现给你们。
  ```,
)

== Checklist <checklist>

This feature is essentially the same as the package `cheq` . However, in native `enum`, labels and bodies are top-aligned, while in `itemize`, they are aligned within the same paragraph. This causes misalignment when using `cheq` with `itemize`. Additionally, `cheq` uses `enum` to implement checklists, which means `enum` configurations affect the checklist. Therefore, we have added the `checklist` feature to `itemize` with minor enhancements and fixes.



- To enable this method, set the `checklist` parameter to `true` in `*-enum-list` (or `*-list`). For example:

  ```typst
  #show: el.default-enum-list.with(checklist: true)
  ```
  Now we can use:
  #example(
    ```typst
    #show: el.default-enum-list.with(checklist: true)
    - [x] checked #lorem(2)
    - [ ] unchecked #lorem(2)
    - [/] incomplete #lorem(2)
    - [-] canceled #lorem(2)
    ```,
  )

  The parameter can also accept an array to specify which levels of the list should enable the checklist feature.
- You can also enable and configure checklist-related features using the method `config.checklist`.
  - You can also enable the checklist feature by using it in the required places along with `el.default-enum-list`.
    ```typst
    #show: el.config.checklist
    ```
  - Parameters for `config.checklist`:
    - `baseline: array | auto | "center" | "top" | "bottom" = auto`: Alignment method for labels and bodies (same as `label-baseline` with `"center"`, `"top"`, `"bottom"`). Default is `auto`, controlled by `label-baseline`.
      #example(
        ```typst
        #show: el.config.checklist.with(baseline: "center")
        #show: el.default-enum-list.with(
          size: 1.5em,
        )
        - [x] #lorem(5)
        - [/] #lorem(5)
        - #el.item[#sym.times.circle.big] #lorem(5)
        ```,
      )
    - `enable: array | bool = true`: Whether to enable the checklist feature.
    - `extras: array | bool = false`: Whether to enable additional commands, i.e., use the following:
      ```
          ">": "➡",
          "<": "📆",
          "?": "❓",
          "!": "❗",
          "*": "⭐",
          "\"": "❝",
          "l": "📍",
          "b": "🔖",
          "i": "ℹ️",
          "S": "💰",
          "I": "💡",
          "p": "👍",
          "c": "👎",
          "f": "🔥",
          "k": "🔑",
          "w": "🏆",
          "u": "🔼",
          "d": "🔽",
      ```
      #example(
        ```
        #show: el.config.checklist.with( extras: true)
        #show: el.default-enum-list
        - [>] checked #lorem(2)
        - [?] unchecked #lorem(2)
        - [f] incomplete #lorem(2)
        - [d] canceled #lorem(2)
        ```,
      )
    - `fill: array | auto | color = auto`: Border color. If set to `auto`, it uses the current label's style.
    - `radius: array | length = 0.1em`: Border radius.
    - `solid: array | none | color = none`: Solid color. Default is `none`.
      #example(
        ```
        #show: el.config.checklist.with(
          fill: (blue, auto),
          radius: (.5em, 0em),
          solid: gray.lighten(50%),
        )
        #show: el.default-enum-list
        - [x] checked #lorem(2)
        - [ ] unchecked #lorem(2)
          - [N] #lorem(2)
        - [/] incomplete #lorem(2)
        - [-] canceled #lorem(2)
        ```,
      )
    - `enable-character: array | bool = true`: When set to `true`, if the character in `[...]` is not among `x, , - /` or the extras characters (if `extras` is `true`), the character in `[...]` will be displayed. For example:
      #example(
        ```
        #show: el.default-enum-list
        #show: el.config.checklist
        - [N] #lorem(5)
        - [A] #lorem(5)

        #show: el.config.checklist.with(enable-character: false)
        - [N] #lorem(5)
        - [A] #lorem(5)
        ```,
      )

    - `symbol-map: dictionary | function = (:)`: Custom commands.
      - Can replace built-in commands or add new ones.
        - The format is: `("some-character": content)`.
      - If a function is specified, its form is: `it => dictionary`, where `it` provides three properties: `fill`, `radius`, `solid`.
      #example(
        ```
        #show: el.default-enum-list.with(fill: blue)
        #show: el.config.checklist.with(
          symbol-map: (" ": emoji.checkmark, "A": emoji.a),
        )
        - [ ] #lorem(5)
        - [A] #lorem(5)


        #let box-sym(fill: white, stroke: rgb("#616161"), radius: .1em, body) = box(
          stroke: .05em + stroke,
          fill: fill,
          height: 1em,
          width: 1em,
          radius: radius,
        )[#body]
        #show: el.config.checklist.with(
          fill: blue,
          solid: luma(95%),
          symbol-map: it => (
            " ": box-sym(fill: it.solid, stroke: it.fill, radius: .2em, []),
            "x": box-sym(fill: it.fill, stroke: it.fill, radius: .2em, [#text(fill: white)[#emoji.checkmark]]),
            "A": box-sym(fill: it.fill, stroke: it.fill, radius: .2em, [#text(fill: white)[A]]),
          ),
        )
        - [ ] #lorem(5)
        - [x] #lorem(5)
        - [A] #lorem(5)
        ```,
      )
    - `enable-format: array | bool = false`: Whether to enable formatting for the body, with the format content determined by `format-map`. The default formatting is for the character `"-"`, with the formatting function:
      ```typst
      it => strike(text(fill: rgb("#888888"), it))
      ```
      #example(
        ```
        #show: el.default-enum-list
        #show: el.config.checklist.with(enable-format: true)
        - [ ] #lorem(3)
        - [-] #lorem(3)
        ```,
      )
      - [>] Note. According to our design, the text-style of checklist labels cannot be formatted, but other text formatting will still affect the label.
      - [>] Note. If `[]` is followed by `list` or `enum`, the label formatting will be incorrect (because the label and the current body are treated as the same paragraph). For example:

        Typically works as expected:
        #example(
          ```
          #show: el.default-enum-list
          #show: el.config.checklist.with(enable-format: true)
          - [ ] #lorem(3)
          - [-]
            + #lorem(3)
            + #lorem(3)
          - - [-] #lorem(3)
          ```,
        )

        Incorrect formatting (uncommon usage):
        #example(
          ```
          #show: el.default-enum-list
          #show: el.config.checklist.with(enable-format: true)
          - [ ] #lorem(3)
          + - [-]
              + #lorem(3)
              + #lorem(3)
          ```,
        )

        One solution (which may impact performance) is to exclude body formatting from the label by using `item-format: it => it.body`.
        #example(
          ```
          #show: el.default-enum-list.with(item-format: it => it.body)
          #show: el.config.checklist.with(enable-format: true)
          - [ ] #lorem(3)
          + - [-]
              + #lorem(3)
              + #lorem(3)
          ```,
        )

  - `format-map: dictionary = (:)`, Formatting for list items.
    - The format follows: `("some-character": some-function)`.
    - `some-function` takes the form `it => ...`, It applies the body of the current `some-character` item to this method.
    #example(
      ```
      #show: el.default-enum-list
      #show: el.config.checklist.with(
        enable-format: true,
        format-map: (
          "!": it => highlight(it),
          "-": it => strike(text(fill: rgb("#888888"), emph(it))), // Overrides the format-function of "-"
        ),
      )
      - [ ] #lorem(3)
      - [-] #lorem(3)
      - [!] #lorem(3)
      ```,
    )
== Enhancements to `list.marker`

The `itemize` package improves the parsing of `list.marker` as a `function` type (supporting label control for each item). Now, the `function` can be defined as:

```typst
level => n => content
```

or

```typst
level => array
```

Here:
- `level`: The relative nesting level of the `list`, cyclically used.
  - [!] *Breaking change*: For compatibility with the native `list.marker` behavior, unlike the methods provided by `itemize`, the level here starts from 0 (see #link("https://github.com/tianyi-smile/itemize/issues/3", [`issue#3`])).
  - Also, the item'index starts from 0.
    #example(
      ```
      #let test-list = [
        - #lorem(5)
          - #lorem(5)
          - #lorem(5)
        - #lorem(5)
      ]
      #[
        #show: el.default-enum-list.with(label-format: it => [#it.level - #it.n])
        #test-list
      ]
      #[
        #set list(marker: level => n => [#level - #n])
        #show: el.default-enum-list.with(auto-base-level: true)
        #test-list
      ]
      ```,
    )
- `n => content` or `array`: The `label` for each `item` in the same level.
#example(
  ```
  #show: el.default-enum-list
  #let marker = level => {
    if level == 0 { // stand for level 1!!!
      ([#sym.suit.club.filled], [#sym.suit.spade.filled], [#sym.suit.heart.filled], el.LOOP)
    } else if level == 1 { // stand for level 2!!! The first item's number starts from 0
      n => rotate(24deg * n, box(rect(stroke: 1pt + blue, height: 1em, width: 1em)))
    } else { // others
      [#sym.ballot.check.heavy]
    }
  }
  #set list(marker: marker)
  - #lorem(5)
  - #lorem(5)
    - #lorem(5)
    - #lorem(5)
      - #lorem(5)
      - #lorem(5)
    - #lorem(5)
    - #lorem(5)
    - #lorem(5)
  - #lorem(5)
    - #lorem(5)
  - #lorem(5)
  ```,
)
== `*-enum` and `*-list` Methods

These methods function similarly to `*-enum-list`. However,

- `*-enum` only applies to `enum` without affecting nested list styles.
- `*-list` only applies to `list` without affecting nested enum styles.
#example(
  ```
  #show: el.default-enum.with(
    fill: (red, blue, green),
    weight: "bold",
  )
  + #lorem(5)
    + #lorem(5)
    - #lorem(5)
      - #lorem(5)
      + - #lorem(5)
      - + #lorem(5)
    - #lorem(5)
  + #lorem(5)
  ```,
)

Comparison of differences:

#example(
  ```
  #show: el.default-enum-list.with(
    fill: (red, blue, green),
    weight: "bold",
  )
  + #lorem(5)
    + #lorem(5)
    - #lorem(5)
      - #lorem(5)
      + - #lorem(5)
      - + #lorem(5)
    - #lorem(5)
  + #lorem(5)
  ```,
)

- [>] Note. The behavior in ver0.2.x differs slightly from ver0.1.x. To separately configure `enum` and `list` in the enum-list, use `enum-config` and `list-config` in `*-enum-list`. The following approach cannot separately configure enum and list:
  #example(
    ```
    // This show-rule cannot be applied
    #show: el.default-enum.with(
      fill: (red, blue, green),
      weight: "bold",
    )
    // Only this show-rule is applied
    #show: el.default-list.with(fill: (yellow, orange))
    + #lorem(5)
      + #lorem(5)
      - #lorem(5)
        - #lorem(5)
        + - #lorem(5)
        - + #lorem(5)
      - #lorem(5)
    + #lorem(5)
    ```,
  )
  In ver0.2.x, we do not recommend the following approach (it does not meet expectations).
  ```typst
  #show enum: el.default-enum.with(...)
  #show list: el.default-list.with(...)
  ```
  The correct approach is:
  ```typst
  #show : el.default-enum-list.with(
    enum-config: (
      ...
    )
    list-config: (
      ...
    )
  )
  ```
== Set-Rule

In the current version of `typst` (0.14), we cannot use custom functions with `set rule`, which prevents us from retaining previously set property values when using `default-item-list`, `paragraph-item-list`, etc. Now, with the `elembic` package, we can achieve this functionality. To this end, we have repackaged `default-item-list` and `paragraph-item-list` into `set-default` and `set-paragraph` methods, which work the same as the original functions but retain previously set property values.

Usage instructions:

Include the following at the beginning of your document:

```typst
#show: el.set-default() // need ()!!!
```

- [>] Note. The key difference is that `set-default` requires *parentheses*!

#example(
  style: "h",
  ```
  #let item = [
    + #lorem(5)
      + #lorem(5)
      + + #lorem(5)
      + - #lorem(5)
    + #lorem(5)
  ]

  #show: el.set-default()
  #set enum(numbering: "(1).(a).(i)")
  #item

  // change the label color
  #show: el.set-default(fill: (red, blue, green, auto))
  #item

  // change the label size
  #show: el.set-default(size: (20pt, 16pt, 14pt, auto))
  #item

  // change the body-indent and indent
  #show: el.set-default(body-indent: (auto, 0.5em), indent: (auto, 0em, 1em, auto))
  #item

  // use the default style
  #show: el.set-default()
  #item
  ```,
)
== Experimental Features

=== Clearing Recorded Information in resuming enum

When implementing the `resume-label` and `resume-list` features in `resuming enum`, the `itemize` package needs to record the sequence numbers of the marked enums. If these records are no longer needed in the document, you can call the `adv.reset-resume()` method to clear this information. One common use case is:
```
  // New enum-before

  // el.adv.reset-resume()
  // New enum-here:
  // el.adv.reset-resume()

  // New enum-after
```
- [>] Improper use of `adv.reset-resume()` may break the `resuming enum` functionality.
=== Customizing Body Formatting

In `*-enum-list` (`*-enum` and `*-list`), you can freely customize the format of each item's body using the `item-format` property.
- It accepts
  + `none`: Does not take effect.
  + a `function` with form:
    ```typst
    it => ...
    ```
    which will apply to the body of each item'body. `it` has the following properties:
    - `it.level`: The level of the current item.
    - `it.body`: The body of the current item.
    - `it.n`: The index of the current item in the current level.
    - `it.n-last`: The index of the last item in the current level.
  + an `array`, whose elements are `function` with form `body => ...` which will be applied to the body of each item in turn.
  + or a `dictionary` with the following keys:
    - `whole`: Wraps the entire `enum` or `list`
    - `outer`: Wraps each item (including the label)
    - `inner`: Wraps each item (excluding the label)
    - If `whole`, `outer`, or `inner` is omitted, the default is `outer`.
    - The values are taken as Case 2 and Case 3 above.

  #example(
    ```
    #set enum(numbering: "(a)(i)(1)")
    #show: el.default-enum-list.with(
      item-format: it => {
        if it.level == 2 {
          // Equivalent to: if it.level >= 2
          show: highlight
          it.body
        } else {
          it.body
        }
      },
    )
    + #lorem(10)
      + #lorem(10)
      + + #lorem(10)
    + #lorem(10)
    ```,
  )

  #example(
    ```
    #set enum(numbering: "(a)(i)(1)")
    #show: el.default-enum-list.with(
      item-format: (
        outer: (block.with(fill: orange.lighten(80%)),auto),
        whole: it => {
          if it.level == 2 {
            show: strong
            set text(fill: orange)
            box(stroke: (left: 3pt + orange,rest: .5pt + orange), outset: (left: 3pt, top : 2pt), inset: (bottom: 1pt))[
              #place(right+bottom)[#sym.suit.club.filled]
              #it.body]
          } else {
            it.body
          }
        },
      ),
    )
    + #lorem(15)
      + #lorem(15)
      + + #lorem(15)
    + #lorem(15)
      + #lorem(15)
      + #lorem(15)
    ```,
  )

However, this may disrupt the correct positioning of the list labels. (The main reason is that `itemize` needs to treat the label and the first line of the body as the same paragraph.). It is mainly reflected in:
- When using containers (such as `box` and `block`) to wrap the body content, using the `inset` property of these containers may cause incorrect label positioning.
  - Since `item-format` is specified as a `function`, we cannot access properties like `inset` (left), making it impossible to correctly handle label positioning.
- Using complex `layout` containers (such as `move`, `rotate`, or `place`) to wrap the body content may also lead to incorrect label layout.
- Although we can ensure that most text formatting (e.g., `highlight`) applied to the body does not affect the nested `label` format, achieving this effect requires a complete refactor of the body elements in each item (to distinguish between labels and bodies).
  - `lower`, `upper`, `sub`, and `super` are not supported.

    However, you can use `show el.adv.style-format-label` to apply these effects. For example:
    #example(
      ```
      #set enum(numbering: "(a)(i)(1)")
      #show: el.default-enum-list.with(
        item-format: it => {
          if it.level == 2 {
            // Equivalent to: if it.level >= 2
            show el.adv.style-format-label: upper
            show: highlight
            it.body
          } else {
            it.body
          }
        },
      )
      + #lorem(10)
        + #lorem(10)
        + + #lorem(10)
      + #lorem(10)
      ```,
    )
- Content wrapped in `context` may not be processed correctly. (You can use `layout(_ => {...})` as an alternative.) Similarly, content output in `ref(<...>)` may also not be processed correctly.
- You can use `adv.native-content[...]` to prevent text formatting from being applied to the body. Example:
  #example(
    ```
    #set enum(numbering: "(a)(i)(1)")
    #show: el.default-enum-list.with(
      item-format: it => {
        if it.level == 2 {
          // Equivalent to: if it.level >= 2
          show el.adv.style-format-label: upper
          show: highlight
          it.body
        } else {
          it.body
        }
      },
    )
    + #lorem(10)
      + #lorem(10)

        before #el.adv.native-content([#lorem(2)]) after
      + + #lorem(10)
    + #lorem(10)
    ```,
  )
