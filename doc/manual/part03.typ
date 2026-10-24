#import "../helper.typ": *

#let colors = splash.seaborn.dark.values()
#show: el.inline-enum-list.with(
  fill: colors,
  checklist: true,
  tight-mode: ("never-tight", auto),
  tight-item-mode: "always-tight",
  description-config: (
    term-format: (strong,),
  ),
)
== Reference

#m.since((0, 1, 0)) To enable this feature, use the method @cmd:config:ref like the following at the beginning of the document:

```typst
#show: el.config.ref
```

=== Reference enum number

In the enum item you want to reference, label it with `<some-label>`, and then use `@<some-label>` to reference the enum number of that item.

#warning-alert()[
  If the enum number cannot be retrieved correctly, use the method @cmd:elabel to label the enum item.
]

#example(read("../example/ref-enum-number.typ"))

=== Configuration of reference

The `ref-numbering` and `supplement` in @cmd:default-enum-list and @cmd:item, as well as @cmd:config:ref.numbering and @cmd:config:ref.supplement, can be used to set the format of references.

#m.since((0, 3, 0)) The complete form of `ref-numbering` (#bp) is:
#dic-args(
  numbering: (none, str, function, (default: none)),
  full: (auto, bool, `"rel"`, (default: auto)),
)

- For the meaning of `numbering`, see #m.builtin("enum.numbering"). Its purpose is to apply the `numbering` to the referenced enum number (or the full enum numbers, i.e., including parent enum numbers). `none` means it is not applied.
- `full`. Determine to display the full enum numbers.
  - `true` displays the full number (including parent levels).
    #example(read("../example/full-ref.typ"))
  - `false` displays only the current item's number.
  - `"ref"` displays the reference number items in a relative manner (i.e., if the current item and the reference item have the same parent level (in the same parent enum), the same parent level is not displayed.)
    #example(read("../example/rel-ref.typ"))
- Shorthand rules: `ref-numbering` can take #m.dtypes(none, str, function), which means `numbering` is `ref-numbering`.

#m.since((0, 3, 0)) `supplement` (#llp) can take
- `auto`: No supplementary content will be added.
- `content`: Uses `content` as supplementary content. The effect is that when referencing #m.builtin("enum") or #m.builtin("list") labels, then content is added before the label.
- `dictionary`:
  #dic-args(
    prefix: (content, (default: [])),
    suffix: (content, (default: [])),
  )

  The effect is that when referencing enum (list) labels, `prefix` content is added before the label, and `suffix` content is added after the label.


#info-alert()[
  *Application rule* (`ref-numbering`): consider, in order, the `ref-numbering` in @cmd:item.args, the `ref-numbering` in @cmd:default-enum-list.enum-config, and @cmd:default-enum-list.ref-numbering:
  - `numbering`: if their `numbering` are all `none`, then @cmd:config:ref.numbering is used, and if its value is `auto`, then `enum.numbering` is used.
  - `full`: if their `full` are all `auto`, then @cmd:config:ref.full is used, and if its value is `auto`, then `enum.full` is used.
]

#info-alert()[
  *Application rule* (`supplement`):
  - The native Typst #m.builtin("ref.supplement") is always displayed to the left of the referenced content.
  - Then the content of @cmd:config:ref.supplement is considered.
  - Finally, consider, in order, the `supplement` in @cmd:default-enum-list.enum-config and @cmd:default-enum-list.supplement; if the former is `auto` or `none`, then the latter is used. If the `label` is placed after @cmd:item, then the `supplement` in @cmd:item.args is used with priority. For example:
    ```
    + #el.item(supplement: [...]) <some-label> body <other-label>
    ```
    For `@some-label`, the content of `[...]` is used with priority (as long as it is not `auto` or `none`); for `@other-label`, the `supplement` in @cmd:item.args is ignored.
    - *Note*: this content is passed as a whole to @cmd:config:ref.supplement. In particular, if @cmd:config:ref.supplement is a `function` (level-property), then for `it => content`, this part of the content is `it.body`.
]

You can set the reference format and supplement for each #m.builtin("enum") in the following ways.
- [N] #m.since((0, 3, 0)) Use @cmd:default-enum-list.ref-numbering and @cmd:default-enum-list.supplement to set the reference format and supplement for each #m.builtin("enum").
  #example(read("../example/ref-numbering-supplement.typ"))
- [E] #m.since((0, 2, 0)) Use @cmd:config:ref.numbering and @cmd:config:ref.supplement to set the reference format and supplement for all current references.
  #warning-alert()[
    *Note*: this method applies to the format used when referencing (i.e., using `@<some-label>` or `#ref(<some-label>)`), regardless of the location of the #m.builtin("enum").
  ]
  #example(read("../example/ref-config.typ"))

  #info-alert[
    #m.since((0, 3, 0)) With @cmd:default-enum-list.supplement and @cmd:config:ref.supplement (`function` (level-property)), you can customize the reference format of #m.builtin("enum").
    - The function form: `it => content`.
    - Access the following values available on `it`:
      - `it.body`: The referenced #m.builtin("enum") labels.
      - `it.level`: The level of the item, starting from 1.
      - `it.n`: The index of the item, starting from 1.
      - `it.n-last`: The index of the last item in the current level.
      - `it.tag`: The tag of the item.
      - `it.elem-tag`: The tag of the #m.builtin("enum") or #m.builtin("list").
      - `it.e`: The field of the current construct element (#m.builtin("enum") or #m.builtin("list")), but excluding the `children`.
      - `it.hanging-type`: The hanging type of the current level.
      - `it.number`: The number of the current label if it is a #m.builtin("enum").
      - `it.target`: The target of the referenced label.
      - `it.numbers`: The full numbers of the referenced item (including the parent #m.builtin("enum") numbers).
    #example(read("../example/ref-theorem.typ"))
    #example(read("../example/ref-supplement-function.typ"))
  ]
  #example(read("../example/ref-counter.typ"))
- [N] #m.since((0, 3, 0)) Use the `ref-numbering` and `supplement` of @cmd:item.args to set the reference format for the current #m.builtin("enum") and the reference supplement for the items of the current #m.builtin("enum").
  - The `ref-numbering` of @cmd:item.args must be placed in the first item of the whole item to take effect, and it only applies to the current #m.builtin("enum"); nested #m.builtin("enum")s do not use this setting.
  - For the `supplement` of @cmd:item.args to take effect, the `label` needs to be placed after @cmd:item.
  #example(read("../example/ref-item-args.typ"))


=== Reference item label

#m.since((0, 3, 0)) If you use @cmd:item to change the content of the current item label (@subsect:terms-like), referencing that content is now also supported, but the `label` needs to be placed after @cmd:item.

#example(read("../example/list-ref.typ"))

== Resuming enum number
In `itemize`, it is allowed to specify which #m.builtin("enum") numbers continue to use the numbers from other #m.builtin("enum")s.
=== Resuming by level or by specifying #m.builtin("enum")
To enable this feature, set @cmd:default-enum-list.auto-resuming (#lp) to `auto`. Then you can use the following methods:
+ #m.since((0, 2, 0)) @cmd:resume is to continue using the enum numbers from the previous enum at the same level.
  #example(read("../example/resume-level.typ"))
  - You can also use `resume[...]` to explicitly continue using the enum numbers from the previous level (especially in ambiguous cases) and treat the `[...]` as a new #m.builtin("enum").
    #example(read("../example/resume-explicit.typ"))
+ #m.since((0, 2, 0)) Use the method @cmd:resume-label to label the enum you want to resume, and then use @cmd:resume-list in the desired enum to continue using the labelled enum numbers.
  #info-alert()[
    If you use the following in your document:
    ```typst
    #show: el.config.ref-resume
    ```
    then you can use `@some-label` instead of `resume-list(<some-label>)`.
  ]
  #example(read("../example/resume-label.typ"))
+ #m.since((0, 2, 0)) Use the method @cmd:auto-resume-enum and set @cmd:auto-resume-enum.auto-resuming (#lp) to `true` to automatically resume the enum numbers for #m.builtin("enum")s in @cmd:auto-resume-enum.doc.
  #example(read("../example/auto-resume-enum.typ"))
  - Using `array` to specify that, for which level, the #m.builtin("enum") continues to use the previous enum's numbers.
    #example(read("../example/auto-resume-enum-array.typ"))
  - [N] #m.since((0, 3, 0)) Using `function` to specify which #m.builtin("enum") continues to use the previous enum's numbers.
    #example(read("../example/auto-resume-enum-function.typ"))
    #warning-alert()[
      The method @cmd:auto-resume-enum cannot be nested.
    ]

#info-alert()[
  *Application priority*: @cmd:resume-list > @cmd:auto-resume-enum > @cmd:resume.
]
=== Isolating enum's resuming
#m.since((0, 2, 0)) The method @cmd:isolated-resume-enum allows the #m.builtin("enum")s in @cmd:isolated-resume-enum.doc to be treated as new enums with independent numbering, without affecting other enums out of `doc`.
#example(read("../example/isolated-resume-enum.typ"))

=== Resuming for all
#m.since((0, 2, 0)) If @cmd:default-enum-list.auto-resuming (#lp) is set to `true`, then all enum numbers will continue from the previous ones.
#example(read("../example/auto-resuming-true.typ"))

#m.since((0, 3, 0)) Also, using `function` (level-property), you can specify which #m.builtin("enum") continues to use the previous enum's numbers.
#example(read("../example/auto-resuming-function.typ"))

#warning-alert()[
  If `auto-resuming` is not `none` or `false`, the method `default-enum-list(auto-resuming: ...)` cannot be used nested.
]



== Body paragraph setting

#m.since((0, 3, 0))@cmd:default-enum-list.first-line-inset (#llp) is to add an inset to the first line of the item body. If there is no first line, it is ignored.

#example(read("../example/first-line-inset.typ"))

#m.since((0, 2, 0)) @cmd:default-enum-list.line-indent (#llp) is to set line indentation for paragraphs in item body.


#example(read("../example/line-indent.typ"))

#m.since((0, 2, 0)) @cmd:default-enum-list.hanging-indent (#llp) is to set hanging indentation for paragraphs in item body.

#example(read("../example/hanging-indent.typ"))

#warning-alert()[
  - [!] #m.changed((0, 3, 0)) Paragraphs inside `block-level` elements that appear in the
    item body are not processed.
    #example(read("../example/line-indent-block.typ"))

  - The `inline` elements in the item body are processed as `par` (but the `inline` elements inside `block-level` elements are not processed), which is different from native #m.builtin("enum") and #m.builtin("list").
    #example(read("../example/line-indent-inline.typ"))
  - The `line-indent` and `hanging-indent` parameters are independent of `par.first-line-indent`, `par.hanging-indent`.

    #example(read("../example/line-indent-independent.typ"))
]


@cmd:default-enum-list.hanging-type (#lp) is to set the hanging type of the paragraphs inside the item body.
- `"classic"`: The native behavior of #m.builtin("enum") or #m.builtin("list").
- `"paragraph"`: For each level, paragraphs inside the item body are not indented; they align to the current `body-margin`'s beginning margin (the same as the `paragraph-*` methods).
  - *Note*: But the current `body-margin`'s beginning margin is the same as the `"classic"` one.
#example(read("../example/hanging-type.typ"))
== Checklist

#m.since((0, 2, 0)) To enable this feature, set @cmd:default-enum-list.checklist (#lp) to `true`.
#example(read("../example/checklist.typ"))

#warning-alert()[
  #m.changed((0, 3, 0)) Note: after `itemize0.3.0`, this feature can no longer be enabled through @cmd:config:checklist, and we have removed the `enable` parameter.
]

=== Configuration of checklist

#m.since((0, 2, 0)) Using @cmd:config:checklist, you can configure the checklist.

- `baseline` (`auto`, `"center"`, `"top"`, `"bottom"`, `"baseline"`): The baseline of the checkbox. Default is `auto`, controlled by @cmd:default-enum-list.label-baseline.
- `extras` (`bool`): Whether to enable additional commands, i.e., use the following:
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
  #example(read("../example/checklist-extras.typ"))
- `fill` (`auto`, `color`): Border color. Default is `auto`, use the current label's text fill.
- `radius` (`length`): Border radius. Default is `0.1em`.
- `solid` (`color`, `none`): Solid color. Default is `none`.
  #example(read("../example/checklist-config.typ"))
- `enable-character` (`bool`): When set to `true`, if the character in `[...]` is not among `x`, ` `, `-`, `/` or the extras characters (if `extras` is `true`), the character in `[...]` will be displayed.
  #example(read("../example/checklist-enable-character.typ"))
- `symbol-map` (`dictionary`, `function`): Custom commands.
  - Can replace built-in commands or add new ones.
    - The form is: `("some-character": content)`.
  - If a function is specified, its form is: `it => dictionary`, where `it` provides three properties: `fill`, `radius`, `solid`.
  #example(read("../example/checklist-symbol-map.typ"))
  Also, you can use other package that provides symbol mapping.
  #example(read("../example/checklist-roumnd.typ"))
- `enable-format` (`bool`): Whether to enable formatting for the item body, with the formatting determined by `format-map`. The default formatting is for the character `"-"`, with the formatting:
  ```
  it => strike(text(fill: rgb("#888888"), it))
  ```
  #example(read("../example/checklist-enable-format.typ"))
- `format-map` (`dictionary`): Custom formatting for the item body.
  - Can replace built-in commands or add new ones.
  - The form is: `("some-character": func)`.
    - `func` takes the form `it => content`. It applies the body of the current `some-character` item to this method.
  #example(read("../example/checklist-format-map.typ"))



== Description list

#m.since((0, 3, 0)) The description list is like the following:
```
[marker] / [number] [term-body] [description-body]
```
where
```
term-body: [prefix] [term] [separator.prefix]
description-body: [separator.suffix] [description] [suffix]
```
Using the syntax:
- `+ / term: description`
- `- / term: description`

#example(read("../example/description-timeline.typ"))

#example(style: "v", read("../example/qa.typ"))

=== Configuration of description list

Configure the description list through @cmd:default-enum-list.description-config. Its complete form is:
#dic-args(
  style: (auto, `"plain"`, `"hanging"`, `"stacked"`, `"horizontal"`, (default: "plain")),
  checklist: (bool, (default: false)),
  term-width: (auto, relative, `"max"`, dictionary, (default: auto)),
  term-align: (auto, alignment, (default: auto)),
  prefix: (content, (default: [])),
  suffix: (content, (default: [])),
  separator: (auto, content, dictionary, (default: auto)),
  hanging-indent: (auto, length, (default: auto)),
  term-format: (none, function, (default: none)),
  description-format: (none, function, (default: none)),
  format: (none, function, (default: none)),
  enable-first-par: (auto, bool, (default: auto)),
)

#info-alert()[
  All the keys are #llp.
]

- `style`: The style of the description list.
  - `"plain"` == `auto`: Plain description list. The `term-body` and `description-body` are displayed in a single paragraph.
  - `"hanging"`: Hanging description list. The `term-body` and `description-body` are displayed in a single paragraph, but `hanging-indent` is `2em` in default. The same as native Typst `terms`.
  - `"stacked"`: Stacked description list. The `term-body` and `description-body` are displayed as two start-aligned paragraphs, respectively.
  - `"horizontal"`: Horizontal description list. The `term-body` and `description-body` are displayed in a single paragraph, but `description-body` will be indented and aligned according to `term-width` (by default, using the maximum width of the `term-body`).
  #example(read("../example/description.typ"))
  #info-alert()[
    Using `description-config` or `elem-tag` in @cmd:item.args, you can change the style of the description list individually.
    #example(read("../example/description-config-elem-tag.typ"))
    #example(read("../example/description-config-item.typ"))
  ]
- `checklist` (`bool`): Whether to use checklist style description list.
  - *Note*: In order to enable checklist style, the `checklist` in `default-*` (or `paragraph-*`) must be `true`.
  #example(read("../example/description-checklist.typ"))
- `term-width`: The width of the `term-body`.
  - `auto`: In default,
    - for "horizontal" style, the `term-width` uses the maximum width of the `term-body` in the current level and in the "horizontal" style. That is, use `(amount: "max", style: "native")`.
    - for other styles, the `term-width` uses the real width of the `term-body`. That is, use `(amount: auto, style: "native")`.
  - `relative`, `"max"`, `dictionary`: See @cmd:default-enum-list.label-width.
    - *Note*: The maximum width of the `term-body` in the current level is calculated for different styles.
- `term-align` (`auto`, `alignment`): The alignment of the `term-body`.
  - *Note*: The `term-align` works for the following cases.
    - The "horizontal" and "stacked" styles;
    - For "hanging" and "plain" styles, the `term-width` is not `auto` (that is, the real width of the `term-body` is not equal to the rendered width).
  - `auto` == `start`.
  - `alignment`: The (horizontal) alignment of the `term-body`.
- `separator`: The separator between `term-body` and `description`. Its complete form is:
  #dic-args(
    prefix: (content, (default: [])),
    suffix: (content, (default: [])),
  )
  - In default, `separator.prefix` is added after `term` and `separator.suffix` is added before `description`.
  - Shorthand rules:
    - `auto`: The `separator.prefix` is `[]` for "stacked" style and `[#h(.6em)#h(0pt, weak: true)]` for other styles. `separator.suffix` is `[]`.
    - `content`: The `separator.prefix` is `separator` and the `separator.suffix` is `[]`.
  #example(read("../example/description-separator.typ"))

  #example(read("../example/description-separator-hanging.typ"))
- `prefix`, `suffix` (`content`): The `prefix` is added before `term`, and the `suffix` is added after `description`.
  #example(read("../example/description-prefix-suffix.typ"))
- `hanging-indent` (`auto`, `length`): The hanging indent of the description list.
  - If `auto`, `hanging-indent` is `2em` for "hanging" style, and `0pt` for other styles.
- `term-format`, `description-format` (`none`, `function`): The format of the `term` and `description`.
  - `none`: Do not apply.
  - `function` (base-property): Apply the function to the `term` (not the `term-body`) and `description` (not the `description-body`).
    - The function form: `body => content`.
    - The `function` should be wrapped in an `array`, like: `(strong, )`.
  #example(read("../example/description-format.typ"))
- `format` (`none`, `function`): The format of the description list. If the default style is not suitable, you can use `format` to customize the style.
  - `none`: Do not apply.
  - `function` (base-property): Apply the function to the whole description list.
    - The function form: `body => content`.
    - The `function` should be wrapped in an `array`, like: `(strong, )`.
    #example(read("../example/description-format-array.typ"))
  - `function` (level-property): Use the form `it => content` and access values on `it`, you can define any style of description list. See the implementation examples of the four styles provided by `itemize`.
- `enable-first-par` (`auto`, `bool`): To make all the paragraphs in the description list like the first paragraph.
  - `auto`: For `stacked` style, the `enable-first-par` is `true`, and for other styles, the `enable-first-par` is `false`.
  - `bool`: Whether to enable the first paragraph.
  #example(read("../example/description-enable-first-par.typ"))

== Set-Rule

In the current version of `Typst` (0.15.1), we cannot use custom functions with `set rule`, which prevents us from retaining previously set property values when using `default-item-list`, `paragraph-item-list`, etc. Now, with the `elembic` package, we can achieve this functionality. To this end, we have repackaged `default-item-list` and `paragraph-item-list` into `set-default` and `set-paragraph` methods.

Usage: Include the following at the beginning of your document:

```typst
#show: el.set-default() // need `()`!!!
```
#warning-alert()[
  The key difference is that `set-default` requires *parentheses*!
]

#example(style: "h", read("../example/set-default.typ"))
