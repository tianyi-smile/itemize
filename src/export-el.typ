#import "core/feat-enum-list.typ" as fel


/// To generate methods for exporting and configuring enums and lists
#let get-list-enum-method(
  doc,
  elem, // "both", "list", "enum"
  indent,
  body-indent,
  label-indent,
  is-full-width,
  item-spacing,
  enum-spacing,
  enum-margin,
  hanging-type,
  hanging-indent,
  line-indent,
  label-width,
  body-format,
  label-format,
  item-format,
  auto-base-level,
  label-align,
  label-baseline,
  auto-resuming,
  auto-label-width,
  checklist,
  enum-config,
  list-config,
  ref-numbering: none, /** new ver0.3.0 */
  supplement: auto, /** new ver0.3.0 */
  tight-mode: auto, /** new ver0.3.0 */
  tight-item-mode: auto, /** new ver0.3.0 */
  step: auto, /** new ver0.3.0 */
  label-inset: auto, /** new ver0.3.0 */
  first-line-inset: auto, /** new ver0.3.0 */
  ..args,
) = {
  let nested-auto-resume = fel.nested-auto-resume
  if auto-resuming != none {
    if auto-resuming == auto {
      context if nested-auto-resume.get() {
        panic("Inside `list` or `enum`, `auto-resuming` can not be set to be `auto` again.")
      }
      nested-auto-resume.update(true)
    }
    if auto-resuming != auto {
      context if fel.item-level.get().len() > 0 {
        panic("Inside `list` or `enum`, `auto-resuming` can not be set to be`" + [#auto-resuming].text + "`.")
      }
      let global-resuming = fel.global-setting-ID-auto-resuming
      context if global-resuming.get() {
        panic("In each document, `auto-resuming` can be set once for non `auto` or `none`.")
      }

      global-resuming.update(true)
    }
  }
  if auto-label-width != none {
    if auto-label-width != auto {
      context if fel.item-level.get().len() > 0 {
        panic("Inside `list` or `enum`, `auto-label-width` can not be set to `" + [#auto-label-width].text + "`.")
      }
      context {
        let global-label-width = fel.global-setting-ID-auto-label-width
        assert(
          not global-label-width.get(),
          message: "In each document, `auto-label-width` can be set once for non `auto` or `none`"
            + "\n"
            + "Hint: set `auto-label-width` to be `auto` and use method `auto-label-item` instead.",
        )
        global-label-width.update(true)
      }
    }
  }

  let override-enum = if auto-resuming == none and auto-label-width == none {
    fel.new-enum
  } else {
    if elem == "list" {
      fel.new-enum
    } else {
      fel.feat-enum.with(auto-resuming: auto-resuming, auto-label-width: auto-label-width)
    }
  }
  let override-list = if auto-resuming == none and auto-label-width == none {
    fel.new-list
  } else {
    if elem == "enum" {
      fel.new-list
    } else {
      if elem == "list" {
        if auto-label-width != none {
          fel.feat-list.with(auto-label-width: auto-label-width)
        } else {
          fel.new-list
        }
      } else {
        // elem == "both"
        fel.feat-list.with(auto-resuming: auto-resuming, auto-label-width: auto-label-width)
      }
    }
  }
  let argument = (
    elem: elem,
    indent: indent,
    body-indent: body-indent,
    label-indent: label-indent,
    is-full-width: is-full-width,
    item-spacing: item-spacing,
    enum-spacing: enum-spacing,
    enum-margin: enum-margin,
    hanging-type: hanging-type, // classic paragraph
    hanging-indent: hanging-indent,
    line-indent: line-indent,
    label-width: label-width,
    body-format: body-format,
    label-format: label-format,
    item-format: item-format,
    label-align: label-align,
    label-baseline: label-baseline,
    checklist: checklist,
    auto-base-level: auto-base-level,
    ref-numbering: ref-numbering, /** new ver0.3.0*/
    supplement: supplement, /** new ver0.3.0  */
    tight-mode: tight-mode, /** new ver0.3.0 */
    tight-item-mode: tight-item-mode, /** new ver0.3.0 */
    step: step, /** new ver0.3.0 */
    label-inset: label-inset, /** new ver0.3.0 */
    first-line-inset: first-line-inset, /** new ver0.3.0 */
  )

  if elem == "both" {
    show enum: override-enum.with(
      ..args,
      ..argument,
      enum-config: enum-config,
      list-config: list-config,
      func-enum: override-enum,
      func-list: override-list,
      absolute-level: true,
    )
    show list: override-list.with(
      ..args,
      ..argument,
      enum-config: enum-config,
      list-config: list-config,
      func-enum: override-enum,
      func-list: override-list,
      absolute-level: true,
    )
    doc
  } else if elem == "enum" {
    show enum: override-enum.with(
      ..args,
      ..argument,
      func-enum: override-enum,
      enum-config: (:),
      list-config: (:),
      absolute-level: false,
    )
    show list: override-list.with(
      elem: "enum",

      is-full-width: false, // make the same behaviour as native one
      // func-enum: override-enum,
      func-list: override-list,
      enum-config: (:),
      list-config: (:),
      absolute-level: false,
    )
    doc
  } else if elem == "list" {
    show enum: override-enum.with(
      elem: "list",

      is-full-width: false, // make the same behaviour as native one
      func-enum: override-enum,
      enum-config: (:),
      list-config: (:),
      absolute-level: false,
    )
    show list: override-list.with(
      ..args,
      ..argument,
      func-list: override-list,
      enum-config: (:),
      list-config: (:),
      absolute-level: false,
    )
    doc
  }
  if auto-resuming == auto {
    nested-auto-resume.update(false)
  }
}


/// Configures default styling for `enum` and `list`.
///
/// - doc (content): The document content to process.
/// - indent (length, array, function, auto): The indent of enum or list (default: auto).
///   - If `indent` is `auto`, the item will be indented by the value of `indent` of `enum` or `list`.
///   - If `indent` is an `array`, whose elements are `length`, `auto` or `array`, each level of the item will be indented by the corresponding value of the array at position `level - 1`. The last value of the array will be used for residual levels.
///     - If the last element of the array is `LOOP`, the values in the array will be used cyclically.
///     - The elements in the array can also be an array, where each element applies to the corresponding item.
///   - If `indent` is a `function`, the return value will be used for each level and each item. The function should be declared as:
///     ```typ
///     it => length | auto | array
///     ```
///     - `it` is a dictionary that contains the following keys:
///       - `level`: The level of the item, starting from 1.
///       - `n`: The index of the item, starting from 1.
///       - `n-last`: The index of the last item in the current level, starting from 1.
///       - `tag`: The tag of the current item.
///       - `enum-tag`: The tag of the current enum.
///       - `label-width`: The label max-width of the item. `label-width` captures the label width of items from level 1 to the current level (i.e., [1, `level`]). Use `(label-width.get)(some-level)` to get the label width at level `some-level` or `label-width.current` for the current level (equivalent to `(label-width.get)(level)`).
///       - `e`: captures the construction (`enum` or `list`) of items from level 1 to the current level. Use `(level-type.get)(some-level)` or `level-type.current`.
///     Here's an example using a `function` to align all `label`s to the left:
///      ```typst
///      #let indent-f = it => {
///         if it.level >= 2 {
///            -(it.label-width.get)(it.level - 1) - (it.e.get)(it.level - 1).body-indent
///          } else {
///            auto
///          }
///      }
///      #show: el.default-enum-list.with(indent: indent-f)
///      ```
///    - If the return value is an `array`, it will be used for each item.
/// - body-indent (length, array, function, auto): Body indentation value (default: auto), i.e., the space between the label and the body of each item.
///   - If `auto`, it uses the value of `body-indent` of `enum` or `list`.
///   - Similar to the `indent` parameter.
/// - label-indent (length, array, function, auto): The indentation value for label (enum's number or list's marker). (default: `0pt` if `auto`).
///   - ⚠️ *Breaking change*: The label-indent now does not impact the width of the label and also the indent of the first line of the body.
///   - Similar to the `indent` parameter.
/// - is-full-width (bool): Whether to use full width (default: true). This may temporarily fix the bug where block-level equations in the item are not center-aligned in some cases (not an ideal solution).
/// - item-spacing (length, array, dictionary, function, auto): Spacing between items (default: auto).
///   - If `length`, the spacing between each item is this value.
///   - If `dictionary`, the key values are `above` and `below`, each of which can be `length` or `auto` (equal to `0pt`).
///
///     Note that this differs from setting `item-spacing` to `length`. The spacing between the current item and the following item increases by `below`, while the spacing between the current item and the preceding item increases by `above`.
///   - If `auto`, it uses the value of `spacing` of `enum` or `list`.
///   - If `array`, each level of the item uses the corresponding value of the array at position `level - 1`.
///     - If the last element of the array is `LOOP`, the values in the array will be used cyclically, else,
///     - The last value is used for residual levels.
///   - If `function`, the return value will be used for each level and each item.
///     - See `indent` for details.
/// - enum-spacing (length, array, dictionary, auto): Spacing between enums and lists (default: auto).
///   - If `auto`, it uses the current paragraph spacing or leading (`par.spacing` or `par.leading`), depending on the `tight` parameter of `enum` or `list`.
///   - Similar to `item-spacing`.
/// - enum-margin (length, array, function, auto): Margin of items for enums and lists (default: auto).
///   - To make `enum-margin` effective, set `is-full-width` to `false`.
///   - If `auto`, the item width is `auto`.
///   - Similar to `item-spacing`.
/// - hanging-indent (length, array, function, auto): The indent for all but the first line of a paragraph (default: auto).
///   - If `auto`, it uses the hanging indent of the current paragraph (`par.hanging-indent`).
///   - Similar to `indent`.
/// - line-indent (length, array, function, auto): The indent for the first line of a paragraph excluding the first paragraph (default: auto).
///   - If `auto`, it uses the first line indent of current paragraph  (`par.first-line-indent.amount`).
///   - Similar to `indent`.
/// - auto-base-level (bool): To maintain compatibility with native behavior, the display of `numbering` and `marker` still uses absolute levels. This means even if you reconfigure `enum.numbering` and `list.marker` in sublists, the display of `numbering` and `marker` in sublists follows the absolute level rules. Default: `false`.
///   - If `auto-base-level` is set to `true`, then it treats the current level as 1.
///   - Note the difference when `enum.full` is set to `true` (only affects the current sublist).
/// - label-baseline (auto, length, array, function, dictionary, "center", "top", "bottom", "top-item", "horizon-item", "bottom-item"): An amount to shift the label baseline by. It can be taken
///   + `length`, `auto` or `"center"`, `"top"`, `"bottom"`, `"top-item"`, `"horizon-item"`, `"bottom-item"`
///   + or a `dictionary` with the keys:
///     - `amount`: `length`, `auto` or `"center"`, `"top"`, `"bottom"`, `"top-item"`, `"horizon-item"`, `"bottom-item"`
///     - `same-line-style` : `"center"`, `"top"`, `"bottom"`
///     - `alone`: `bool`
///     - `relative-to`: Can be taken
///       1. `"bottom"`, `"center"`, `"top"`, `"baseline"` (Relative to the first line of the current item)
///       2. `"top-item"`, `"horizon-item"`, `"bottom-item"` (Relative to the top, horizontal, or bottom of the whole item)
///       3. `content` (The passed content is used to calculate the height)
///       4. `length` (Representing the height of the first line of the current item)
///       5. `array` with 2 elements, the first element can be case 1-2, and the second element can be case 3-4.
///     - `impact-first-line`: `bool`
///   - The first case is interpreted as `(amount: len, same-line-style: "bottom", alone: false, relative-to: "baseline", impact-first-line: false)`
///   - The label baseline will shift based on the value of `amount`, relative to the `relative-to` position.
///   - For `"center"`, `"top"`, and `"bottom"`, the label will be aligned to the center, top, or bottom respectively.
///     - ⚠️ We use the height of the first character (i.e., [A]) in the first line of the paragraph where the label is located. If you manually set the font style of the paragraph's text, this alignment may not be accurate, It is recommended to use the `style` parameter in `body-format` for adjustments.
///     - Or you can pass a `content` to `relative-to`, which will be used to calculate the height.
///     - Or you can pass a `length` to `relative-to`, which represents the height of the first line of the current item.
///   - For `"top-item"`, `"horizon-item"`, and `"bottom-item"`, the label will be aligned to the top, horizontal, or bottom of the whole item respectively.
///   - When the value of `amount` is `auto`, set it to `0pt`.
///   - If labels from different levels appear on the same line, their alignment is determined by `same-line-style`.
///   - If `alone` is `true`, it will not participate in the alignment of labels on the same line.
///   - If `impact-first-line` is `true`, the first line of the label will be affected by the `label-baseline`.
/// - body-format (dictionary, function, none): Sets the *text style* and *border style* of the body (default: none).
///   - `none`: Does not take effect.
///   - `function`: A function to format the item's outer body.
///   - `dictionary` containing the following keys:
///     - `style`: A dictionary that can include any named arguments of `text` to format the text style of `body`.
///     - `whole`, `outer`, `inner`: Dictionaries used to set the borders of the item.
///       - `whole`: Wraps the entire `enum` or `list`
///       - `outer`: Wraps the item (including the label)
///       - `inner`: Wraps the item (excluding the label)
///       - If `whole`, `outer`, or `inner` is omitted, the default is to set the border for `outer`.
///       - `whole`, `outer`, or `inner` can be taken `dictionary` with the following keys:
///         - (consistent with `block` borders): `stroke`, `radius`, `outset`, `fill`, `inset`, `clip`, `breakable`, `sticky`.
///         - `format`: A function to format the item's outer body. The form is: `it => content`, Access
///           - `it.body` to get the current body's content,
///           - `it.level` for the current label's level
///           - `it.tag`: The tag of the current item.
///           - `it.enum-tag`: The tag of the current enum.
///           - `it.n` for the current label's index, and
///           - `it.n-last` for the index of the last label in the current level
///         -  Use the `format` function to replace the `item-format` parameter in ver0.3.0
///         - Limits: For `outer.format` and `whole.format`, if it modifies font size (such as using upper, text.size, strong, etc.), it will affect the width of label content, causing incorrect display. One solution is to apply `label-format` again if such styles are present. In itemize, we do not directly apply the styles from `outer.format` and `whole.format` to the label and then test its height and width (this remains impractical because it affects the entire item (label + body), and we are uncertain about the effects when these styles are applied only to the label).
///     - Each value in `style`, `whole`, `outer`, `inner` is also supported `array` and `function` types.
/// - label-format (function, dictionary, array, none): Customize labels in any way. It takes
///   - `none`: Does not take effect
///   - `function`
///     - The form is: `it => ...`, Access
///       - `it.body` to get the current body's content,
///       - `it.level` for the current label's level
///       - `it.tag`: The tag of the current item.
///       - `it.enum-tag`: The tag of the current enum.
///       - `it.n` for the current label's index, and
///       - `it.n-last` for the index of the last label in the current level
///   - `array`
///     - The (`level-1`)-th element of the array applies to the label at the `level`-th level.
///     - Each element in the array can be:
///       + A `function` with the form `body => ...`, which applies the label's content to this function.
///       + A `content`, which outputs this content directly.
///       + `auto` or `none`, which means no processing will be done.
///       + An `array`:
///         - Its elements follow the meanings of 1, 2, and 3 above.
///         - The (`n-1`)-th element of the array applies to the `n`-th item's label at the current level.
///   - `dictionary`, it can be taken with the following keys:
///     - `stroke`, `radius`, `outset`, `fill`, `inset`, `clip`: The same as `box` arguments.
///     - `width-style`: It takes
///       - "real-width": The actural width of the label.
///       - "label-width": The width of the label ditermined by the `label-width` parameter.
///       - `length` value: The width of the label is this value.
///       - a dictionary with {amount: "real-width"|"label-width"|length, stretched: bool}
///         - If `stretched` is true, the label width set by the current `label-format` (the sum of the `amount` value and the `left` and `right` values in `inset`) determines whether it is rendered as the current label's width. Otherwise, the current label's width is determined by the `label-width` parameter.
///     - `align`: Alignment of the label in width given by `width-style` (default: `right`)
///     - Each value in above keys is also supported `array` and `function` types.
///   - This method can not only control the style of labels, but also control the content displayed by the current label. In the current version `0.2.x`, we recommend using `enum.numbering` (along with the `numbly` package) to control the output content of labels in `enum`, and `list.marker` to control the output content of labels in `list`.
///  - However, this may disrupt the correct positioning of the list labels. (The main reason is that `itemize` needs to treat the label and the first line of the body as the same paragraph.).
/// - label-align (alignment, function, array, auto): The `alignment` that enum numbers and list markers should have.
///   - Unless `auto` is used, it cannot be changed via `#set enum(number-align: ...)`.
///   - For native `list`, it has no such property.
/// - label-width (length, dictionary, array, function, auto): The width of the label.
///   +  `auto`: Uses the native behavior.
///   +  `length`: The width of the label.
///   +  `dictionary`, with keys:
///      - `amount`: `length`, `auto`, or `"max"`.
///      - `style`: `"default"`, `"constant"`, `"auto"`, or `"native"`.
///   - The first case is equivalent to `(amount: len, style: "default")`, where `len` is the specified width value; The second case is equivalent to `(amount: max-width, style: "native")`, where `max-width` is the maximum width of labels at the current level.
///   - Here, `amount` also represents the hanging indent of the item's body (i.e., for the default style, the hanging indent length = `amount` + `body-indent`; for the paragraph style, the hanging indent length = `amount`).
///   - When `amount` is `"max"`, the value of `amount` is the maximum actual width of labels at the current level.
///   - Currently, the setting of `label-width` is also affected by the format of `label-format`, especially when `label-format` specifies width information. In this case, the actual width of the label will be determined by the width specified in `label-format` (usually set via constructs like `box.with(width: ...)`). It is recommended to set the container width in `label-format` to `auto` and then control it via `label-width`.
/// - auto-resuming (none, auto, array, bool): Relate to the feature `Resuming Enum`.
///   - `none`: Disables this feature.
///   - `auto`: Enables this feature. In this case, the following methods can be used.
///      - Use the method `resume()` to continue using the enum numbers from the previous enum at the same level.
///      - Use `resume[...]` to explicitly continue using the enum numbers from the previous level (especially in ambiguous cases) and treat the `[...]` as a new `enum`.
///      - Use the method `resume-label(<some-label>)` to label the enum you want to resume, and then use `resume-list(<some-label>)` in the desired enum to continue using the labelled enum numbers.
///         -  If you use the following in your document:
///            ```typst
///            #show: el.config.ref-resume
///            ```
///            You can use `@some-label` instead of `resume-list(<some-label>)`.
///     - Or use the method `auto-resume-enum(auto-resuming: true)[...]`, where all enum numbers within `[...]` will continue from the previous ones.
///     - The method `isolated-resume-enum[...]` allows the `[...]` to be treated as a new enum with independent numbering, without affecting other enums.
///   - `bool` | `array`: If `auto-resuming` is set to `true`, all enum numbers will continue from the previous ones. It can also be set as an array, e.g., `(false, true)` means the first level does not enable the resuming feature, while subsequent levels do.
///      - For small documents like exams, exercises, or CVs, if you need to resume enum numbers throughout the document, you can use the following at the beginning:
///       ```typst
///       #show : el.default-enum-list.with(auto-resuming: true)
///       ```
///       We recommend using this only at the document's start. Generally,
///         - `el.default-enum-list.with(auto-resuming: true)` and
///         - `el.default-enum-list.with(auto-resuming: auto)`
///       may interfere with each other.
///     - For large documents like books or articles, we recommend not setting `auto-resuming` at the beginning (i.e., leave it as `none`). Instead, set this parameter to `auto` in the required sublists and use it with methods like `resume`, `resume-label`, `resume-list`, or `auto-resume-enum`.
/// - auto-label-width (none, auto, array, "all", "each", "list", "enum"): To ensure consistent first-line indentation of the body across different enums and lists, you can now set `auto-label-width` to `auto` and use the method `auto-label-item` to align the sublists within.
///   - `none`: Disables this feature.
///   - `auto`: Enables this feature and uses the method `auto-label-item` to align the sublists within.
///   - "all", "each", "list", "enum" or an array: The values and meanings of `auto-label-width` are the same as those of the `form` parameter in the `auto-label-item` method.
///    - In a document, `auto-label-width` only retrieves the actual maximum width of labels at the current level of enums and lists.
/// - checklist (bool, array): Enables checklist.
///   - Alternatively, You can also enable and configure checklist-related features using the method `config.checklist`.
/// - args (arguments): Used to format the text of the numbering. Accepts all named parameters of the `text` function (e.g., `fill: red`, `size: 4em`, `weight: "bold"`).
///   - Values can be `array`, `auto` or `function`:
///     - If `auto`, it uses the current `text` value.
///     - If `array`, each level uses the corresponding value of the array at position `level - 1`.
///       - If the last element of the array is `LOOP`, the values in the array will be used cyclically, else,
///       - The last value is used for residual levels.
///    - if `function`, the return value will be used for each level and each item. The function should be declared as:
///     ```typ
///     it => some-value | auto | array
///     ```
///     - `it` is a dictionary that contains the following keys:
///       - `level`: The level of the item.
///       - `n`: The index of the item.
///       - `tag`: The tag of the item.
///       - `enum-tag`: The tag of the enum or list.
///       - `n-last`: The index of the last item.
/// - enum-config (dictionary): Configure `enum` in `doc` (default: (:)).
///    - The parameter type is a dictionary, and the currently allowed properties (keys) are:
///       - `indent`,
///       - `body-indent`,
///       - `label-indent`,
///       - `is-full-width`,
///       - `item-spacing`,
///       - `enum-spacing`,
///       - `enum-margin`,
///       - `hanging-indent`,
///       - `line-indent`,
///       - `label-width`,
///       - `label-align`,
///       - `label-baseline`,
///       - `label-format`,
///       - `body-format`,
///       - `label-inset`,
///       - `first-line-indent`,
///       - `tight-mode`,
///       - `tight-item-mode`,
///       - `step` (only for `enum`),
///       - `ref-numbering` (only for `enum`),
///       - `supplement`
///       - any named arguments of the function `text`
///    - Rules: If both `*-enum-list` and `enum-config` have the same property set, the rules are:
///       - The settings in `enum-config`  take precedence.
///       - For properties of function type, a composite operation is used, where the inner function is provided by `enum-config`:
///           - `label-format`, `item-format`
///       - For properties that are dictionaries composed of multiple attributes, these attributes are merged, and if the same attribute exists, the value from `enum-config` is used.
//            - `body-format`
/// - list-config (dictionary): Configure `list` in `doc` (default: (:)).
///   - Similar to `enum-config`.
/// - ref-numbering (function, str, none): Customize the numbering of each item's reference (default: `none`, determined by `enum.numbering` or `config.ref.numbering`).
/// - supplement (content, dictionary, function, array, auto): Used to set supplementary content when referencing enum labels (default: `auto`).
///   - `auto`: No supplementary content will be added.
///   - `content`: Uses `content` as supplementary content. The effect is that when referencing enum or list labels, `content` is added before the label.
///   - `dictionary`: The keys are: `prefix`, `suffix`, with values of `content`. The effect is that when referencing enum labels, `prefix` content is added before the label, and `suffix` content is added after the label.
///   - `function`: The form is `it => any`, where `it` is a dictionary containing the following keys:
///       - `body`: The referenced enum or list label
///       - `level`: The level of the item.
///       - `n`: The index of the item.
///       - `tag`: The tag of the item.
///       - `enum-tag`: The tag of the enum or list.
///       - `n-last`: The index of the last item.
///   - `array`: Sets `supplement` by level
///   - Note: This is independent of the `config.ref.supplement` setting, meaning the supplement content and the referenced enum or list label will be passed as a whole to `config.ref.supplement`.
/// - tight-mode ("always-tight", "never-tight", "compact-tight", "default", auto, dictionary, function, array): If `enum.spacing` or `list.spacing`, and `enum-spacing` are `auto`, then `tight-mode` is used to determine the spacing between enums or lists.
///   - `"always-tight"`: the above spacing between enums or lists is `par.leading` and below spacing is `par.spacing`
///   - `"never-tight"`: the spacing between enums or lists is `par.spacing`
///   - `"compact-tight"`: the spacing between enums or lists is `par.leading`
///   - `"default"`: the spacing is `"never-tight"` if `enum.tight` or `list.tight` is `true`, else `"compact-tight"` (ver0.2.x default behavior)
///   - `auto`: If set 
///      ```typst
///      #show: el.config.auto-detect-tight
///      ```
///      then the behavior is the same as native, else the behavior is the same as `"default"`.
///   - `dictionary`: The keys are `tight`, `not-tight`, `par-tight`, and values are array with two elements (`length` or `auto`), representing the above and below spacing.
///     - If there is parbreak above the first item, then the above and below spacing between enums or lists are the value of `not-tight`
///     - If there is no parbreak above the first item and if `enum.tight` or `list.tight` 
///       - is `false`, then the above and below spacing between enums or lists are the value of `par-tight`
///       - is `true`, then the above and below spacing between enums or lists are the value of `tight`
///   - Use `function` or `array` to set different values for different levels or other conditions.
/// - tight-item-mode ("always-tight", "never-tight", dictionary, function, array, auto): If `enum.spacing` or `list.spacing`, and `item-spacing` are `auto`, then `tight-item-mode` is used to determine the spacing between items.
///   - `always-tight`: the spacing between items is `par.leading`
///   - `never-tight`: the spacing between items is `par.spacing`
///   - `auto`: if `enum.tight` or `list.tight` is `true`, then the spacing between items is `par.leading`, else the spacing between items is `par.spacing`
///   - `dictionary`: The keys are `tight`, `not-tight`, and values are `length` or `auto`. Now, if `enum.tight` or `list.tight` is `true`, then the spacing between items is the value of `tight`, else the spacing between items is the value of `not-tight`
///   - Use `function` or `array` to set different values for different levels or other conditions.
/// - step (int, function, array, auto): Used to set the step size for enum labels (default: `auto`).
///   - `auto`: the next item's number is `1` greater than the current item's number (native behavior).
///   - `int`: the next item's number is `step` greater than the current item's number.
///   - `function`: the next item's number is the return value of the function. If the return value is `auto` or `none` (used as an initial value), then the next item's number is `1` greater than the current item's number.
///     - The function form is `..nums => int | auto | none`
///     - Here is an example to make items' number like factorial:
///       ```typst
///       #let factorial-step = (..nums) => {
///         let numbers = nums.pos()
///         let n = numbers.len()
///         if n >= 3 {
///           return numbers.at(n - 2) + numbers.at(n - 1)
///         }        
///       }
///       #show: el.default-enum-list.with(step: (factorial-step,))
///       1. #lorem(2)
///       1. #lorem(2)
///       + #lorem(2)
///       + #lorem(2)
///       + #lorem(2)
///       ```
///   - Use `function` or `array` to set different values for different levels or other conditions.
/// - label-inset (length, function, array, auto): Adds an (left) inset to the label, which also affects the width of label.
/// - first-line-inset (length, function, array, auto): Adds an (left) inset to the first line of the body.
/// -> content
#let default-enum-list(
  doc,
  indent: auto,
  body-indent: auto,
  label-indent: auto,
  is-full-width: true,
  item-spacing: auto,
  enum-spacing: auto,
  enum-margin: auto,
  hanging-indent: auto,
  line-indent: auto,
  auto-base-level: false,
  label-width: auto,
  body-format: none,
  label-format: none,
  item-format: none,
  label-align: auto,
  label-baseline: auto,
  auto-resuming: none,
  auto-label-width: none,
  checklist: false,
  ref-numbering: none, /** new ver0.3.0 */
  supplement: auto, /** new ver0.3.0*/
  tight-mode: auto, /** new ver0.3.0 */
  tight-item-mode: auto, /** new ver0.3.0 */
  step: auto, /** new ver0.3.0*/
  label-inset: auto, /** new ver0.3.0 */
  first-line-inset: auto, /** new ver0.3.0 */
  ..args,
  enum-config: (:),
  list-config: (:),
) = {
  return get-list-enum-method(
    doc,
    "both", // "both", "list", "enum"
    indent,
    body-indent,
    label-indent,
    is-full-width,
    item-spacing,
    enum-spacing,
    enum-margin,
    "classic",
    hanging-indent,
    line-indent,
    label-width,
    body-format,
    label-format,
    item-format,
    auto-base-level,
    label-align,
    label-baseline,
    auto-resuming,
    auto-label-width,
    checklist,
    enum-config,
    list-config,
    ref-numbering: ref-numbering, /** new ver0.3.0 */
    supplement: supplement, /** new ver0.3.0*/
    tight-mode: tight-mode, /** new ver0.3.0 */
    tight-item-mode: tight-item-mode, /** new ver0.3.0 */
    step: step, /** new ver0.3.0*/
    label-inset: label-inset, /** new ver0.3.0 */
    first-line-inset: first-line-inset, /** new ver0.3.0 */
    ..args,
  )
}


/// Configures paragraph styling for `enum` and `list`.
///
/// See `default-enum-list`.
#let paragraph-enum-list(
  doc,
  indent: auto,
  body-indent: auto,
  label-indent: auto,
  is-full-width: true,
  item-spacing: auto,
  enum-spacing: auto,
  enum-margin: auto,
  hanging-indent: auto,
  line-indent: auto,
  auto-base-level: false,
  label-width: auto,
  body-format: none,
  label-format: none,
  item-format: none,
  label-align: auto,
  label-baseline: auto,
  auto-resuming: none,
  auto-label-width: none,
  checklist: false,
  ref-numbering: none, /** new ver0.3.0 */
  supplement: auto, /** new ver0.3.0*/
  tight-mode: auto, /** new ver0.3.0 */
  tight-item-mode: auto, /** new ver0.3.0 */
  step: auto, /** new ver0.3.0*/
  label-inset: auto, /** new ver0.3.0 */
  first-line-inset: auto, /** new ver0.3.0 */
  enum-config: (:),
  list-config: (:),
  ..args,
) = {
  return get-list-enum-method(
    doc,
    "both", // "both", "list", "enum"
    indent,
    body-indent,
    label-indent,
    is-full-width,
    item-spacing,
    enum-spacing,
    enum-margin,
    "paragraph",
    hanging-indent,
    line-indent,
    label-width,
    body-format,
    label-format,
    item-format,
    auto-base-level,
    label-align,
    label-baseline,
    auto-resuming,
    auto-label-width,
    checklist,
    enum-config,
    list-config,
    ref-numbering: ref-numbering, /** new ver0.3.0 */
    supplement: supplement, /** new ver0.3.0*/
    tight-mode: tight-mode, /** new ver0.3.0 */
    tight-item-mode: tight-item-mode, /** new ver0.3.0 */
    step: step, /** new ver0.3.0*/
    label-inset: label-inset, /** new ver0.3.0 */
    first-line-inset: first-line-inset, /** new ver0.3.0 */
    ..args,
  )
}

/// Configures default styling for `enum`.
///
/// See `default-enum-list`.
#let default-enum(
  doc,
  indent: auto,
  body-indent: auto,
  label-indent: auto,
  is-full-width: true,
  item-spacing: auto,
  enum-spacing: auto,
  enum-margin: auto,
  hanging-indent: auto,
  line-indent: auto,
  auto-base-level: false,
  label-width: auto,
  body-format: none,
  label-format: none,
  item-format: none,
  label-align: auto,
  label-baseline: auto,
  auto-resuming: none,
  auto-label-width: none,
  ref-numbering: none, /** new ver0.3.0 */
  supplement: auto, /** new ver0.3.0*/
  tight-mode: auto, /** new ver0.3.0 */
  tight-item-mode: auto, /** new ver0.3.0 */
  step: auto, /** new ver0.3.0*/
  label-inset: auto, /** new ver0.3.0 */
  first-line-inset: auto, /** new ver0.3.0 */
  ..args,
) = {
  return get-list-enum-method(
    doc,
    "enum", // "both", "list", "enum"
    indent,
    body-indent,
    label-indent,
    is-full-width,
    item-spacing,
    enum-spacing,
    enum-margin,
    "classic",
    hanging-indent,
    line-indent,
    label-width,
    body-format,
    label-format,
    item-format,
    auto-base-level,
    label-align,
    label-baseline,
    // label-text-indent,
    auto-resuming,
    auto-label-width,
    false,
    (:),
    (:),
    ref-numbering: ref-numbering, /** new ver0.3.0 */
    supplement: supplement, /** new ver0.3.0*/
    tight-mode: tight-mode, /** new ver0.3.0 */
    tight-item-mode: tight-item-mode, /** new ver0.3.0 */
    step: step, /** new ver0.3.0*/
    label-inset: label-inset, /** new ver0.3.0 */
    first-line-inset: first-line-inset, /** new ver0.3.0 */
    ..args,
  )
}

/// Configures paragraph styling for `enum`.
///
/// See `default-enum-list`.
#let paragraph-enum(
  doc,
  indent: auto,
  body-indent: auto,
  label-indent: auto,
  is-full-width: true,
  item-spacing: auto,
  enum-spacing: auto,
  enum-margin: auto,
  hanging-indent: auto,
  line-indent: auto,
  auto-base-level: false,
  label-width: auto,
  body-format: none,
  label-format: none,
  item-format: none,
  label-align: auto,
  label-baseline: auto,
  auto-resuming: none,
  auto-label-width: none,
  ref-numbering: none, /** new ver0.3.0 */
  supplement: auto, /** new ver0.3.0*/
  tight-mode: auto, /** new ver0.3.0 */
  tight-item-mode: auto, /** new ver0.3.0 */
  step: auto, /** new ver0.3.0*/
  label-inset: auto, /** new ver0.3.0 */
  first-line-inset: auto, /** new ver0.3.0 */
  ..args,
) = {
  return get-list-enum-method(
    doc,
    "enum", // "both", "list", "enum"
    indent,
    body-indent,
    label-indent,
    is-full-width,
    item-spacing,
    enum-spacing,
    enum-margin,
    "paragraph",
    hanging-indent,
    line-indent,
    label-width,
    body-format,
    label-format,
    item-format,
    auto-base-level,
    label-align,
    label-baseline,
    auto-resuming,
    auto-label-width,
    false,
    (:),
    (:),
    ref-numbering: ref-numbering, /** new ver0.3.0 */
    supplement: supplement, /** new ver0.3.0*/
    tight-mode: tight-mode, /** new ver0.3.0 */
    tight-item-mode: tight-item-mode, /** new ver0.3.0 */
    step: step, /** new ver0.3.0*/
    label-inset: label-inset, /** new ver0.3.0 */
    first-line-inset: first-line-inset, /** new ver0.3.0 */
    ..args,
  )
}

/// Configures default styling for `list`.
///
/// See `default-enum-list`.
#let default-list(
  doc,
  indent: auto,
  body-indent: auto,
  label-indent: auto,
  is-full-width: true,
  item-spacing: auto,
  enum-spacing: auto,
  enum-margin: auto,
  hanging-indent: auto,
  line-indent: auto,
  auto-base-level: false,
  label-width: auto,
  body-format: none,
  label-format: none,
  item-format: none,
  label-align: auto,
  label-baseline: auto,
  auto-label-width: none,
  checklist: false,
  supplement: auto, /** new ver0.3.0*/
  tight-mode: auto, /** new ver0.3.0 */
  tight-item-mode: auto, /** new ver0.3.0 */
  label-inset: auto, /** new ver0.3.0 */
  first-line-inset: auto, /** new ver0.3.0 */
  ..args,
) = {
  return get-list-enum-method(
    doc,
    "list", // "both", "list", "enum"
    indent,
    body-indent,
    label-indent,
    is-full-width,
    item-spacing,
    enum-spacing,
    enum-margin,
    "classic",
    hanging-indent,
    line-indent,
    label-width,
    body-format,
    label-format,
    item-format,
    auto-base-level,
    label-align,
    label-baseline,
    none,
    auto-label-width,
    checklist,
    (:),
    (:),
    supplement: supplement, /** new ver0.3.0*/
    tight-mode: tight-mode, /** new ver0.3.0 */
    tight-item-mode: tight-item-mode, /** new ver0.3.0 */
    label-inset: label-inset, /** new ver0.3.0 */
    first-line-inset: first-line-inset, /** new ver0.3.0 */
    ..args,
  )
}

/// Configures paragraph styling for `list`.
///
/// See `default-enum-list`.
#let paragraph-list(
  doc,
  indent: auto,
  body-indent: auto,
  label-indent: auto,
  is-full-width: true,
  item-spacing: auto,
  enum-spacing: auto,
  enum-margin: auto,
  hanging-indent: auto,
  line-indent: auto,
  auto-base-level: false,
  label-width: auto,
  body-format: none,
  label-format: none,
  item-format: none,
  label-align: auto,
  label-baseline: auto,
  auto-label-width: none,
  checklist: false,
  supplement: auto, /** new ver0.3.0*/
  tight-mode: auto, /** new ver0.3.0 */
  tight-item-mode: auto, /** new ver0.3.0 */
  label-inset: auto, /** new ver0.3.0 */
  first-line-inset: auto, /** new ver0.3.0 */
  ..args,
) = context {
  return get-list-enum-method(
    doc,
    "list", // "both", "list", "enum"
    indent,
    body-indent,
    label-indent,
    is-full-width,
    item-spacing,
    enum-spacing,
    enum-margin,
    "paragraph",
    hanging-indent,
    line-indent,
    label-width,
    body-format,
    label-format,
    item-format,
    auto-base-level,
    label-align,
    label-baseline,
    none,
    auto-label-width,
    checklist,
    (:),
    (:),
    supplement: supplement, /** new ver0.3.0*/
    tight-mode: tight-mode, /** new ver0.3.0 */
    tight-item-mode: tight-item-mode, /** new ver0.3.0 */
    label-inset: label-inset, /** new ver0.3.0 */
    first-line-inset: first-line-inset, /** new ver0.3.0 */
    ..args,
  )
}
