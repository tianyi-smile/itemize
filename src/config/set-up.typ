#import "../core/item-lib.typ": ref-enum
#import "../core/feat-item-lib.typ": ref-resume-list
#import "../util/level-state.typ": default-setting-checklist, setting-checklist


/// Configure checklist settings for a document.
/// - doc (any): The document to apply the checklist settings to.
/// - enable (bool, array): Whether the checklist is enabled (default: true).
/// - baseline (auto, "center", "top", "bottom", array): The baseline alignment for checklist labels (same as `label-baseline` with `"center"`, `"top"`, `"bottom"`). Default is `auto`, controlled by `label-width`.
/// - fill (auto, color, array): The fill color for checklist items (default: auto). If set to `auto`, it uses the current label's style.
/// - radius (length, array): The border radius for checklist items (default: .1em).
/// - solid (none, color, array): The solid border style for checklist items (default: none).
/// - extras (bool, array): Whether to enable extra features (default: false). If `true`, then use the following additional commands:
///     ```
///     ">": "➡",
///     "<": "📆",
///     "?": "❓",
///     "!": "❗",
///     "*": "⭐",
///     "\"": "❝",
///     "l": "📍",
///     "b": "🔖",
///     "i": "ℹ️",
///     "S": "💰",
///     "I": "💡",
///     "p": "👍",
///     "c": "👎",
///     "f": "🔥",
///     "k": "🔑",
///     "w": "🏆",
///     "u": "🔼",
///     "d": "🔽",
///     ```
/// - enable-character (bool, array): Whether to enable character-based labels (default: true). When set to `true`, if the character in `[...]` is not among `x, , - /` or the extras characters (if `extras` is `true`), the character in `[...]` will be displayed.
/// - enable-format (bool, array): Whether to enable formatting for the body, with the format content determined by `format-map` (default: false). The default formatting is for the character `"-"`, with the formatting function:
///     ```typst
///     it => strike(text(fill: rgb("#888888"), it))
///     ```
/// - symbol-map (dictionary, function): A map of symbols for checklist items (default: (:)).
///   - Can replace built-in commands or add new ones.
///      - The  format is: `("some-character": content)`.
///   - If a function is specified, its form is: `it => dictionary`, where `it` provides three properties: `fill`, `radius`, `solid`.
/// - format-map (dictionary): A map of formats for checklist items (default: (:)). Formatting for list items.
///   - The format follows: `("some-character": some-function)`.
///   - `some-function` takes the form `it => ...`, It applies the body of the current `some-character` item to this method.
/// -> any
#let config-checklist(
  doc,
  enable: true,
  baseline: auto,
  fill: auto,
  radius: .1em,
  solid: none,
  extras: false,
  enable-character: true,
  enable-format: false,
  symbol-map: (:),
  format-map: (:),
) = {
  setting-checklist.update(dic => {
    dic.prev-checklist.push(dic)
    if dic.enable != enable { dic.enable = enable }
    if dic.label-baseline != baseline { dic.label-baseline = baseline }
    if dic.checklist-fill != fill { dic.checklist-fill = fill }
    if dic.checklist-radius != radius { dic.checklist-radius = radius }
    if dic.checklist-solid != solid { dic.checklist-solid = solid }
    if dic.checklist-map != symbol-map { dic.checklist-map = symbol-map }
    if dic.checklist-format-map != format-map { dic.checklist-format-map = format-map }
    if dic.extras != extras { dic.extras = extras }
    if dic.enable-character != enable-character { dic.enable-character = enable-character }
    if dic.enable-format != enable-format { dic.enable-format = enable-format }
    return dic
  })
  show list: it => it
  doc
  setting-checklist.update(dic => {
    dic.prev-checklist.pop()
  })
}

/// Configure enum reference settings for a document.
/// - doc (any): The document to apply the reference settings to.
/// - full (auto, bool, "ref"): Default is `auto`, using `enum.full`.
///   - `true` displays the full number (including parent levels);
///   - `false` displays only the current item's number;
///   - `"ref"` displays the reference number items in a relative manner (i.e., If the current item and the reference item have the same parent level, the same parent level is not displayed.)
/// - numbering (auto, function, str): Numbering pattern or formatter. Default is `auto`, using the `numbering` of the referenced `enum`. You can customize the style of the referenced item number.
/// - supplement (content, dictionary, function, array, auto): Supplemental content for the reference. (default: `auto`, do not display).
///   - `auto`: No supplementary content will be added.
///   - `content`: Uses `content` as supplementary content. The effect is that when referencing enum or list labels, `content` is added before the label.
///   - `dictionary`: The keys are: `prefix`, `suffix`, with values of `content`. The effect is that when referencing enum (list) labels, `prefix` content is added before the label, and `suffix` content is added after the label.
///   - `function`: The form is `it => any`, where `it` is a dictionary containing the following keys:
///       - `body`: The referenced enum or list label
///       - `level`: The level of the item. (Only work for referencing enum labels.)
///       - `n`: The index of the item. (Only work for referencing enum labels.)
///       - `tag`: The tag of the item. (Only work for referencing enum labels.)
///       - `enum-tag`: The tag of the enum or list. (Only work for referencing enum labels.)
///       - `n-last`: The index of the last item. (Only work for referencing enum labels.)
///   - `array`: Sets `supplement` by level. (Only work for referencing enum labels.)
/// - no-label-warning (bool): Whether to disable the warning when the reference label is not found (default: false); note that this applies to all references in the document, so we recommend _not_ setting it to `true`.
/// -> any
#let config-ref(doc, full: auto, numbering: auto, supplement: auto, no-label-warning: false) = {
  show ref: ref-enum.with(full: full, numbering: numbering, supplement: supplement, no-label-warning: no-label-warning)
  doc
}

/// Configure resume reference settings for a document.
///   - If you use the following in your document:
///      ```typst
///      #show: el.config.ref-resume
///      ```
///
///   then you can use `@some-label` instead of `resume-list(<some-label>)`.
/// - doc (any): The document to apply the resume reference settings to.
/// -> any
#let config-ref-resume(doc) = {
  show ref: ref-resume-list
  doc
}

/// Configure auto-detect-tight settings for a document. If `enable` is `true`, then when there is a paragraph break above a new list with its `tight-mode` being `auto` and current `enum-spacing` being `auto`, the list's `enum-spacing` will be given by the `tight-mode` setting.
///
/// - enable (bool): Enable or disable the auto-detect-tight feature. (default: true)
/// -> any
#let config-auto-detect-tight(doc, enable: true) = {
  if enable == false {
    auto-detect-tight.update(false)
    doc
  } else {
    auto-detect-tight.update(true)
    // for implementing the `auto-detect` feature
    show parbreak: p => {
      if p.has("label") and p.label == paragraph-ID {
        return p
      } else { [#p#metadata(none)#paragraph-ID] }
    }
    doc
    auto-detect-tight.update(false)
  }
}


