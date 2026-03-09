#import "fix-enum-list.typ" as fel


/// Configure for the current item
///
/// Positional arguments:
/// - body (content): Content for the current item label; defaults to `none` to preserve existing label
///
/// Named arguments:
/// - indent (length, function, array, none): Current list indentation; defaults to `none` (no change)
/// - body-indent (length, function, array, none): Indentation for both label and body; defaults to `none` (no change)
/// - label-indent (length, function, array, none): First line indentation including label; defaults to `none` (no change)
/// - is-full-width (bool): Full width setting; defaults to `none`
/// - item-spacing (length, function, array, none): Spacing between items; defaults to `none`
/// - enum-spacing (length, function, array, none): Enum-specific spacing; defaults to `none`. Note that this is only used when `item` is in the first item.
/// - hanging-indent (length, function, array, none): Hanging indent for multiline content; defaults to `none`
/// - line-indent (length, function, array, none): Line indentation for nested content; defaults to `none`
/// - label-width (length, dictionary, function, array, none): Label width configuration; defaults to `none`
/// - body-format (dictionary, function, none): Body formatting configuration; defaults to `none`
/// - label-format (dictionary, function, none): Label formatting configuration; defaults to `none`
/// - label-align (alignment, function, array, none): Label alignment setting; defaults to `none`
/// - label-baseline (length, array, function, dictionary, "center", "top", "bottom", "top-item", "horizon-item", "bottom-item", none): Label baseline positioning; defaults to `none`
/// - supplement (content, dictionary, function, array, none): Supplemental content for reference display; defaults to `none`
/// - skipped (bool): Only for enum, whether to skip current label numbering; if `true`, the label's number will use the previous one, otherwise, the label's number will remain unchanged; defaults to `false`
/// - absolute (bool): Whether to use absolute nesting levels; defaults to `false` (relative levels)
/// ``
#let item(..args) = {
  let pos-args = args.pos()
  let body
  if pos-args.len() > 0 {
    body = pos-args.at(0)
    if type(body) != content {
      panic("The argument should be a content.")
    }
  }
  metadata((..args.named(), body: body, kind: fel.item-label-ID))
}

/// Internal function for referencing enumeration labels
///
/// Processes enumeration label references with support for hierarchical numbering,
/// supplement formatting, and item-specific configurations.
#let _ref-enum-label(
  it,
  _full,
  _numbering,
  _supplement,
  no-label-warning,
  real-supplement,
  enum-count: none,
  item-supp: none,
  item-label: none,
) = {
  let enum-count = fel.curr-parent-level.at(it.target)
  if enum-count != () {
    let (
      numbering,
      ref-numbering,
      full,
      auto-base-level,
      curr-enum-level,
      supplement-format,
      n-last,
      level-item,
      tag,
      enum-tag,
    ) = fel.enum-numbering.at(it.target).last()

    if ref-numbering != none {
      numbering = ref-numbering
    } else {
      if _numbering != auto { numbering = _numbering }
    }
    let base-num-count = if auto-base-level { fel.curr-base-parent-level.at(it.target) } else { enum-count }

    let number-body = if item-label == none {
      /// cady-b
      /// https://github.com/tianyi-smile/itemize/issues/9
      let here-num-count = if auto-base-level { fel.curr-base-parent-level.get() } else {
        fel.curr-parent-level.get()
      }

      if (_full == "rel") and here-num-count != () {
        let target-id = fel.auto-id-state.at(it.target).auto-id
        let here-id = fel.auto-id-state.get().auto-id

        let dif = 0
        let min = calc.min(target-id.len(), here-id.len())
        while dif < min and here-id.at(dif) == target-id.at(dif) {
          dif += 1
        }
        if dif > 0 and dif <= here-num-count.len() and here-num-count.at(dif - 1).n != base-num-count.at(dif - 1).n {
          dif -= 1
        }
        if dif == base-num-count.len() {
          dif = base-num-count.len() - 1
        }
        for i in range(dif, base-num-count.len()) {
          fel.apply-numbering-kth(numbering, i, base-num-count.at(i).number)
        }
      } else if (_full == auto and full) or (_full in (true, "rel")) {
        std.numbering(numbering, ..base-num-count.map(e => e.number))
      } else {
        if auto-base-level {
          fel.apply-numbering-kth(numbering, curr-enum-level, base-num-count.last().number)
        } else {
          fel.apply-numbering-kth(numbering, base-num-count.len() - 1, base-num-count.last().number)
        }
      }
    } else {
      item-label
    }

    let index-n = base-num-count.last().n

    let level = if auto-base-level { curr-enum-level } else { base-num-count.len() }
    // for enum's supplement
    let item-supp-format = if item-supp != none {
      fel.pre-parse-supplement(item-supp, level-item(index-n), n-last: n-last, tag: tag, enum-tag: enum-tag)
    } else { supplement-format }
    let enum-supp = item-supp-format(index-n)(number-body)
    link(it.element.location(), [#fel.parse-supplement(
      real-supplement,
      level - 1, 
      none,
      0,
      n-last: n-last,
      tag: tag,
      enum-tag: enum-tag,
    )(index-n)(enum-supp)])
  } else {
    it
  }
}

/// Reference formatter for enumeration items (supports `@` syntax).
///
///   - it: The reference target
///   - full: Whether to show full hierarchical numbering.
///     Default: `auto` (inherits from enum context)
///   - numbering: Numbering pattern or formatter.
///     Default: `auto` (inherits from enum context)
///   - supplement: Supplemental content for reference.
///   - no-label-warning : Show warning for missing labels.
///
/// -> content
#let ref-enum(it, full: auto, numbering: auto, supplement: auto, no-label-warning: false) = {
  let el = it.element
  if el != none {
    let (_full, _numbering) = (full, numbering)
    let _supplement = supplement
    let real-supplement = if it.supplement == auto {
      if _supplement not in (auto, [], none) { _supplement }
    } else { it.supplement }
    let el-func = el.func()
    if (
      el-func == text or el-func == enum.item or el-func == metadata and el.value == fel.enum-label-ID
    ) {
      _ref-enum-label(it, _full, _numbering, _supplement, no-label-warning, real-supplement)
    } else if fel.is-item-label(el) {
      let item-elem = fel.item-level.at(it.target)
      let body = el.value.body
      let item-supp = el.value.at("supplement", default: none)
      if item-elem.len() > 0 and item-elem.last() == "list" {
        // reference for list
        if body == none {
          it
        } else {
          // do not support for level and index properties
          let enum-supp = if item-supp != none {
            let item-supp-format = fel.pre-parse-supplement(item-supp, 0)
            item-supp-format(0)(body)
          }
          link(it.element.location(), [#fel.parse-supplement(
            it.supplement,
            0, // ????
            none,
            0,
          )(0)(enum-supp)])
        }
      } else {
        // reference for enum
        _ref-enum-label(
          it,
          _full,
          _numbering,
          _supplement,
          no-label-warning,
          real-supplement,
          item-supp: item-supp,
          item-label: body,
        )
      }
    } else {
      it
    }
  } else {
    if no-label-warning {
      if query(it.target).len() > 1 {
        it
      } else {
        // do not find the target
        [#text(weight: "bold", fill: red)[#repr(it.target)?]]
      }
    } else { it }
  }
}


/// Creates a labeled reference point for enum items.
///
/// Note:
///   - Only works when attached to `text`/`enum.item` elements
///   - Use this when regular `label()` won't work with enum references
///
/// - name (str, label): Label identifier
///
/// -> content
#let elabel(name) = {
  let _label = fel.get-label(name)
  [#metadata(fel.enum-label-ID)#_label]
}
