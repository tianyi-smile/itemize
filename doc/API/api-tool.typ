/// Creates a labeled reference for enum items.
/// - *Note*: Use this when regular `label(<...>)` won't work with enum references
///
/// - name (string, label, content): Label identifier
///
/// -> content
#let elabel(name) = {}

/// Mark the last element in the array for cyclic usage. I.e., for `array` parameters, if the last element of the array is `LOOP`, then the values in the array will be used cyclically.
#let LOOP = _ => none

/// Prevent recursion label
///
/// Add this label to `enum` or `list` to prevent `itemize` to process.
///
/// - Usage:
///   ```
///   #enum(
///     enum.item([#lorem(2)]),
///     // other items
///   )#el.itemize-prevent-label
///   ```
#let itemize-prevent-label = label("__cdl_itemize_prevent-label__")

/// Display an enum or list as a new enum or list. Usage:
/// ```typst
/// + item 1
/// + item 2
/// #el.new-enum-list-flag
/// // The following content will be treated as a new enum or list
/// + item 3
/// + item 4
/// ```
#let new-enum-list-flag = {
  show enum: it => it
  show list: it => it
}


/// Used to share the same maximum label width for different `enum`s and `list`s in `doc`.
///
/// - *Note*: The method `auto-label-item` cannot be nested.
/// - *Note*: In order to make `auto-label-item` work, should set the argument `auto-label-width` in `*-enum-list` (`*-enum`) to `auto`.
///
/// - doc (content): The `enum` or `list` in the `doc` to process
/// - form (none, auto, string, array, function):
///     - `none`: No processing.
///     - `"each" == auto`: The maximum widths of `enum`'s labels and `list`'s labels are considered separately.
///     - `"enum"`: Only the maximum widths of `enum`'s labels are considered.
///     - `"list"`: Only the maximum widths of `list`'s labels are considered.
///     - `"all"`: The maximum widths of `enum`'s labels and `list`'s labels are both considered.
///     - `array` (level-property): The elements are `none`, `auto`, `"each"`, `"list"`, `"enum"`, `"all"`. The `level`-th level will be set to the corresponding value of the array at position `level - 1`.
///       - *Note*: The level in `doc` uses the relative or absolute level depending on which `*-enum-list` or `*-enum` is used in the document; but starting from *1*.
///       - `"each"` is equivalent to `auto`.
///       - If the last element of the array is `LOOP`, the values in the array will be used cyclically;
///       - otherwise, the last value of the array will be used for residual levels.
///     - `function` (level-property):
///       - The function form: `it => none | auto | "each" | "list" | "enum" | "all"`
///       - Access the following values available on `it`:
///         - `it.level`: The level of the item, starting from 1.
///         - `it.n-last`: The index of the last item in the current level.
///         - `it.elem-tag`: The tag of the `enum` or `list`.
///         - `it.e`: The construct function (`enum` or `list`) of the item.
///         - `it.hanging-type`: The hanging type of the current level.
///       - Example: In the following, for the same level of `enum`s or `list`s, if they are marked as "auto-label" (with the help of `el.item(elem-tag: ...)`), then they will share the same maximum label width.
///         ```typst
///         #show: el.default-enum-list.with(auto-label-width: auto)
///         + List one
///         #el.auto-label-item(form: it => {
///           if it.elem-tag == "auto-label" { auto }
///         })[
///           + Item one
///           + Item two
///             + #el.item(elem-tag: "auto-label") Sub item one
///             + Sub item two
///           + Item one
///             10. #el.item(elem-tag: "auto-label") Sub item
///        ]
///        + List two
///        ```
/// -> content
#let auto-label-item(doc, form: auto) = {}

/// Resume enum in `doc`.
///
/// - *Note*: The method `auto-resume-enum` cannot be nested.
///
/// - *Note*: In order to make `auto-resume-enum` work, should set the argument `auto-resuming` in `*-enum-list` (`*-enum`) to `auto`.
///
/// - doc (content): The `enum` in the `doc` to process
/// - auto-resuming (none, bool, array, function): Resume mode
///   - `none` == `false`: Disable this feature.
///   - `true`: All enum numbers within `doc` will continue from the previous ones (for each level).
///   - `array` (level-property): The elements are `bool` or `none`. The `level`-th level will be set to the corresponding value of the array at position `level - 1`; now `true` means the enum numbers at the `level`-th level will continue from the previous ones.
///     - *Note*: The `enum`'s level in `doc` uses the relative or absolute level depending on which `*-enum-list` or `*-enum` is used in the document; but starting from *1*.
///     - If the last element of the array is `LOOP`, the values in the array will be used cyclically;
///     - otherwise, the last value of the array will be used for residual levels.
///   - `function` (level-property): The return value will be used for each level.
///     - The function form: `it => bool | none`
///     - Access the following values available on `it`:
///       - `it.level`: The level of the item, starting from 1.
///       - `it.n-last`: The index of the last item in the current level.
///       - `it.elem-tag`: The tag of the `enum` or `list`.
///       - `it.e`: The construct function (`enum` or `list`) of the item.
///       - `it.hanging-type`: The hanging type of the current level.
///     - Example: Using `it.elem-tag`, specify which `enum` continues to use the previous enum's numbers.
///       ```typst
///       #show: el.default-enum-list.with(auto-resuming: auto)
///       + List one
///       #el.auto-resume-enum(auto-resuming: it => {
///         if it.elem-tag == "resume" { true } else { false }
///       })[
///         + Item one
///         + Item two
///           + Sub item one
///           + Sub item two
///         New paragraph
///         + Item one // not resume
///           + #el.item(elem-tag: "resume") Sub item // resume
///       ]
///       + List two // not resume
///       ```
/// -> content
#let auto-resume-enum(doc, auto-resuming: none) = {}

/// Recovery operations within an isolation scope, allows the `enum` in the `doc` to be treated as a new enum with independent numbering, without affecting other enums.
/// - doc (content): The `enum` in the `doc` to process
///
/// -> content
#let isolated-resume-enum(doc) = {}


/// Continue using the enum numbers from the previous ones (for the same level).
///
/// - *Note*: In order to make this method work, set the argument `auto-resuming` in the method `*-enum-list` (`*-enum`) to `auto`.
///
/// - ..body (content): The `enum` in the body to resume
///
/// -> content
#let resume(..body) = {}

/// Label current `enum` for reference by `key`
///
/// - key (label, string, content): Unique identifier for the `enum`
///
/// -> content
#let resume-label(key) = {}

/// Resumes an enum labelled with `key` (by using the method `resume-label`)
///
/// - *Note*: In order to make this method work, set the argument `auto-resuming` in the method `*-enum-list` (`*-enum`) to `auto`.
///
/// - key (label, string, content): Key of the `enum` to resume
/// - ..body (content): The `enum` in the body to resume
/// -> content
#let resume-list(key, ..body) = {}


/// Configure for the current item
/// - ..args (arguments): Arguments for the current item.
///   - Positional arguments.
///     - body (`content`): Content for the current label body (`enum` or `list`); defaults to `none` to preserve existing label body
///       - *Note*: Both `enum` and `list` support referencing the content of the `body`. However, the `label` needs to be placed after this method, for example:
///         ```typst
///         #show: el.default-enum-list
///         #show: el.config.ref // Enable to support referencing
///         + #el.item([Enum])<enum:a> item <enum:b>
///         - #el.item([List])<list:a> item
///         Test:
///         @enum:a // Output: Enum
///         @list:a // Output: List
///         @enum:b // Output: 1
///         ```
///     - For `enum`, even if the content display of the item label is changed, the current item still has a label number (`enum`'s number) --- and the label number will be the same as the previous one (if `item(skipped: true)`) or the same as the current one (if `item(skipped: false)`).
///   - Named arguments.
///     - Support the following arguments:
///       - label formatting: any `text` named arguments, label-width, label-format, label-baseline, label-align, label-inset, label-indent
///       - body formatting: body-margin, body-format, body-indent
///       - horizontal spacing: indent
///       - vertical spacing: whole-spacing, item-spacing, tight-mode, tight-item-mode
///       - paragraph: hanging-indent, line-indent, first-line-inset, hanging-type
///       - reference: ref-numbering, supplement
///       - enum's numbering: step, skipped
///       - description-list config: description-config
///       - identifier: tag, elem-tag
///       - others: absolute, for-elem.
///     - Details:
///     - any `text` named arguments (like: `fill`, `size`, `font`, etc.): Format the current item label.
///     - indent (`auto`, `length`, `array`, `function`, `none`): The indentation of the `enum` or `list`.
///     - body-indent (`auto`, `length`, `function`, `array`, `none`): The indentation of the body, i.e., the space between the label and the body of each item.
///     - label-indent (`auto`, `length`, `array`, `function`, `none`): The indentation for the label (the enum's number or the list's marker).
///     - label-inset (`auto`, `length`, `array`, `function`, `none`): Adds an inset to the label. It translates labels horizontally (without affecting the label width and the inset of the first line).
///     - item-spacing (`auto`, `relative`, `fraction`, `dictionary`, `array`, `function`, `none`): Spacing between items.
///     - whole-spacing (`auto`, `relative`, `fraction`, `dictionary`, `array`, `function`, `none`): The above and below spacing of the current `enum` or `list`. Only used when `item` is in the first item.
///     - tight-mode (`auto`, `"always-tight"`, `"never-tight"`, `"compact-tight"`, `dictionary`, `array`, `function`, `none`): If `whole-spacing` are `auto`, then `tight-mode` is used to determine the above and below spacing of `enum` or `list`. Only used when `item` is in the first item.
///     - tight-item-mode (`auto`, `"always-tight"`, `"never-tight"`, `dictionary`, `array`, `function`, `none`): If `item-spacing` is `auto`, then `tight-item-mode` is used to determine the spacing between items. Only used when `item` is in the first item.
///     - hanging-indent (`auto`, `length`, `array`, `function`, `none`): The hanging indentation for item body.
///     - line-indent (`auto`, `length`, `array`, `function`, `none`): The indentation for the first line of a paragraph, excluding the first paragraph (default: `auto`).
///     - first-line-inset (`auto`, `length`, `array`, `function`, `none`): Adds an inset to the first line of the item body (default: `0pt` if `auto`). If there is no first line, it is ignored.
///     - hanging-type (`"classic"`, `"paragraph"`, `array`, `function`): Hanging type for multiline content; defaults to "classic". Only used when `item` is in the first item.
///     - label-align (`auto`, `alignment`, `array`, `function`, `none`): The `alignment` that enum numbers and list markers should have. In general, this parameter is used to set *horizontal* alignment for label. If want 2D-alignment, then see @cmd:default-enum-list.label-baseline.
///     - label-width (`auto`, `relative`, `"max"`, `dictionary`, `function`, `array`, `none`): Render the width of the label.
///     - body-format (`dictionary`, `array`, `function`, `none`): Customize item bodies.
///     - label-format (`dictionary`, `array`, `function`, `none`): Customize item labels.
///     - label-baseline (`auto`, `relative`, `"center"`, `"top"`, `"bottom"`, `"baseline"`, `"top-item"`, `"horizon-item"`, `"bottom-item"`, `dictionary`, `array`, `function`, `none`): Set the baseline style of the label body.
///     - body-margin (`auto`, `relative`, `dictionary`, `array`, `function`, `none`): The left and right margin of the current item body. Based on the `itemize` design, `label-indent`, the label's content, `body-indent` are belong to the label's body. For `ltr`, the left margin starts from the left of the label's body; for `rtl`, the right margin starts from the right of the label's body.
///     - description-config (`dictionary`, `none`): Configure the description list.
///     - step (`auto`, `int`, `function`, `array`, `none`): Used to set the step size for `enum`'s number.
///     - ref-numbering (`string`, `function`, `dictionary`, `none`): How to number the `enum`'s reference (default: `none`, determined by `enum.numbering` or @cmd:config:ref.numbering). Only used when `item` is in the first item of `enum`.
///       - *Note*: Only work for the current `enum` (not for the nested `enum`).
///       - Example:
///         ```typst
///         #show: el.default-enum-list
///         #set enum(numbering: "1.")
///         #show: el.config.ref
///         + #el.item(ref-numbering: "(1)") item <enum:a>
///           + Sub item <enum:b>
///         Test:
///         @enum:a // Output: (1)
///         @enum:b // Output: 1.
///         ```
///     - supplement (`auto`, `content`, `dictionary`, `function`, `array`, `none`):  Used to set supplementary content when referencing labels.
///       - *Note*: This only work when referencing the label body.
///       - Example:
///         ```typst
///         #show: el.default-enum-list
///         #show: el.config.ref
///         + #el.item([Enum], supplement: "Item")<enum:a> item <enum:b>
///         Test:
///         @enum:a // Output: Item Enum
///         @enum:b // Output: 1
///         ```
///     - skipped (`bool`): Only for `enum`, whether to skip current label numbering; if `true`, the label's number will use the previous one, otherwise, the label's number will remain unchanged; defaults to `false`.
///     - absolute (`bool`): Whether to use absolute nesting levels.
///       - `true`: When using the method `*-enum-list`, the meaning of the nesting levels includes `enum` and `list`.
///       - `false` (default): In `list`, the meaning of levels only includes `list`; and in `enum`, the meaning of levels only includes `enum`.
///     - for-elem (`bool`): Whether the properies set by `item` is applied for current `enum` or `list` (not only for the current item); defaults to `false`. Only used when `item` is in the first item.
///       - Example: In the following, for `List A`, all the labels of  are colored by `red`, but for `List B`, only the first item is colored by `red`:
///         ```typst
///         #show: el.default-enum-list
///         // List A
///         + #el.item(for-elem: true, fill: red) List A item one
///         + List A item two
///         Paragraph:
///         // List B
///         + #el.item(fill: red) List A item one
///         + List A item one
///         ```
///     - tag (`any`): The identifier of the item.
///     - elem-tag (`any`): The identifier of the lists (`list` or `enum`).
#let item(..args) = {}
