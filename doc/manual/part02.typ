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


= Detailed Features

== Support for styling by level and item

In the `*-enum-list` (`*-enum`, `*-list`) methods, most parameters support being set per level and per item, which is achieved by passing an `array` or a `function`. In the API Reference (@sec:api), these are marked as `array` (level-property) and `function` (level-property).

#info-alert()[
  The parameter types of the methods in `itemize` can be divided into the following three kinds:
  - #bp: Not settable per level or per item
  - #lp: Settable per level, but not per item
  - #llp: Settable per level and per item; most parameters are of this type.
]

- `array` (level-property): Each element of the `array` sets the style of the item at the corresponding level; that is, the value at array index `l` sets the style of the item at level `l + 1`.
  - If the last element of the array is `LOOP`, the values in the array will be used cyclically;
  - otherwise, the last element's value applies to subsequent levels.
  - The value of each element of the array is one of the values allowed by the parameter.
  - If the parameter allows setting the style of an individual item (i.e., it is a `level-index-property`), then an element of the array may itself be an `array`, used to set the style of the items at the current level: for example, if the element at index `l` is an array `arrayItem`, then the element at index `n` of `arrayItem` sets the style of the `(n + 1)`-th item at level `l + 1`. Similarly,
    - If the last element of `arrayItem` is `LOOP`, the values in the array will be used cyclically for other indexes of items;
    - otherwise, the last element's value applies to subsequent indexes of items.

For example: the `fill` parameter in @cmd:default-enum-list.args sets the style of the item label, and it is #llp.
#example(read("../example/level-array-arg.typ"))


- `function` (level-property): If it is a `function`, its form is `it => value`, where `value` is one of the values allowed by the parameter (in most cases).
  - If the parameter allows setting the style of an individual item (i.e., it is a `level-index-property`), then `value` may be an `array`, where each element sets the style of the item at the corresponding index.
  - You can usually access the relevant values provided by `itemize` through the keys available on `it`, for example:
    - `it.level`: The level of the item, starting from 1.
    - `it.n-last`: The index of the last item in the current level.
    - `it.e`: The field of the current construct element (#m.builtin("enum") or #m.builtin("list")), but excluding the `children`.
    - `it.n`: The index of the item, starting from 1, when the parameter is #llp.
    ... (For more accessible values, see the API Reference (@sec:api).)
#example(read("../example/level-func-arg.typ"))

#info-alert[
  If the parameter is #lp, the `function` (level-property) can generally access:
  - `it.level`: The level of the item, starting from 1.
  - `it.n-last`: The index of the last item in the current level.
  - `it.elem-tag` (since ver0.3.0): The tag of the current enum or list.
  - `it.e` (since ver0.3.0): The field of the current construct element (#m.builtin("enum") or #m.builtin("list")), but excluding the `children`.
  - `it.hanging-type` (since ver0.3.0): The hanging type of the current level.

  If it is #llp, the following can also be accessed:
  - `it.n`: The index of the item, starting from 1.
  - `it.tag` (since ver0.3.0): The tag of the current item.
  - `it.marker` (since ver0.3.0): The marker of the current label if it is a #m.builtin("list").
  - `it.number` (since ver0.3.0): The number of the current label if it is a #m.builtin("enum").
  For horizontal spacing parameters
  - [N] `it.parent` (since ver0.3.0): the parameter info of the parent containing the current list — the parent's construction element `e`, the item `n` where the parent is located, and the horizontal margin parameters: `label-indent`, `label-inset`, `body-indent`, `indent`, `body-margin`, `label-width` (`max`, `current`)
  - [!] `it.get` (since ver0.3.0): access the parameter info of the current list's ancestors by level
  - [N] For `label-indent`, `label-inset`, `body-indent`, `indent`, `body-margin`: you can access `label-width` (`max`, `current`)
  - [N] For `first-line-inset`, `line-indent`, `hanging-indent`: you can access `label-indent`, `label-inset`, `body-indent`, `indent`, `body-margin`, `label-width` (`max`, `current`)
]

Using a `function` (level-property), you can implement some complex style settings. For example:
#example(read("../example/level-func-e.typ"))

#warning-alert[
  If a parameter itself allows passing an `array` or a `function` (marked in the API Reference (@sec:api) as `array` (base-property) and `function` (base-property)), then to resolve the conflict, wrap these values in an `array`.

  For example: the `font` parameter in @cmd:default-enum-list.args sets the font of the item label. According to #m.builtin("text.font"), this parameter allows an `array`. To set the desired font correctly, note the difference between the following three examples.
  - In the following, the first level of labels use the font `(name: "DejaVu Sans Mono", covers: "latin-in-cjk")`, and other levels use the font `"Noto Serif CJK SC"`.
    #example(read("../example/label-font-level.typ"))
  - In the following, for each level, the first index of label uses the font `(name: "DejaVu Sans Mono", covers: "latin-in-cjk")`, and other indices use the font `"Noto Serif CJK SC"`.
    #example(read("../example/label-font-level-index.typ"))
  - In the following, all the levels of labels use the font `((name: "DejaVu Sans Mono", covers: "latin-in-cjk"), "Noto Serif CJK SC")`.
    #example(read("../example/label-font-nested.typ"))
]

== Separating setting of #m.builtin("enum") and #m.builtin("list")
#m.since((0, 2, 0))@cmd:default-enum-list is used to uniformly set the styles of #m.builtin("enum") and #m.builtin("list"). You can also set the styles of #m.builtin("enum") and #m.builtin("list") separately through the parameters @cmd:default-enum-list.enum-config and @cmd:default-enum-list.list-config.

- The level used in `enum-config` and `list-config` is the relative level of #m.builtin("enum") (i.e., ignore #m.builtin("list")) and #m.builtin("list") (i.e., ignore #m.builtin("enum")), respectively.
- The values allowed to be passed in the keys are consistent with the corresponding parameters in the method @cmd:default-enum-list.
#info-alert()[
  Rules: If both @cmd:default-enum-list and @cmd:default-enum-list.enum-config have the same property set, the settings in `enum-config` take precedence.
  - For `..args`, `label-format`, `body-format`, and `description-config`, the settings are folded.
]
#example(read("../example/enum-list-config.typ"))

== Individual setting (@cmd:item)

#m.since((0, 3, 0)) For most parameters of @cmd:default-enum-list, you can use @cmd:item to set the style of a specific item. It must be placed between the label and the body, for example:
```
+ #el.item(...) body
```
#info-alert()[
  The values allowed to be passed in the keys of @cmd:item.args are consistent with the corresponding parameters in the method @cmd:default-enum-list.
]

#info-alert()[
  Rules: If @cmd:item.args, @cmd:default-enum-list and @cmd:default-enum-list.enum-config have the same property set, the settings in @cmd:item.args take precedence.
  - For `..args`, `label-format`, `body-format`, and `description-config`, the settings are folded.
]

- [N] The style of the whole item (#m.builtin("enum") or #m.builtin("list"))
  - It must be placed in the first item of the whole item to take effect
  - If the parameter is #lp, it takes effect directly. For example, @cmd:default-enum-list.whole-spacing and @cmd:default-enum-list.body-format`.whole` are #lp,
    #example(read("../example/item-whole-spacing.typ"))
    #example(read("../example/item-body-format-whole.typ"))
  - If the parameter is #llp, to make its effect apply to the whole item, set `for-elem` in @cmd:item to `true`. For example:
    #example(read("../example/item-for-elem.typ"))
- [N] The style of a single item. The parameter must be #llp.
  #example(read("../example/item-single.typ"))
#warning-alert()[
  Note that @cmd:item only affects the item at the current level and does not affect its nested items (unless the effect itself affects the style inside the item body). For example:
  #example(read("../example/item-nested.typ"))
]

=== Mark item <subsec:markitem>

#m.since((0, 3, 0)) You can use the parameters `elem-tag` and `tag` of @cmd:item to mark the whole item and a single item respectively, and then add styles to them or implement other complex customizations.
- The parameters `elem-tag` and `tag` accept any type
  #warning-alert()[
    The parameter `elem-tag` must be placed in the first item of the whole item to take effect.
  ]
- For parameters that are #lp and #llp, you can use a `function` (level-property) to access the parameters `elem-tag` and `tag`.
#example(read("../example/item-tag.typ"))

By parsing the values `elem-tag` and `tag`, you can mark items and customize their styles. For example:
#example(read("../example/tag.typ"))

=== Terms-like list <subsect:terms-like>

#m.since((0, 2, 0)) You can pass a positional argument (#m.dtype(content)) to @cmd:item:
- Change the current #m.builtin("list") marker
  #example(read("../example/item-marker.typ"))
- [N] #m.since((0, 3, 0)) Change the current #m.builtin("enum") number
  - The parameter `skipped` of @cmd:item sets whether to skip counting the current #m.builtin("enum") number; in this case the current #m.builtin("enum") number will be the same as the previous item
  #example(read("../example/item-number.typ"))


== Item label formatting

=== Text style
#m.since((0, 1, 0))
@cmd:default-enum-list.args can pass any #m.typ.text named arguments (like: `fill`, `size`, `font`, etc.) to format the current item label. Unless `auto` is used, the text style of `label` cannot be changed via `#set text`.

#example(read("../example/label-text.typ"))

#info-alert()[
  All the #m.typ.text named arguments support #llp.
]

=== Label alignment
#m.since((0, 2, 0))
@cmd:default-enum-list.label-align (#llp) is usually used to set _horizontal_ alignment for label.
#info-alert()[
  If you want 2D alignment, see @cmd:default-enum-list.label-baseline.
]
#warning-alert()[
  This differs from `enum.number-align` and `list.marker-align` (the latter align whole enum numbers and list markers). We suggest keeping `enum.number-align` and `list.marker-align` at their defaults when using `itemize`.
]
#example(read("../example/label-align.typ"))

=== Label width
#m.since((0, 2, 0))
@cmd:default-enum-list.label-width (#llp) allows re-rendering the width of the current label as a given value. Its complete form is
#dic-args(
  amount: (auto, "max", relative, (default: 0pt)),
  style: ("default", "constant", "auto", "native", (default: "constant")),
)

*Notation*:
- `real-width`: The real width of the current label's content (calculated by `measure`).
- `max-width`: The maximum value of all `real-width`s in the current level.

When `amount` is
#m.changed((0, 3, 0))
- [E] `relative`: The value is `amount.length + amount.ratio × real-width`.
- `auto`: `real-width`.
- `"max"`: `max-width`.

#info-alert()[
  `amount` allows to pass `ratio`, which is relative to the real width of the item label. So,
  `(amount: 100%)` is the same as `(amount: auto)`.
]

When `style` is
- `"default"`: If `real-width` is less than `amount`, the label's width is rendered as `amount`; otherwise, the label's width is rendered as `real-width`.
  #example(read("../example/label-width-default.typ"))
- `"constant"`: The label's width is rendered as `amount`.
  #example(read("../example/label-width-constant.typ"))
- `"auto"`: The label's width is rendered as `real-width`.
  #example(read("../example/label-width-auto.typ"))
- `"native"`: The label's width is rendered as `max-width`.
  - [!] #m.changed((0, 3, 0)) Also `amount` is set to `max-width`.
  #example(read("../example/label-width-native.typ"))

Shorthand rules:

`label-width` can also take
- `auto`: Use the native behavior. That is, the current width of the label will be set to `max-width`. This is the same as `(style: "native")`.
- `relative`: This is the same as `(amount: label-width, style: "default")`.
- `"max"`: This is the same as `auto`.

#info-alert()[
  In order to make the layout more in line with expectations, the `start-margin` (i.e., `body-margin.left` if `text.dir` is `ltr`, `body-margin.right` if `text.dir` is `rtl`) will be set to `amount + body-indent` (if `start-margin` is `auto`).
]

=== Sharing the maximum label width

In Typst, the maximum widths of the item labels of different #m.builtin("enum")s and #m.builtin("list")s are computed separately. For example:
#example(read("../example/auto-label-width-base.typ"))
You will see that the two items in `enum A` share the same maximum width, but `enum B` and `enum C` have two different widths.

#m.since((0, 2, 0))
By configuring @cmd:default-enum-list.auto-label-width (#lp), `itemize` allows different (but at the same level) #m.builtin("enum")s and #m.builtin("list")s to share the maximum item label width so that they are aligned. For example:
#example(read("../example/auto-label-width-each.typ"))


If you need to specify which #m.builtin("enum")s and #m.builtin("list")s share the maximum item label width, there are several ways as follows.
- Set @cmd:default-enum-list.auto-label-width to `auto`, then use the method @cmd:auto-label-item. In this case, in the `body` of the method `auto-label-item(body)`, the #m.builtin("enum") or #m.builtin("list") share the same maximum label width.
  #example(read("../example/auto-label-1.typ"))
  - @cmd:auto-label-item.form (#lp) is used to specify the #m.builtin("enum") and #m.builtin("list") at different levels.
    - *Note*: The method @cmd:auto-label-item cannot be nested.
- For @cmd:default-enum-list.auto-label-width, use a `function` (level-property) together with the @cmd:item method to mark `elem-tag`. In the following, for the same level of #m.builtin("enum")s or #m.builtin("list")s, if they are marked as `"auto-label"` (with the help of `el.item(elem-tag: ...)`), then they will share the same maximum label width.
  #example(read("../example/auto-label-width-tag.typ"))

#info-alert()[
  Both @cmd:auto-label-item.form and @cmd:default-enum-list.auto-label-width can take the following values:
  - `"each"`: shares the maximum item label width of #m.builtin("enum") and #m.builtin("list") separately.
  - `"all"`: shares the maximum item label width of #m.builtin("enum") and #m.builtin("list") together.
  - `"enum"`: shares only the maximum item label width of #m.builtin("enum").
  - `"list"`: shares only the maximum item label width of #m.builtin("list").
]

#warning-alert()[
  When `auto-label-width` is not `auto` or `none`, the method `default-enum-list` cannot be used in a nested manner. For example: both of the following two usages are incorrect.
  #codesnippet(
    ```
    #show: el.default-enum-list.with(auto-label-width: "all")
    #show: el.default-enum-list.with(auto-label-width: "each")
    ...
    ```,
  )
  or
  #codesnippet(
    ```
    #el.default-enum-list(auto-label-width: "all")[
      #show: el.default-enum-list.with(auto-label-width: "each")
      ...
    ]
    ```,
  )
  However, the following usage is not affected:
  #codesnippet(
    ```
    #[
      #show: el.default-enum-list.with(auto-label-width: "all")
      ...
    ]
    #[
      #show: el.default-enum-list.with(auto-label-width: "each")
    ]
    #el.default-enum-list(auto-label-width: "each")[
      ...
    ]
    ```,
  )
]
=== Label baseline (Vertical movement)
#m.since((0, 2, 0))
By setting @cmd:default-enum-list.label-baseline (#llp), you can vertically translate the item label. It can also be used to set the alignment between the item label and the item body.
#info-alert[
  In Typst 0.15.1, if the item label and the item body have a #link("https://github.com/typst/typst/pull/8150", `baseline`), then the item label and the item body will be aligned by their baselines by default; otherwise they are top-aligned.

  Note: the #m.builtin("enum") or #m.builtin("list") as a whole has no baseline.
  In particular, if multiple item labels are displayed on the same line, their baselines are not aligned.
  For example:
  ```
  + + $vec(1,1,1)$
  ```
  is rendered as
  #enum(
    enum.item(auto, [+ $vec(1, 1, 1)$]),
  )#el.itemize-prevent-label

  In `itemize`, we modify this behavior by default to align their baselines. At the same time, more alignment options are provided.
]
Its complete form is:
#dic-args(
  amount: (
    (default: 0pt),
    auto,
    relative,
    "center",
    "top",
    "bottom",
    "baseline",
    "top-item",
    "horizon-item",
    "bottom-item",
  ),
  at: (auto, `top`, `bottom`, `horizon`, (default: auto)),
  relative-to: (
    auto,
    `"bottom"`,
    `"center"`,
    `"top"`,
    `"baseline"`,
    `"top-item"`,
    `"horizon-item"`,
    `"bottom-item"`,
    (default: auto),
    array,
    (
      to: (auto, [], (default: [A])),
      at: (auto, `top`, `bottom`, `horizon`, (default: auto)),
      shift: (relative, (default: 0pt)),
    ),
  ),
  same-line-style: (
    auto,
    `"top"`,
    `"center"`,
    `"bottom"`,
    `"baseline"`,
    `"top-item"`,
    `"horizon-item"`,
    `"bottom-item"`,
    `"top-label"`,
    `"center-label"`,
    `"bottom-label"`,
    `"baseline-label"`,
    (
      amount: (auto, relative, (default: 0pt)),
      at: (auto, `top`, `bottom`, `horizon`, (default: auto)),
      relative-to: (
        `"bottom"`,
        `"center"`,
        `"top"`,
        `"baseline"`,
        `"top-item"`,
        `"horizon-item"`,
        `"bottom-item"`,
        `"top-label"`,
        `"center-label"`,
        `"bottom-label"`,
        `"baseline-label"`,
        relative,
        content,
        array,
        (default: "baseline"),
        (
          to: (auto, [], (default: [A])),
          at: (auto, `top`, `bottom`, `horizon`, (default: auto)),
          shift: (relative, (default: 0pt)),
        ),
      ),
    ),
  ),
  impact-first-line: (auto, bool, (default: auto)),
)
- [N]
  #m.since((0, 3, 0))
  The three keys `(amount, at, relative-to)` set the alignment between the current item label and the item body. Their meaning is: take the position at `at` of the item label, move it by `amount`, and align it with the position set by `relative-to`.
  - `amount` may be a `ratio`, which is relative to the height of the current item label.
  - For the meaning of `at`, see also #m.builtin("box.baseline").
  - The alignment position set by `relative-to: (to, at, shift)` means: the position of the content `to` at `at`, moved by `shift`.
    - The content `to` should usually appear in the first line of the item body.
    - *Note*: `itemize` uses the height of the first character (i.e., [A]) in the first line of the item body. If you manually set the font style of the paragraph's text, this alignment may not be accurate. It is recommended to use the `style` parameter in `body-format` for adjustments.
    - `shift` is relative to the height of `to`.
  - Only when `amount` is `auto` or `relative`, the keys `at` and `relative-to` can work.
  + Shorthand rules for `label-baseline`:
    - When `label-baseline` takes #m.dtypes(auto, relative, "\"center\"", "\"top\"", "\"bottom\"", "\"baseline\"", "\"top-item\"", "\"horizon-item\"", "\"bottom-item\"")
    it is equivalent to
    setting `amount` to the corresponding value.
  + Shorthand rules for `amount`:
    - When `amount` takes #m.dtypes("\"center\"", "\"top\"", "\"bottom\"", "\"baseline\"")
      it aligns the `horizon`, `top`, `bottom`, `baseline` of the item label and the item body (first line).
      which are respectively equivalent to `(at: horizon, relative-to: "center")`, `(at: top, relative-to: "top")`, `(at: bottom, relative-to: "bottom")`, `(at: auto, relative-to: "baseline")`.
    - When `amount` takes #m.dtypes("\"top-item\"", "\"horizon-item\"", "\"bottom-item\""), it aligns the `top`, `horizontal`, `bottom` of the item label to the `top`, `horizontal`, `bottom` of the whole item body. This is equivalent to setting `enum.number-align` or `list.marker-align` to `top`, `horizon`, `bottom`. In this case `at` will be set to `top`, `horizon`, `bottom` and can no longer be set by the user.
  + Shorthand rules for `relative-to`.
    - When `relative-to` takes #m.dtypes("\"center\"", "\"top\"", "\"bottom\"", "\"baseline\""), it is equivalent to aligning the item body at the `horizon`, `top`, `bottom`, `baseline` of the first line. That is, equivalent to `(to: [A], at: horizon)`, `(to: [A], at: top)`, `(to: [A], at: bottom)`, `(to: [A], at: auto)`.
    - When `relative-to` takes #m.dtypes("\"top-item\"", "\"horizon-item\"", "\"bottom-item\""), it is equivalent to setting `enum.number-align` or `list.marker-align` to `top`, `horizon`, `bottom`. In this case `at` will be set to `top`, `horizon`, `bottom` and can no longer be set by the user.
    - When `relative-to` takes #m.dtype([]), it is equivalent to `(at: auto, to: relative-to, shift: 0pt)`.
    - When `relative-to` takes #m.dtype(length), it is equivalent to `(at: auto, to: [A], shift: relative-to)`,
    - When `relative-to` takes #m.dtype(array), its form is: `(content | relative, "center" | "top" | "bottom" | "baseline")`
      - If the first element is a `content`, then `to` is set to `relative-to`; if it is `relative`, then `shift` is set to `relative-to`.
      - The second element is equivalent to setting `at` to `horizon`, `top`, `bottom`, `auto`, respectively.
#example(read("../example/label-baseline-amount.typ"))
#example(read("../example/label-baseline-at.typ"))

#example(read("../example/label-baseline-size.typ"))
- [M] Removed `alone` in `itemize0.2.0`.
- [E]
  #m.changed((0, 3, 0))
  `same-line-style`: sets the alignment of labels on the same line
  - If it is `auto` (default), the current setting of `label-baseline` is used, which aligns to the baseline of the item body by default.
  - Sets whether to align the labels on the same line to the last label, the first line of the item body, or the whole item body.
    - Shorthand rules for `same-line-style`.
      - #m.dtypes("\"center\"", "\"top\"", "\"bottom\"", "\"baseline\"") : the first line of the item body
        #example(read("../example/label-baseline-same-line-center.typ"))
      - #m.dtypes("\"top-item\"", "\"horizon-item\"", "\"bottom-item\"") : the whole item body
        #example(read("../example/label-baseline-same-line-item.typ"))
      - #m.dtypes("\"top-label\"", "\"horizon-label\"", "\"bottom-label\"", "\"baseline-label\""): the last label
        #example(read("../example/label-baseline-same-line-label.typ"))
        #example(read("../example/label-baseline-same-line-amount.typ"))
    - More detailed settings can be made via `(amount, at, relative-to)`, similar to @cmd:default-enum-list.label-baseline.
#info-alert()[
  - In `itemize0.2.0`, by default, the baselines of labels on the same line are all aligned to the baseline of the last label.
  - In `itemize0.3.0`, by default, the baselines of labels on the same line are all aligned to the baseline of the item body. You can set `same-line-style` to `"baseline-label"` to restore the default behavior of `itemize0.2.0`.
  - Note: in `itemize0.2.0`, the values `"top"`, `"center"`, `"bottom"` are equivalent to the values `"top-label"`, `"center-label"`, `"bottom-label"` in `itemize0.3.0`.
]


- [N] #m.since((0, 3, 0)) `impact-first-line`: Whether to impact the first line of the label body by `label-baseline`.
  - if `auto`, then if @cmd:default-enum-list.hanging-type is `"paragraph"`, then `true`, else `false`.
  #example(read("../example/impact-first-line.typ"))
  #info-alert()[In `itemize0.2.0`, there is no `impact-first-line` property, and by default the item label impacts the first line of the label body.]
=== Label inset (Horizontal movement)

#m.since((0, 3, 0)) @cmd:default-enum-list.label-inset (#llp) is used to horizontally move the item label, without affecting the label width and the inset of the first line.

#example(read("../example/label-inset.typ"))

=== Formating in any way

#m.changed((0, 3, 0))  @cmd:default-enum-list.label-format is used to customize item labels in any way.
Its complete form is:
#dic-args(
  format: (none, content, function, array, (default: none)),
  stroke: (),
  radius: (),
  outset: (),
  inset: (),
  clip: (),
  align: (auto, alignment, array, function, (default: start)),
  width-style: (
    `"real-width"`,
    `"label-width"`,
    `relative`,
    (
      amount: (`"real-width"`, `"label-width"`, `relative`, (default: "label-width")),
      stretched: (bool, (default: false)),
    ),
  ),
  height-style: (
    `"real-height"`,
    `relative`,
    (amount: (`"real-height"`, `relative`, (default: "real-height")), stretched: (bool, (default: false))),
  ),
)
- All the keys are #llp.
- #m.since((0, 2, 0)) Shorthand rules for `label-format`: if `label-format` has no other keys, then `format` does not need to be written. That is, `(label-format: func)` is equivalent to `(label-format: (format: func))`, where `func` is #m.dtypes(none, content, function, array).
  - `content`: displays the content of the current label as `content`.
    #example(read("../example/label-format-content.typ"))
  - `array`: elements can be a `content`, a `function` (in the form `body => content`, meaning the content of the item label is applied to the function), or an `array` (the (`n-1`)-th element of the array applies to the `n`-th item label).
    #example(read("../example/label-format-array.typ"))
  - `function` (level-property): in the form `it => content`, meaning the content of the item label is applied to the function.
  #example(read("../example/label-format-function.typ"))
  See also the usage of the @cmd:item method and @subsec:markitem.
- [N] #m.since((0, 3, 0)) `stroke`, `radius`, `outset`, `fill`, `inset`, `clip`: The _border_ of the label, which are the same as #m.builtin("box") arguments.
  #example(read("../example/label-format-border.typ"))
- [N] #m.since((0, 3, 0)) `align`, `width-style`, `height-style`: can be used to set the width and height of the current item label, and align within this range according to `align`.
  - In `width-style` and `height-style`, you can set `stretched: true` to make the set width and height affect the layout.
  #example(read("../example/label-format-align.typ"))

  #example(read("../example/label-format-stretched.typ"))
  #example(read("../example/label-format.typ"))
#info-alert()[
  Note: the width set here does not affect the maximum width of the item label at the current level (e.g., set via @cmd:item).
  #example(read("../example/label-format-item-width.typ"))
]

=== Step for enum number

#m.since((0, 3, 0))@cmd:default-enum-list.step (#lp) is used to set the step size for #m.builtin("enum")'s number.

#example(read("../example/step.typ"))

=== Enhancement of #m.builtin("list.marker")
#m.since(0, 1, 0)The `itemize` package improves the parsing of #m.builtin("list.marker") as a `function` type (supporting label control for each item). It takes the following form:
- `level => (n => content) | array`

Here:
- `level`: The relative nesting level of the `list`, cyclically used.
  - For compatibility with the native `list.marker` behavior, unlike the methods provided by `itemize`, the level here starts from 0 (see #link("https://github.com/tianyi-smile/itemize/issues/3", [`issue#3`])).
  - Also, the item index starts from 0.
  #example(read("../example/list-marker-level.typ"))

- `n => content`\, `array`: The `marker` for each `item` in the same level.
  #example(read("../example/list-marker.typ"))


== Item body formatting

#m.since((0, 2, 0))@cmd:default-enum-list.body-format is used to customize the item body in any way.
Its complete form is
#dic-args(
  style: (dictionary, (default: (:))),
  whole: (
    function,
    array,
    (default: (:)),
    (
      format: (none, function, array, (default: none)),
      stroke: (),
      radius: (),
      outset: (),
      fill: (),
      inset: (),
      clip: (),
      breakable: (),
      sticky: (),
      width: (),
    ),
  ),
  outer: ((default: (:)),),
  inner: ((default: (:)),),
)
- [M] #m.changed((0, 3, 0)) The `item-format` in `itemize0.2.0` has been moved to the `format` in `body-format`. Therefore, `item-format` is removed in `itemize0.2.0`.
  - [M] Unlike the handling in `itemize0.2.0`, this setting also applies to the styles of the item labels of lists nested inside the item body.
- `style`: Any #m.typ.text named arguments (like: `fill`, `size`, `font`, etc.). The _text-style_ of the item body.
  - These keys are #llp. See also @cmd:default-enum-list.args.
  #example(read("../example/body-format-style.typ"))


- `whole`, `outer`, `inner`: Format the item body.
  - The keys in `outer`, `inner` are #llp, and in `whole` are #lp.
  - `format` (`none`, `function`): The format of the item body.
    - See the `format` in @cmd:default-enum-list.label-format.
    - [!] #m.changed((0, 3, 0)) *Note*: Use the `format` function (since ver0.3.0) to replace the `item-format` (in ver0.2.0) parameter .
  - `stroke`, `radius`, `outset`, `fill`, `inset`, `clip`, `breakable`, `sticky`, `width`: The _border_ of the item body, which are the same as the #m.typ.block named elements.
    - *Note*: `width` only works for `whole`.
  - Shorthand rules: if there is only `format`, then `format` can be omitted.
    - `whole`: Wrap the entire #m.builtin("enum") or #m.builtin("list")
      #example(read("../example/body-format-whole.typ"))
    - `outer`: Wrap the item (including the label)
      #example(read("../example/body-format-outer.typ"))
    - `inner`: Wrap the item body (excluding the label)
      #example(read("../example/body-format-inner.typ"))
    #example(read("../example/body-format-list.typ"))
  - Shorthand rules for `body-format`
    - If `whole`, `outer`, and `inner` are omitted, the default is `outer`.
    - If there is only `format`, then `format` can also be omitted.
  #example(read("../example/body-format-shorthand.typ"))

  #example(read("../example/body-format-function.typ"))


  #example(read("../example/body-format-nested.typ"))

  #example(read("../example/body-format-inner-green.typ"))
  #example(read("../example/body-format-outer-blue.typ"))
== Horizontal spacing setting

=== Indentation of item

#m.since((0, 1, 0))@cmd:default-enum-list.indent (#llp) is used to set the indentation of the item.

- [M] #m.changed((0, 3, 0)) Now the setting of @cmd:default-enum-list.indent affects the position of the whole border.
#example(read("../example/indent.typ"))

=== Indentation of item body

#m.since((0, 1, 0))@cmd:default-enum-list.body-indent (#llp) is used to set the spacing between the item label and body.

#example(read("../example/body-indent.typ"))

=== Indentation of item label

#m.since((0, 2, 0))@cmd:default-enum-list.label-indent (#llp) is used to set the the indentation of the item label.


#example(read("../example/label-indent.typ"))
=== Body margin and item width

#m.since((0, 3, 0))@cmd:default-enum-list.body-margin (#llp) is used to set the (left and right) margin of the item body.
#info-alert()[
  Based on the `itemize` design, `label-indent`, the label's content, and `body-indent` belong to the label's body.
  - The left margin of the item body starts from the left of the label's body.
  - The right margin of the item body ends at the right of the item body. This is the same as the `enum-margin` in `itemize0.2.0`.

    - [!] #m.changed((0, 3, 0)) `enum-margin` in `itemize0.2.0` is removed.
    - [!] #m.changed((0, 3, 0)) `is-full-width` in `itemize0.2.0` is also removed.

      In Typst 0.15.1, some `block-level` elements (like #m.builtin("enum"), #m.builtin("list"), #m.builtin("terms"), #m.builtin("pad")) are always expanded to the full width of the parent element if the parent element is like `page`.

      If you want to set #m.builtin("enum") or #m.builtin("list") be full width in any parent element, you can set `body-format: (whole: (width: 100%))`.

      #example(read("../example/body-format-full-width.typ"))
  // TODO: figure
]

#info-alert()[
  `body-margin` can control the starting alignment position of the `block-level` element in the item body and the actual `100%` width.

  - *Note*: In general, the layout of `inline-level` elements in the item body are not affected by `body-margin` (except for the actual `100%` width).
  - The layout of `inline-level` elements usually are affected by `line-indent` and `hanging-indent`.
  For example, for @cmd:paragraph-enum-list, the default value of `body-margin` is the same as @cmd:default-enum-list, but the `inline-level` elements in @cmd:paragraph-enum-list are aligned to the left of the item label. See the example below.
  #example(read("../example/body-margin-paragraph.typ"))
]

Its complete form is:
#dic-args(
  left: (auto, relative, (default: auto)),
  right: (auto, relative, (default: 0pt)),
)
- Shorthand rules: if `body-margin` takes #m.dtypes(auto, relative), then both its `left` and `right` values are set to `body-margin`.
- `left` sets the left margin of the item body. Its `ratio` part is relative to the whole label's body width, i.e., the rendered width of the label (@cmd:default-enum-list.label-width) + `label-indent` + `body-indent`.
  - If `body-margin.left` is `auto`, its default value is the label's body width; in addition, it is also affected by @cmd:default-enum-list.label-width.
  - Note: if the value set for `body-margin.left` is less than the label's body width, the item label and the item body may overlap (Typst does not yet support `z`-axis layout). However, as long as no background color is added, this is visually invisible.
    #example(read("../example/body-margin-overlap.typ"))
- `right` sets the right margin of the item body. Its `ratio` part is relative to the width of its parent container.
  - [M] #m.changed((0, 3, 0)) Now the setting of `body-margin.right` affects the position of the whole and outer borders.
  #example(read("../example/body-margin-right.typ"))

With this attribute, it is now very easy to implement some lists with very special layouts.
+ The body of all nested lists is aligned to the left.
  #example(read("../example/body-margin-left-align.typ"))
+ Align the (first-level) item body and the first line of the paragraph, e.g., indent both by 2em.
  #example(read("../example/body-margin-align-par.typ"))
+ Align the (first level) item body and the first line of the paragraph with the `paragraph` hanging style.
  #example(read("../example/body-margin-align-par-hanging.typ"))

== Vertical spacing setting

=== Spacing of the whole item
#m.since((0, 3, 0))@cmd:default-enum-list.whole-spacing (#lp) is used to set the above and below spacing of the current #m.builtin("enum") or #m.builtin("list").
Its complete form is:
#dic-args(
  above: (auto, relative, fraction, (default: auto)),
  below: (auto, relative, fraction, (default: auto)),
)
#info-alert()[
  #m.changed(0, 3, 0)This is a renamed argument of `enum-spacing` in `itemize0.2.0`.
]
- Shorthand rules: if `whole-spacing` takes #m.dtypes(auto, relative, fraction), then both its `above` and `below` values are set to `whole-spacing`.

#example(read("../example/whole-spacing.typ"))

#info-alert()[
  For the meaning of the `spacing` (`above` and `below`) of `block-level` elements and the meaning of setting it to `auto`, see #m.builtin("block.above") and #m.builtin("block.below").
]

=== Tight mode
#m.since((0, 3, 0)) When `whole-spacing` is `auto`, the `above` and `below` spacing of the whole item can be controlled by @cmd:default-enum-list.tight-mode (#lp).
#info-alert()[
  *Background*: For the current #m.builtin("enum") or #m.builtin("list"), the above spacing (denoted as `above-spacing`) and the below spacing (denoted as `below-spacing`) are determined by the following cases:
  1. The current #m.builtin("enum") or #m.builtin("list") is `tight` (i.e. `enum.tight` or `list.tight` is `true`, see @cmd:default-enum-list.tight-item-mode);
  2. The current #m.builtin("enum") or #m.builtin("list") is not `tight` (i.e. `enum.tight` or `list.tight` is `false`, see @cmd:default-enum-list.tight-item-mode);
  3. There is a `parbreak()` between the above paragraph and the current #m.builtin("enum") or #m.builtin("list"): like
    ```typst
    The preceding paragraph.  // below has a `parbreak()`

    + items
    ```
  4. There is no `parbreak()` between the above paragraph and the current #m.builtin("enum") or #m.builtin("list"): like
    ```typst
    The preceding paragraph.
    + items
    ```
  - Combining these cases, we call
    - case 1 with case 3 *par-tight* (i.e. `tight` with a `parbreak()` above),
    - case 2 with case 3 *par-not-tight*,
    - case 1 with case 4 *tight*,
    - case 2 with case 4 *not-tight*.
  - Note: In native Typst behavior, cases *par-not-tight*, *par-tight* and *not-tight* are the same.
]
Its complete form is:
#dic-args(
  tight: (auto, relative, fraction, array, (default: auto)),
  not-tight: (auto, relative, fraction, array, (default: auto)),
  par-tight: (auto, relative, fraction, array, (default: auto)),
  par-not-tight: (auto, relative, fraction, array, (default: auto)),
)

- Here, if `tight` is an `array`, then the array needs 2 elements representing the values of the `above` and `below` spacing respectively; if it is #m.dtypes(auto, relative, fraction), then the values of the `above` and `below` spacing are both set to `tight`. `not-tight`, `par-tight`, `par-not-tight` follow the same rule.
- `tight`, `not-tight`, `par-tight`, `par-not-tight` represent the *tight* case, *not-tight* case, *par-tight* case, *par-not-tight* case, respectively.
- *Note*: In order to set `below` spacing from `par-tight` and `par-not-tight`, you need to add in the document:
  ```typst
  #show: el.config.auto-detect-tight
  ```
  #example(read("../example/tight-config.typ"))

- Shorthand rules
  - `auto`: Use the native Typst behavior of #m.builtin("enum") or #m.builtin("list").
    - for the *tight* case: `above` spacing is #m.builtin("enum.spacing") or #m.builtin("list.spacing") (if `auto`, representing #m.builtin("par.leading")); for the other cases it is `auto` (representing #m.builtin("par.spacing")).
    - `below` spacing is `auto` (representing #m.builtin("par.spacing")).
  - `"always-tight"`: `above` and `below` spacing are #m.builtin("par.leading") and `auto`.
  - `"never-tight"`: `above` and `below` spacing are #m.builtin("par.spacing") and `auto`
  - `"compact-tight"`: `above` and `below` spacing are both #m.builtin("par.spacing").

  #example(read("../example/tight-mode-compact.typ"))


=== Spacing of each item

#m.since((0, 2, 0))@cmd:default-enum-list.item-spacing (#llp) is used to set the spacing between each item.
This parameter can take #m.dtypes(auto, relative, fraction) or
#dic-args(
  above: (auto, relative, fraction, (default: auto)),
  below: (auto, relative, fraction, (default: auto)),
)
- [E] #m.since((0, 3, 0)) For a value of type #m.dtype(dictionary)
  - The `above` spacing is ignored for the first item, but the `below` spacing is added to the last item.
  - The spacing between the previous and current items is the previous `below` plus the current `above`.
    - *Note*: This differs from setting `item-spacing` to a concrete value.
  #example(read("../example/item-spacing-below.typ"))

  #example(read("../example/item-spacing-fraction.typ"))
- For values of type #m.dtypes(auto, relative, fraction), the meaning is the same as `block.spacing`.

=== Item tight mode
#m.since((0, 3, 0)) When `item-spacing` is `auto`, the spacing can be controlled by @cmd:default-enum-list.tight-item-mode (#llp).
#info-alert()[
  *Background*: The spacing between items is determined by the following cases:
  1. *tight*: There is no `parbreak()` between items, like:
    ```typst
    + item one // no `parbreak()` below
    + item two // no `parbreak()` below
    + item three
    ```
  2. *not-tight*: There is a `parbreak()` between items, like:
    ```typst
    + item one // has a `parbreak()` below

    + item two
    + item three
    ```
]
Its complete form is:
#dic-args(
  tight: (auto, relative, fraction, (default: auto)),
  not-tight: (auto, relative, fraction, (default: auto)),
)
- If `tight` is `auto`, use #m.builtin("par.leading")
- If `not-tight` is `auto`, use #m.builtin("par.spacing")
- Use the values of `tight` and `not-tight` for the *tight* case and the *not-tight* case, respectively.
#example(read("../example/tight-item-mode.typ"))
- Shorthand rules
  - `auto`: Use the native Typst behavior of #m.builtin("enum") or #m.builtin("list").
    - The spacing uses #m.builtin("enum.spacing") or #m.builtin("list.spacing") (if `auto`, representing #m.builtin("par.leading") for the *tight* case and #m.builtin("par.spacing") for the *not-tight* case).
  - `"always-tight"`: The spacing is #m.builtin("par.leading").
  - `"never-tight"`: The spacing is #m.builtin("par.spacing").
  #example(read("../example/tight-item-mode-always.typ"))

#info-alert()[
  @cmd:default-enum-list.tight-item-mode can also be implemented through the `e.tight` of the `function` (level-property) of @cmd:default-enum-list.item-spacing.
  #example(read("../example/item-spacing-tight.typ"))
]



