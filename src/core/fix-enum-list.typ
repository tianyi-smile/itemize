#import "../lib/checklist.typ": character-symbol, default-format-map, default-symbol-map, small-text
#import "../util/numbering.typ": *

#import "../util/identifier.typ": *
#import "../util/level-state.typ": *
#import "../lib/block-elem-rebuild.typ": *
#import "../util/parse-args.typ": *

#import "../lib/id-lib.typ": *
#import "../lib/par-lib.typ": *

/// Create a hidden line with specified spacing
///
/// - below (length): spacing below the line
/// - above (length): spacing above the line
/// -> content
#let hide-line(below: 0pt, above: 0pt) = block(width: 0pt, height: 0pt, above: above, below: below)

/// Get the baseline position of the body content
///
/// - baseline-label (selector): selector for baseline label elements
/// -> (y-position, height, baseline)
#let get-body-baseline(baseline-label: none) = {
  let e = query(selector(el-baseline-label).after(here()))
  if e.len() == 0 {
    return (0pt, 0pt, 0pt)
  } else {
    let meta = e.first()
    return (meta.location().position().y, meta.value.height, meta.value.baseline)
  }
}


/// Measure the baseline height of the content (one line) whose baseline is not bottom when wraped by `box`
///
/// - body (content): the content of the box
/// -> length
#let get-baseline-inset-in-box(body) = {
  // If the baseline of the body is not bottom (e.g. $vec(1,1,1,)$), then using `box` to wrap the body will cause the baseline of the body to be incorrect. So we need to consider the position of the body baseline.
  // Why we need `[#body#body]`? -- since `body` may be a block-level element.
  return measure([#box[#body]#body]).height - measure([#body#body]).height
}

/// Wrap content in a box with default arguments
#let label-box(body, ..args) = {
  box(..default-box-args, ..args, body)
}

/// Display current label's content
/// -> content
#let label-box-with-baseline(
  body,
  width: 0pt,
  label-inset: 0pt,
  body-inset: 0pt,
  label-align: right,
  fix-height: 0pt,
  fix-baseline: 0pt,
  alone: true,
  alone-shift-baseline: 0pt,
  not-alone-shift-baseline: 0pt,
  baseline-inset: 0pt,
  given-width: auto,
  given-align: right,
  ..format-args,
) = {
  let h-inset = if alone { alone-shift-baseline } else { not-alone-shift-baseline }

  let label-in-box(baseline, given-height: auto, body: body) = {
    label-box(height: given-height)[#h(label-inset)#label-box(
        align(label-align, body),
        width: width,
        // stroke: 1pt + red, // debug
        baseline: baseline,
      )#h(body-inset)#h(0pt, weak: true)]
  }
  let origin-body-box = label-in-box(baseline-inset)
  let minor-height = 0pt
  // only when baseline-inset is not 0pt
  if baseline-inset >= 0.01pt {
    minor-height = (
      measure([#origin-body-box #label-in-box(baseline-inset + fix-baseline + h-inset)]).height
        - measure(origin-body-box).height
    )
  }
  label-in-box(
    baseline-inset + fix-baseline + h-inset,
    given-height: fix-height + minor-height,
    body: label-box(
      {
        if given-align == none {
          given-align = right
        }
        set align(given-align)
        body
      },
      width: given-width,
      ..format-args,
    ),
  )
}

/// Wrap content in a box with infinite width and prevent line breaks
///
/// - body (content): content to wrap
/// - args (dictionary): additional box arguments
/// -> content
#let wrap-box(body, ..args) = {
  hide(
    [#box(width: 0pt, inset: 0pt, ..args, box(
        stroke: 1pt,
        width: 1pt * float.inf,
        inset: 0pt,
        body,
      ))#no-line-break],
  )
}

/// Add to the item's first line (in order to measure the curect baseline of the first line)
/// -> content
#let hold-on-display-label(body, height, baseline, baseline-inset, impact-first-line) = {
  if impact-first-line {
    wrap-box(height: height + baseline-inset, baseline: baseline + baseline-inset, body)
  } else {
    // make sure the baseline is 0pt relative to the body
    wrap-box(height: height - baseline, body)
  }
}

/// Get all labels for display with proper baseline alignment
///
/// - body (content): label content
/// - i (int): item index
/// - base-align (alignment): baseline alignment type
/// - label-height (length): height of the label
/// - curr-baseline (length): current baseline position
/// - baseline-inset (length): baseline inset value
/// - impact-first-line (boolean): whether to impact first line
/// - same-line-style (): same line style configuration
/// -> content
#let get-all-labels(
  body,
  i,
  base-align,
  label-height,
  curr-baseline,
  baseline-inset,
  impact-first-line,
  same-line-style,
) = {
  if base-align == none {
    // Case 1: baseline(fix), `base-align` is `none`
    if i == 0 {
      for p in parent-number-box.get() {
        // for `layout` ????
        let pre-height = p.label-height
        let pre-number = p.body
        let pre-baseline = p.curr-baseline
        let pre-baseline-inset = p.real-label-height - pre-height
        let shift-baseline = get-baseline-with-style(same-line-style, p.label-height, label-height, curr-baseline)
        // Do we let the current first line be affected by the previous labels? (ver0.3.0 no, so we add here `false`)
        if p.alone {
          hold-on-display-label(pre-number, pre-height, pre-baseline, pre-baseline-inset, false)
        } else {
          hold-on-display-label(pre-number, pre-height, shift-baseline, pre-baseline-inset, false)
        }
      }
      hold-on-display-label(body, label-height, curr-baseline, baseline-inset, impact-first-line)
    } else {
      hold-on-display-label(body, label-height, curr-baseline, baseline-inset, impact-first-line)
    }
  } else {
    // Case 2: align with whole item (native)
    none
  }
}


/// Ver0.3.0: Reimplement lists using a new layout method
#let new-enum(
  it,
  elem: "enum",
  indent: auto,
  body-indent: auto,
  label-indent: auto,
  is-full-width: true,
  item-spacing: auto,
  enum-spacing: auto,
  enum-margin: auto,
  hanging-type: "classic", // paragraph
  hanging-indent: auto,
  line-indent: auto,
  absolute-level: false,
  auto-base-level: false, /*new ver0.2.0*/
  label-width: auto, /*new ver0.2.0*/
  body-format: none, /*new ver0.2.0*/
  label-format: none, /*new ver0.2.0*/
  item-format: none, /*new ver0.2.0*/
  label-align: auto, /*new ver0.2.0*/
  label-baseline: auto, /*new ver0.2.0: length*/
  checklist: false, /*new ver0.2.0, for list*/
  func-list: none, /*for format args, identify the elem function to next show*/
  func-enum: none, /*for format args, identify the elem function to next show*/
  curr-level: 0,
  curr-enum-level: 0,
  curr-list-level: 0,
  enum-config: (:), /** config enum only */
  list-config: (:), /** config list only */
  ref-numbering: none, /** new ver0.3.0  */
  supplement: auto, /** new ver0.3.0 for supplement, (prefix, suffix) and function, */
  tight-mode: auto, /** new ver0.3.0 */
  tight-item-mode: auto, /** new ver0.3.0 */
  step: auto, /** new ver0.3.0 */
  label-inset: auto, /** new ver0.3.0 */
  first-line-inset: auto, /** new ver0.3.0 */
  ..args,
) = {
  item-level.update(push("enum"))
  enum-level.update(it => it + 1)

  auto-id-state.update(auto-record-id)
  context {
    // levels
    let abs-level = item-level.get().len() - 1
    let abs-enum-level = enum-level.get() - 1
    // let it-level = if auto-base-level { curr-level } else { abs-level }
    let it-enum-level = if auto-base-level { curr-enum-level } else { abs-enum-level }
    let level = if absolute-level { abs-level } else { abs-enum-level }
    let rel-level = if absolute-level { curr-level } else { curr-enum-level }

    // for the next show-raw
    let all-args = (
      elem: elem,
      indent: indent,
      body-indent: body-indent,
      label-indent: label-indent,
      is-full-width: is-full-width,
      item-spacing: item-spacing,
      enum-spacing: enum-spacing,
      enum-margin: enum-margin,
      hanging-type: hanging-type, // paragraph
      hanging-indent: hanging-indent,
      line-indent: line-indent,
      absolute-level: absolute-level,
      auto-base-level: auto-base-level, /*new ver0.2.0*/
      label-width: label-width, /*new ver0.2.0*/
      body-format: body-format, /*new ver0.2.0*/
      label-format: label-format, /*new ver0.2.0*/
      item-format: item-format, /*new ver0.2.0, not be used for ver0.3.0*/
      label-align: label-align, /*new ver0.2.0*/
      label-baseline: label-baseline, /*new ver0.2.0*/
      checklist: checklist, /*new ver0.2.0*/
      func-enum: func-enum,
      func-list: func-list,
      ref-numbering: ref-numbering, /*new ver0.3.0*/
      supplement: supplement, /*new ver0.3.0*/
      tight-mode: tight-mode, /** new ver0.3.0 */
      tight-item-mode: tight-item-mode, /** new ver0.3.0 */
      step: step, /** new ver0.3.0 */
      label-inset: label-inset, /** new ver0.3.0 */
      first-line-inset: first-line-inset, /** new ver0.3.0 */
      // for levels (to void "layout did not converge within 5 attempts")
      curr-level: curr-level + 1,
      curr-enum-level: curr-enum-level + 1,
      curr-list-level: curr-list-level,
    )
    let next-show = body => {
      if elem == "both" {
        show enum: func-enum.with(
          ..all-args,
          enum-config: enum-config, /** config enum only */
          list-config: list-config, /** config list only */
          ..args,
        )
        show list: func-list.with(
          ..all-args,
          enum-config: enum-config, /** config enum only */
          list-config: list-config, /** config list only */
          ..args,
        )
        body
      } else {
        show enum: func-enum.with(
          ..all-args,
          ..args,
        )
        body
      }
    }

    // config enum function
    let enum-config-args = parse-elem-args(elem-args: enum-config)

    // config item function
    let item-config-args = n => {
      let body = it.children.at(n).body
      if body.func() == func-styled {
        body = body.child
      }
      if body.func() == func-seq and body.children.len() > 0 {
        // parse the arguments of the method `item`
        // should support for checklist for enum? ver0.3.0 no!
        let children = body.children
        if children.len() >= 1 {
          let first = parse-item(children.at(0))
          if first != none {
            parse-item-args(elem-args: first)
          } else {
            default-item-args
            (text-args: none)
          }
        } else {
          default-item-args
          (text-args: none)
        }
      } else {
        let item-e = parse-item(body)
        if item-e != none {
          parse-item-args(elem-args: item-e)
        } else {
          default-item-args
          (text-args: none)
        }
      }
    }

    let level-item = n => if item-config-args(n).absolute { curr-level } else { curr-enum-level }


    // feat (ver0.3.0): The tag of the current item
    let item-tag = n => item-config-args(n).tag
    let item-enum-tag = item-config-args(0).enum-tag

    // The total number of items
    let len = it.children.len()

    let args-with-tags = (tag: item-tag, enum-tag: item-enum-tag, n-last: len)
    let args-with-tags-item = (enum-tag: item-enum-tag, n-last: len) // TODO: ??

    // ref-numbering
    let _ref-numbering = get-none-value(ref-numbering, enum-config-args.ref-numbering)
    assert(
      _ref-numbering == none or type(_ref-numbering) in (str, function),
      message: "ref-numbering must be a string or a function",
    )
    // supplement
    let _supplement = parse-supplement(
      supplement,
      rel-level,
      enum-config-args.supplement,
      curr-enum-level,
      ..args-with-tags,
    )
    // let item-ref-numbering = item-config-args(0).ref-numbering
    // for reference (config)
    enum-numbering.update(push((
      numbering: it.numbering,
      ref-numbering: _ref-numbering,
      full: it.full,
      auto-base-level: auto-base-level,
      curr-enum-level: curr-enum-level,
      supplement-format: _supplement,
      level-item: level-item,
      ..args-with-tags,
    )))

    // format function
    // Limits: For curr-body-format (outer, whole), if it modifies font size (such as using upper, text.size, strong, etc.), it will affect the width of label content, causing incorrect display. One solution is to apply label-format again if such styles are present.
    // In itemize, we do not directly apply the styles from curr-body-format (outer, whole) to the label and then test its height and width (this remains impractical because it affects the entire item (label + body), and we are uncertain about the effects when these styles are applied only to the label).
    let (curr-body-border, curr-body-style, curr-body-format) = {
      let (border-f, style-f, format-f) = parse-body-format(body-format, rel-level, ..args-with-tags)
      let (border-f-e, style-f-e, format-f-e) = parse-body-format(
        enum-config-args.body-format,
        curr-enum-level,
        ..args-with-tags,
      )
      let body-format-item = n => parse-body-format(
        item-config-args(n).body-format,
        level-item(n),
        ..args-with-tags-item,
      )
      (
        for (k, value) in border-f {
          (str(k): n => value(n) + (border-f-e.at(str(k)))(n) + body-format-item(n).at(0).at(str(k))(n))
        },
        n => style-f(n) + style-f-e(n) + body-format-item(n).at(1)(n),
        for (k, f) in format-f {
          (
            str(k): n => body => {
              let f-e = format-f-e.at(str(k))
              let f-item = body-format-item(n).at(2).at(str(k))
              f(n)(f-e(n)(f-item(n)(body)))
            },
          )
        },
      )
    }

    // label-format
    let (curr-label-border, curr-label-format) = {
      let (border-f, format-f) = parse-label-format(label-format, rel-level, ..args-with-tags)
      let (border-f-e, format-f-e) = parse-label-format(
        enum-config-args.label-format,
        curr-enum-level,
        ..args-with-tags,
      )
      let body-format-item = n => parse-label-format(
        item-config-args(n).label-format,
        level-item(n),
        ..args-with-tags-item,
      )
      (
        n => border-f(n) + (border-f-e)(n) + body-format-item(n).at(0)(n),
        n => body => {
          let f-item = body-format-item(n).at(1)
          format-f(n)(format-f-e(n)(f-item(n)(body)))
        },
      )
    }


    // enum's number (label)
    let numbers = ()
    let cur = if it.start == auto { 0 } else { it.start - 1 }

    let item-skipped = n => item-config-args(n).skipped


    // feat: custom step
    // Parse step
    let _step = parse-general-args-with-level(
      step,
      rel-level,
      enum-config-args.step,
      curr-enum-level,
      ..args-with-tags-item,
    )
    if _step == auto or type(_step) == int {
      // common case
      let increment = get-auto-value(_step, 1)
      for i in range(len) {
        let child = it.children.at(i)
        if child.has("number") and child.number not in (none, auto) {
          // typst 0.14
          numbers.push(child.number)
          cur = child.number
        } else {
          if item-skipped(i) == false {
            cur += increment
          }
          numbers.push(cur)
        }
      }
    } else if type(_step) == function {
      for i in range(len) {
        let child = it.children.at(i)
        if child.has("number") and child.number not in (none, auto) {
          // typst 0.14
          numbers.push(child.number)
          cur = child.number
        } else {
          if item-skipped(i) == false {
            let cur-n = _step(..numbers)
            if cur-n in (none, auto) {
              cur += 1
            } else if type(cur-n) == int {
              cur = cur-n
            } else {
              panic("The return value of step function must be `int`, `none` or `auto`.")
            }
          }
          numbers.push(cur)
        }
      }
    } else {
      panic("The step value must be `int`, `function` or `auto`.")
    }


    /*
    feat: custom label (enum's number)
    */
    let text-args = {
      let curr-text-args = parse-text-args(..args, rel-level, ..args-with-tags)
      let elem-text-args = parse-text-args(..enum-config-args.text-args, curr-enum-level, ..args-with-tags)
      let item-text-args = n => parse-text-args(
        ..item-config-args(n).text-args,
        level-item(n),
        ..args-with-tags-item,
      )
      n => curr-text-args(n) + elem-text-args(n) + item-text-args(n)(n)
    }
    let custom-text = n => body => {
      // need all text-args
      set text(..get_current-text-args(text), ..text-args(n), overhang: false)
      curr-label-format(n)(body)
    }

    let resolved(number) = {
      // should will we change (???): ver0.3.0 for function, given full information
      // or type(it.numbering) == function
      if it.full {
        if auto-base-level {
          // use `curr-base-parent-level` to void "layout did not converge within 5 attempts"
          std.numbering(it.numbering, ..curr-base-parent-level.get().map(e => e.number), number)
        } else {
          std.numbering(it.numbering, ..curr-parent-level.get().map(e => e.number), number)
          // std.numbering(it.numbering, ..curr-parent-level.get(), number)
        }
      } else {
        apply-numbering-kth(
          it.numbering,
          it-enum-level,
          number,
        )
      }
    }

    let item-label-body = n => item-config-args(n).body
    let styled-numbers = {
      for (i, number) in numbers.enumerate() {
        let curr-item-label-body = item-label-body(i)
        if curr-item-label-body == none {
          (custom-text(i)(resolved(number)),)
        } else {
          (custom-text(i)(curr-item-label-body),)
        }
      }
    }

    let numbers-size = styled-numbers.map(number => measure(number))
    let numbers-width = numbers-size.map(number => number.width)

    let numbers-height = numbers-size.map(number => number.height)

    let number-max-width = calc.max(..numbers-width)

    /*feat: the style of indent label*/
    let curr-label-width = {
      if enum-config-args.label-width != none {
        parse-label-width(
          enum-config-args.label-width,
          number-max-width,
          curr-enum-level,
          labels-width: numbers-width,
          ..args-with-tags,
        )
      } else {
        parse-label-width(
          label-width,
          number-max-width,
          rel-level,
          ..args-with-tags,
        )
      }
    }

    /*
    need to update
    */
    label-width-enum.update(push(number-max-width))
    label-width-el.update(push(number-max-width))

    /* spacings */
    let (
      indent-f,
      body-indent-f,
      label-indent-f,
      hanging-indent-f,
      line-indent-f,
      enum-width-f,
      enum-above-spacing-f,
      enum-below-spacing-f,
      item-spacing-f,
      label-inset-f,
      first-line-inset-f,
    ) = parse-all-length(
      it,
      rel-level,
      level,
      number-max-width, /*ver0.1.x might change in the future*/
      absolute-level,
      indent: indent,
      body-indent: body-indent,
      label-indent: label-indent,
      is-full-width: is-full-width,
      item-spacing: item-spacing,
      enum-spacing: enum-spacing,
      enum-margin: enum-margin,
      hanging-indent: hanging-indent,
      line-indent: line-indent,
      tight-mode: tight-mode,
      tight-item-mode: tight-item-mode,
      label-inset: label-inset,
      first-line-inset: first-line-inset,
      ..args-with-tags,
    )

    let (
      indent-f-e,
      body-indent-f-e,
      label-indent-f-e,
      hanging-indent-f-e,
      line-indent-f-e,
      enum-width-f-e,
      enum-above-spacing-f-e,
      enum-below-spacing-f-e,
      item-spacing-f-e,
      label-inset-f-e,
      first-line-inset-f-e,
    ) = parse-all-length(
      it,
      curr-enum-level,
      it-enum-level,
      number-max-width, /*ver0.1.x might change in the future*/
      false,
      indent: enum-config-args.indent,
      body-indent: enum-config-args.body-indent,
      label-indent: enum-config-args.label-indent,
      is-full-width: enum-config-args.is-full-width,
      item-spacing: enum-config-args.item-spacing,
      enum-spacing: enum-config-args.enum-spacing,
      enum-margin: enum-config-args.enum-margin,
      hanging-indent: enum-config-args.hanging-indent,
      line-indent: enum-config-args.line-indent,
      tight-mode: enum-config-args.tight-mode,
      tight-item-mode: enum-config-args.tight-item-mode,
      label-inset: enum-config-args.label-inset,
      first-line-inset: enum-config-args.first-line-inset,
      ..args-with-tags,
    )

    let (
      indent-f-item,
      body-indent-f-item,
      label-indent-f-item,
      hanging-indent-f-item,
      line-indent-f-item,
      enum-width-f-item,
      enum-above-spacing-f-item,
      enum-below-spacing-f-item,
      item-spacing-f-item,
      label-inset-f-item,
      first-line-inset-f-item,
    ) = {
      let item-args = n => {
        let args = item-config-args(n)
        parse-all-length(
          it,
          level-item(n),
          abs-enum-level,
          number-max-width, /*ver0.1.x might change in the future*/
          false,
          indent: args.indent,
          body-indent: args.body-indent,
          label-indent: args.label-indent,
          is-full-width: args.is-full-width,
          item-spacing: args.item-spacing,
          enum-spacing: args.enum-spacing,
          enum-margin: args.enum-margin,
          hanging-indent: args.hanging-indent,
          line-indent: args.line-indent,
          tight-mode: item-config-args(0).tight-mode, //
          tight-item-mode: item-config-args(0).tight-item-mode, //
          label-inset: args.label-inset,
          first-line-inset: args.first-line-inset,
          ..args-with-tags-item,
        )
      }
      let args-size = 11
      for i in range(args-size) {
        (n => item-args(n).at(i),)
      }
    }

    let (
      curr-indent,
      curr-body-indent,
      curr-label-indent,
      curr-hanging-indent,
      curr-line-indent,
      enum-width,
      enum-above-spacing,
      enum-below-spacing,
      curr-item-spacing,
      curr-label-inset,
      curr-first-line-inset,
    ) = (
      n => get-none-value(indent-f(n), get-none-value(indent-f-e(n), indent-f-item(n)(n))),
      n => get-none-value(body-indent-f(n), get-none-value(body-indent-f-e(n), body-indent-f-item(n)(n))),
      n => get-none-value(label-indent-f(n), get-none-value(label-indent-f-e(n), label-indent-f-item(n)(n))),
      n => get-none-value(hanging-indent-f(n), get-none-value(hanging-indent-f-e(n), hanging-indent-f-item(n)(n))),
      n => get-none-value(line-indent-f(n), get-none-value(line-indent-f-e(n), line-indent-f-item(n)(n))),
      n => get-none-value(enum-width-f(n), get-none-value(enum-width-f-e(n), enum-width-f-item(n)(n))),
      get-none-value(enum-above-spacing-f, get-none-value(enum-above-spacing-f-e, enum-above-spacing-f-item(0))),
      get-none-value(enum-below-spacing-f, get-none-value(enum-below-spacing-f-e, enum-below-spacing-f-item(0))),
      n => get-none-value(item-spacing-f(n), get-none-value(item-spacing-f-e(n), item-spacing-f-item(n)(n))),
      n => get-none-value(label-inset-f(n), get-none-value(label-inset-f-e(n), label-inset-f-item(n)(n))),
      n => get-none-value(first-line-inset-f(n), get-none-value(
        first-line-inset-f-e(n),
        first-line-inset-f-item(n)(n),
      )),
    )


    if not auto-base-level {
      curr-base-parent-level.update(())
    }

    // label-align
    let curr-label-align = parse-general-args-with-level-n(
      label-align,
      rel-level,
      enum-config-args.label-align,
      curr-enum-level,
      it.number-align,
      n => item-config-args(n).label-align,
      level-item,
      ..args-with-tags,
    )

    // label-baseline
    let curr-label-baseline = parse-general-args-with-level-n(
      label-baseline,
      rel-level,
      enum-config-args.label-baseline,
      curr-enum-level,
      0pt,
      n => item-config-args(n).label-baseline,
      level-item,
      ..args-with-tags,
    )


    // Used to determine whether the `above` and `below` attributes of `item-spacing` are used in the first and last items
    let using-first-full-item = []
    let using-last-full-item = []

    let min-indent = float.inf * 1pt

    let dir = if text.dir == rtl { "right" } else { "left" }

    // each item
    let item-body = for i in range(len) {
      let child = it.children.at(i)
      let index = if it.reversed { len - i - 1 } else { i }

      let child-number = numbers.at(index)
      let curr-width = numbers-width.at(index).to-absolute()

      let styled-child-number = styled-numbers.at(index)

      // update: parent-level
      curr-parent-level.update(push((n: i, number: child-number)))

      if auto-base-level {
        curr-base-parent-level.update(push((n: i, number: child-number)))
      }

      let item-item-label-width = item-config-args(i).label-width
      let (amount, style) = if item-item-label-width != none {
        parse-label-width(
          item-item-label-width,
          number-max-width,
          level-item(i),
          labels-width: numbers-width,
          ..args-with-tags-item,
        )(i)
      } else { curr-label-width(i) }

      let max-width = if amount == auto { curr-width } else { amount }


      /* enum'number (label) */
      let number-width = if style == "native" {
        number-max-width
      } else if amount != auto {
        if style == "default" {
          if curr-width <= amount.to-absolute() { amount } else { curr-width }
        } else if style == "constant" {
          amount
        } else if style == "auto" {
          curr-width
        }
      } else { max-width }

      let curr-text-style = (curr-body-style)(i)

      let curr-text-size = {
        if curr-text-style != none {
          let size = curr-text-style.at("size", default: none)
          if size != none {
            (size: size)
          }
        }
        (:)
      }

      let _enum-width = enum-width(i)
      let _item-spacing = curr-item-spacing(i)

      let _label-indent = curr-label-indent(i).to-absolute()
      let _label-inset = curr-label-inset(i).to-absolute()
      let _first-line-inset = curr-first-line-inset(i).to-absolute()
      let _body-indent = curr-body-indent(i).to-absolute()
      let _indent = curr-indent(i).to-absolute()
      if _indent < min-indent { min-indent = _indent }

      let real-box-width = number-width.to-absolute()
      let real-box-height = numbers-height.at(index).to-absolute()

      // feat (ver0.3.0): label-border
      let label-border = curr-label-border(i)
      let (label-border-inset, label-border-align, label-width-style) = {
        if label-border != none {
          (
            label-border.at("inset", default: none),
            label-border.remove("align", default: none),
            label-border.remove("width-style", default: none),
          )
        } else {
          (none, none, none)
        }
      }

      let (_label-inset-top, _label-inset-bottom, _label-inset-left, _label-inset-right) = if (
        label-border-inset != none
      ) {
        for dir in ("top", "bottom") {
          let _inset = get-dir-inset(label-border-inset, dir: dir)
          let _inset-abs = get-absolute-length(_inset)
          let _inset-ratio = get-relative-ratio(_inset)
          let _inset = _inset-abs + _inset-ratio * real-box-height
          (_inset,)
        }
        for dir in ("left", "right") {
          let _inset = get-dir-inset(label-border-inset, dir: dir)
          let _inset-abs = get-absolute-length(_inset)
          let _inset-ratio = get-relative-ratio(_inset)
          let _inset = _inset-abs + _inset-ratio * real-box-width
          (_inset,)
        }
      } else { (0pt, 0pt, 0pt, 0pt) }

      // width-style
      let x-inset = _label-inset-left + _label-inset-right
      let (label-amount, label-stretched) = parse-label-width-style(
        label-width-style,
        curr-width,
        real-box-width,
        x-inset,
      )
      let box-width = real-box-width + if label-stretched { x-inset }
      let box-height = real-box-height + _label-inset-top


      let baseline-inset = get-baseline-inset-in-box(styled-child-number).to-absolute()

      let label-height = box-height - baseline-inset

      /*label baseline*/
      let (
        curr-baseline,
        same-line-style,
        base-align, /*ver0.3.0: different meaning*/
        is-alone,
        // label-height,
        relative-to, /*ver0.3.0*/
        impact-first-line, /*ver0.3.0*/
      ) = parse-baseline(
        curr-label-baseline(i),
        styled-child-number,
        curr-text-style,
        label-height: label-height,
      )


      /* current label */
      let label-box-fix-baseline(
        fix-baseline: 0pt,
        alone-shift-baseline: 0pt,
        not-alone-shift-baseline: 0pt,
        alone: true,
        fix-height: 0pt,
      ) = label-box-with-baseline(
        styled-child-number,
        width: box-width,
        fix-baseline: fix-baseline,
        label-inset: _label-indent + _label-inset, // TODO
        body-inset: _body-indent,
        label-align: curr-label-align(i),
        alone: alone,
        fix-height: fix-height + _label-inset-bottom, // TODO
        alone-shift-baseline: alone-shift-baseline,
        not-alone-shift-baseline: not-alone-shift-baseline,
        baseline-inset: baseline-inset,
        ..label-border,
        given-width: label-amount,
        given-align: label-border-align,
      )
      // all the labels (ver0.3.0: feat)
      let hide-number = get-all-labels(
        styled-child-number,
        i,
        base-align,
        label-height,
        curr-baseline,
        baseline-inset,
        impact-first-line,
        same-line-style,
      )


      // pre-parse body (in order to determine how to display label)
      let new-body = detect-block-level-elem(
        child.body,
        number: hide-number,
        label-height: label-height,
        curr-baseline: curr-baseline,
        body: styled-child-number,
        alone: is-alone,
        real-label-height: box-height,
      )

      // flag: show in same-line (like: 1.a.I.)
      let is-holding = false
      let (inline, body) = new-body
      let item-content = if inline == InlineType.list {
        // enum or list
        is-holding = true
        if base-align == none {
          parent-number-box.update(
            push((
              body: styled-child-number,
              label-height: label-height,
              curr-baseline: curr-baseline,
              alone: is-alone,
              real-label-height: box-height,
            )),
          )
        }
        [#body]
      } else {
        // block-level or inline-level
        parent-number-box.update(())
        if inline == InlineType.blank {
          [#body#hide-number#baseline-tag-meta(height: label-height, baseline: curr-baseline, weak: false)]
        } else {
          [#parbreak()#body]
        }
      }

      let curr-block-args = get-current-block-args(block)
      let item-baseline-align = if base-align == none { start } else { base-align }
      let alone = if is-holding { is-alone } else { true }
      let label-cell = grid.cell(x: 0, align: item-baseline-align, {
        if base-align == none {
          context {
            let (dy, final-label-height, final-baseline) = get-body-baseline()
            let curr-dy = here().position().y
            let fix-baseline = dy - curr-dy
            let p-baseline = get-baseline-with-style(
              same-line-style,
              label-height,
              final-label-height,
              final-baseline,
            )
            let max-height = box-height
            for p in parent-number-box.get() {
              // Since it occurs not many times, it doesn't matter to repeat the comparison multiple times
              if max-height < p.real-label-height {
                max-height = p.real-label-height
              }
            }
            label-box-fix-baseline(
              alone-shift-baseline: curr-baseline,
              not-alone-shift-baseline: p-baseline,
              fix-baseline: fix-baseline,
              alone: alone,
              fix-height: max-height,
            )
          }
          // label-box-fix-baseline(alone: true, fix-height: real-label-height)
        } else {
          label-box-fix-baseline(alone: true, fix-height: box-height)
        }
      })

      let inner-box(body) = (curr-body-format.inner)(i)(show-text((curr-body-style)(i), body))

      /* hanging-indent, first-line-indent */
      let _temp-line-indent = curr-line-indent(i)
      let _line-indent = if _temp-line-indent == auto { auto } else { _temp-line-indent.to-absolute() }
      let _temp-hanging-indent = curr-hanging-indent(i)
      let _hanging-indent = if _temp-hanging-indent == auto { auto } else { _temp-hanging-indent.to-absolute() }

      let body-cell = grid.cell(x: 1)[
        // override (next)
        // #show grid: set block(..default-block-args) // need
        #inner-box({
          let (par-line-indent, par-hanging-indent) = {
            if hanging-type == "classic" {
              (0pt, 0pt)
            } else if hanging-type == "paragraph" {
              (-max-width - _body-indent, -max-width - _body-indent)
            }
          }
          par-state.update(0)
          let _first-line-indent = -max-width + real-box-width + _first-line-inset
          /// Note that: `hanging-indent` and `first-line-indent` of the `par` in the lists are no longer in effect if `_line-indent` and `_hanging-indent` are not `auto`.
          show par: par-box.with(
            line-indent: _line-indent,
            hanging-indent: _hanging-indent,
            line-inset: par-line-indent,
            hanging-inset: par-hanging-indent,
            first-line-indent: _first-line-indent,
          )
          // Sepecial case: terms
          show: fix-terms
          // #set block(..default-block-args)
          set block(..curr-block-args) // need
          item-content
        })
      ]
      // feat: item-spacing with above and below
      let is-full-item-spacing = false
      let above-item-spacing
      let below-item-spacing
      if type(_item-spacing) == dictionary {
        above-item-spacing = _item-spacing.remove("above", default: 0pt)
        above-item-spacing = get-auto-value(above-item-spacing, 0pt)
        below-item-spacing = _item-spacing.remove("below", default: 0pt)
        below-item-spacing = get-auto-value(below-item-spacing, 0pt)
        assert(
          type(above-item-spacing) in length-type-with-fraction
            and type(below-item-spacing) in length-type-with-fraction
            and _item-spacing == (:),
          message: "The key value of item-spacing must be \"above\" and \"below\", with value be a length or `auto`",
        )
        is-full-item-spacing = true
      }

      /* item-spacing */
      let (above-spacing, below-spacing) = if is-full-item-spacing == false {
        if i == 0 {
          if i == len - 1 {
            // last and first
            (enum-above-spacing, enum-below-spacing)
          } else {
            // first but not last
            (enum-above-spacing, _item-spacing)
          }
        } else if i == len - 1 {
          // last but not first
          (_item-spacing, enum-below-spacing)
        } else {
          // not first and not last
          (_item-spacing, _item-spacing)
        }
      } else {
        if i == 0 {
          using-first-full-item = hide-line(above: enum-above-spacing)
        }
        if i == len - 1 {
          using-last-full-item = hide-line(below: enum-below-spacing)
        }
        (above-item-spacing, below-item-spacing)
      }


      // label-cell-width too large, and body-cell-width is negative? Now we can't handle it
      let label-cell-width = box-width + _label-inset + _body-indent + _indent
      let body-cell-width = if _enum-width == 100% { 1fr } else {
        if _enum-width == auto { auto } else {
          _enum-width - label-cell-width
        }
      }


      let inner-border = (curr-body-border.inner)(i)
      let inner-outset = inner-border.remove("outset", default: (:))
      let inner-dir-outset = get-dir-inset(inner-outset, dir: dir)
      inner-outset = parse-inset-without-dir(inner-outset, dir: dir)
      inner-outset.insert(dir, -label-cell-width + inner-dir-outset)

      let inner-inset = inner-border.remove("inset", default: (:))
      let inner-dir-inset = get-dir-inset(inner-inset, dir: dir)
      inner-inset = parse-inset-without-dir(inner-inset, dir: dir)

      let inset = if text.dir == rtl {
        (right: _indent, left: -_label-indent, rest: 0pt)
      } else {
        (left: _indent, right: -_label-indent, rest: 0pt)
      }

      let sec-inset = if text.dir == rtl {
        (right: max-width - real-box-width + inner-dir-inset, rest: 0pt) + inner-inset
      } else {
        (left: max-width - real-box-width + inner-dir-inset, rest: 0pt) + inner-inset
      }


      let outer-border = (curr-body-border.outer)(i)
      let outer-outset = outer-border.remove("outset", default: (:))
      let outer-dir-outset = get-dir-inset(outer-outset, dir: dir)
      outer-outset = parse-inset-without-dir(outer-outset, dir: dir)
      outer-outset.insert(dir, -_indent + outer-dir-outset)

      let (out-spacing, inner-spacing) = {
        if outer-border == (:) {
          ((:), (above: above-spacing, below: below-spacing))
        } else {
          ((above: above-spacing, below: below-spacing), (:))
        }
      }

      let outer-block(body) = make-format-box.with(
        format-args: outer-border,
        outset: outer-outset,
        ..out-spacing,
      )(body)
      // display: label + body
      let outer-body = (curr-body-format.outer)(i)()[
        #show grid.where(label: grid-ID): set block(
          // inner
          ..default-block-args,
          ..inner-spacing,
          ..inner-border,
          outset: inner-outset,
        )
        // override
        // need
        #show grid.cell: set block(..default-block-args)
        #grid(
          ..default-grid-args,
          // for debug
          // stroke: 1pt + red,
          columns: (label-cell-width, body-cell-width),
          inset: (inset, sec-inset),
          label-cell, body-cell,
        )#grid-ID
      ]
      if is-full-item-spacing { [#hide-line()] }
      outer-block(outer-body)
      if is-full-item-spacing { [#hide-line()] }

      curr-parent-level.update(pop)

      if auto-base-level {
        curr-base-parent-level.update(pop)
      }
    }

    let whole-border = (curr-body-border.whole)(0)
    let whole-outset = whole-border.remove("outset", default: (:))
    let dir-outset = get-dir-inset(whole-outset, dir: dir)
    whole-outset = parse-inset-without-dir(whole-outset, dir: dir)
    whole-outset.insert(dir, -min-indent + dir-outset)
    let is-whole-block = whole-border != (:)
    let whole-block = make-format-box.with(
      format-args: whole-border,
      outset: whole-outset,
      above: enum-above-spacing,
      below: enum-below-spacing,
    )
    // display-whole
    if not is-whole-block { using-first-full-item }
    whole-block((curr-body-format.whole)(0)(next-show(item-body)))
    if not is-whole-block { using-last-full-item }
  }

  label-width-enum.update(pop)
  label-width-el.update(pop)
  item-level.update(pop)
  enum-level.update(it => it - 1)

  enum-numbering.update(pop)

  auto-id-state.update(auto-pop-id)
}

/// Ver0.3.0: Reimplement lists using a new layout method
#let new-list(
  it,
  elem: "list",
  indent: auto,
  label-indent: 0em,
  body-indent: auto,
  is-full-width: true,
  item-spacing: auto,
  enum-spacing: auto,
  enum-margin: auto,
  hanging-type: "classic", // paragraph
  hanging-indent: auto,
  line-indent: auto,
  absolute-level: false,
  auto-base-level: false, /*new ver0.2.0*/
  label-width: auto, /*new ver0.2.0*/
  body-format: none, /*new ver0.2.0*/
  label-format: none, /*new ver0.2.0*/
  item-format: none, /*new ver0.2.0*/
  checklist: false, /*new ver0.2.0, for list*/
  label-align: auto, /*new ver0.2.0*/
  label-baseline: auto, /*new ver0.2.0*/
  func-list: none, /*for format args, identify the elem function to next show*/
  func-enum: none, /*for format args, identify the elem function to next show*/
  curr-level: 0,
  curr-enum-level: 0,
  curr-list-level: 0,
  enum-config: (:), /** config enum only */
  list-config: (:), /** config list only */
  ref-numbering: none, /** new ver0.3.0 for enum */
  supplement: auto, /** new ver0.3.0 for enum */
  tight-mode: auto, /** new ver0.3.0 */
  tight-item-mode: auto, /** new ver0.3.0 */
  step: auto, /** new ver0.3.0 for enum */
  label-inset: auto, /** new ver0.3.0 */
  first-line-inset: auto, /** new ver0.3.0 */
  ..args,
) = {
  item-level.update(push("list"))
  list-level.update(it => it + 1)

  context {
    // levels
    let abs-level = item-level.get().len() - 1
    let abs-list-level = list-level.get() - 1
    // let it-level = if auto-base-level { curr-level } else { abs-level }
    let it-list-level = if auto-base-level { curr-list-level } else { abs-list-level }
    let level = if absolute-level { abs-level } else { abs-list-level }
    let rel-level = if absolute-level { curr-level } else { curr-list-level }

    // for the next show-raw
    let all-args = (
      elem: elem,
      indent: indent,
      body-indent: body-indent,
      label-indent: label-indent,
      is-full-width: is-full-width,
      item-spacing: item-spacing,
      enum-spacing: enum-spacing,
      enum-margin: enum-margin,
      hanging-type: hanging-type, // paragraph
      hanging-indent: hanging-indent,
      line-indent: line-indent,
      absolute-level: absolute-level,
      auto-base-level: auto-base-level, /*new ver0.2.0*/
      label-width: label-width, /*new ver0.2.0*/
      body-format: body-format, /*new ver0.2.0*/
      label-format: label-format, /*new ver0.2.0*/
      item-format: item-format, /*new ver0.2.0*/
      label-align: label-align, /*new ver0.2.0*/
      label-baseline: label-baseline, /*new ver0.2.0*/
      checklist: checklist, /*new ver0.2.0*/
      func-enum: func-enum,
      func-list: func-list,
      ref-numbering: ref-numbering, /*new ver0.3.0*/
      supplement: supplement, /*new ver0.3.0*/
      tight-mode: tight-mode, /** new ver0.3.0 */
      tight-item-mode: tight-item-mode, /** new ver0.3.0 */
      step: step, /** new ver0.3.0 */
      label-inset: label-inset, /** new ver0.3.0 */
      first-line-inset: first-line-inset, /** new ver0.3.0 */
      // for levels (to void "layout did not converge within 5 attempts")
      curr-level: curr-level + 1,
      curr-enum-level: curr-enum-level,
      curr-list-level: curr-list-level + 1,
    )
    let next-show = body => {
      if elem == "both" {
        show enum: func-enum.with(
          ..all-args,
          enum-config: enum-config, /** config enum only */
          list-config: list-config, /** config list only */
          ..args,
        )
        show list: func-list.with(
          ..all-args,
          enum-config: enum-config, /** config enum only */
          list-config: list-config, /** config list only */
          ..args,
        )
        body
      } else {
        show list: func-list.with(
          ..all-args,
          ..args,
        )
        body
      }
    }

    // format list function
    let list-config-args = parse-elem-args(elem-args: list-config)

    let item-config-args = get-item-config-args(it.children)
    // feat (ver0.3.0): The tag of the current item
    let item-tag = n => item-config-args(n).tag
    let item-enum-tag = item-config-args(0).enum-tag

    // The total number of items
    let len = it.children.len()

    let args-with-tags = (tag: item-tag, enum-tag: item-enum-tag, n-last: len)
    let args-with-tags-item = (enum-tag: item-enum-tag, n-last: len) // TODO: ??

    let level-item = n => if item-config-args(n).absolute { curr-level } else { curr-list-level }

    // format function
    let (curr-body-border, curr-body-style, curr-body-format) = {
      let (border-f, style-f, format-f) = parse-body-format(body-format, rel-level, ..args-with-tags)
      let (border-f-e, style-f-e, format-f-e) = parse-body-format(
        list-config-args.body-format,
        curr-list-level,
        ..args-with-tags,
      )
      let body-format-item = n => parse-body-format(
        item-config-args(n).body-format,
        level-item(n),
        ..args-with-tags-item,
      )
      (
        for (k, value) in border-f {
          (str(k): n => value(n) + (border-f-e.at(str(k)))(n) + body-format-item(n).at(0).at(str(k))(n))
        },
        n => style-f(n) + style-f-e(n) + body-format-item(n).at(1)(n),
        for (k, f) in format-f {
          (
            str(k): n => body => {
              let f-e = format-f-e.at(str(k))
              let f-item = body-format-item(n).at(2).at(str(k))
              f(n)(f-e(n)(f-item(n)(body)))
            },
          )
        },
      )
    }

    // label-format
    let (curr-label-border, curr-label-format) = {
      let (border-f, format-f) = parse-label-format(label-format, rel-level, ..args-with-tags)
      let (border-f-e, format-f-e) = parse-label-format(
        list-config-args.label-format,
        curr-list-level,
        ..args-with-tags,
      )
      let body-format-item = n => parse-label-format(
        item-config-args(n).label-format,
        level-item(n),
        ..args-with-tags-item,
      )
      (
        n => border-f(n) + (border-f-e)(n) + body-format-item(n).at(0)(n),
        n => body => {
          let f-item = body-format-item(n).at(1)
          format-f(n)(format-f-e(n)(f-item(n)(body)))
        },
      )
    }


    /*
    feat: custom label (list's marker)
    */
    let text-args = {
      let curr-text-args = parse-text-args(
        ..args,
        rel-level,
        ..args-with-tags,
      )
      let elem-text-args = parse-text-args(..list-config-args.text-args, curr-list-level, ..args-with-tags)
      let item-text-args = n => parse-text-args(
        ..item-config-args(n).text-args,
        level-item(n),
        ..args-with-tags-item,
      )
      n => curr-text-args(n) + elem-text-args(n) + item-text-args(n)(n)
    }
    let custom-text = n => body => {
      set text(..get_current-text-args(text), ..text-args(n), overhang: false)
      curr-label-format(n)(body)
    }

    /*
    feat: description-list (like terms)
    */
    let desc-marker = ()
    let checklist-body = ()

    let setting = setting-checklist.get()
    let curr-checklist = get-depth-value(checklist, rel-level) or get-depth-value(setting.enable, curr-list-level) // for setting, use `curr-list-level`

    let fill-check
    let radius-check
    let solid-check
    let symbol-map = (:)
    let format-map = (:)
    let symbol-list
    let enable-character
    let checklist-label-baseline = none
    if curr-checklist {
      // since checklist works only for list, here, the level uses the `curr-list-level`
      fill-check = get-depth-value(setting.checklist-fill, curr-list-level)
      radius-check = get-depth-value(setting.checklist-radius, curr-list-level)
      solid-check = get-depth-value(setting.checklist-solid, curr-list-level)
      let checklist-map = get-depth-value(setting.checklist-map, curr-list-level)
      checklist-label-baseline = get-depth-value(setting.label-baseline, curr-list-level)
      let _temp-symbol-map
      if type(checklist-map) == function {
        _temp-symbol-map = checklist-map(
          (fill: fill-check, radius: radius-check, solid: solid-check),
        )
      } else if type(checklist-map) == dictionary {
        _temp-symbol-map = checklist-map
      }
      if type(_temp-symbol-map) == dictionary {
        symbol-map = for (k, v) in _temp-symbol-map { (str(k): small-text(v)) }
      }

      enable-character = get-depth-value(setting.enable-character, curr-list-level)
      let extras = get-depth-value(setting.extras, curr-list-level)
      symbol-list = (
        default-symbol-map(fill: fill-check, radius: radius-check, solid: solid-check, extras: extras) + symbol-map
      )
      let enable-format = get-depth-value(setting.enable-format, curr-list-level)
      if enable-format {
        let checklist-format-map = get-depth-value(setting.checklist-format-map, curr-list-level)
        format-map = default-format-map + checklist-format-map
      }
    }


    for child in it.children {
      let body = child.body
      if body.func() == func-styled {
        /// should be considered (due to the bug of native item and list)
        /// see the following code
        /// ```typ
        /// #set text(size: 2em, fill: red)
        /// -  #text(size: 2em)[[A] 1]
        /// - [A]
        /// - 22222
        /// - ffff
        /// ```
        body = child.body.child
      }
      if body.func() == func-seq and body.children.len() > 0 {
        // checklist
        let children = body.children
        if curr-checklist {
          // A checklist item has at least 4 children: `[`, marker, `]`, content
          if (
            children.len() < 3 or not (children.at(0) == [#"["] and children.at(2) == [#"]"])
          ) {
            desc-marker.push(get_desc-marker(children.at(0)))
            checklist-body.push(false)
          } else {
            let marker-text = get_marker-text(children.at(1))

            if marker-text != none {
              let marker-symbol = symbol-list.at(marker-text, default: none)
              if marker-symbol != none {
                desc-marker.push(marker-symbol)
                let format = format-map.at(marker-text, default: none)
                if format == none {
                  checklist-body.push(true)
                } else {
                  checklist-body.push(format)
                }
              } else {
                if enable-character {
                  desc-marker.push(character-symbol(
                    symbol: marker-text,
                    fill: fill-check,
                    radius: radius-check,
                    solid: solid-check,
                  ))
                  let format = format-map.at(marker-text, default: none)
                  if format == none {
                    checklist-body.push(true)
                  } else {
                    checklist-body.push(format)
                  }
                } else {
                  desc-marker.push(none)
                  checklist-body.push(false)
                }
              }
            } else {
              desc-marker.push(none)
              checklist-body.push(false)
            }
          }
        } else {
          desc-marker.push(get_desc-marker(children.at(0)))
        }
      } else {
        desc-marker.push(get_desc-marker(body))
        if curr-checklist {
          checklist-body.push(false)
        }
      }
    }


    let marker-level = it-list-level
    let marker = {
      if type(it.marker) == array {
        if it.marker == () {
          it.marker
        } else {
          it.marker.at(calc.rem(marker-level, it.marker.len()))
        }
      } else {
        it.marker
      }
    }

    let marker-display = n => {
      let desc = desc-marker.at(n, default: none)
      if desc != none {
        return desc
      }
      if type(marker) == function {
        let temp = marker(marker-level)
        if type(temp) == function {
          // form: n => value
          return temp(n)
        } else if type(temp) == array {
          return get-array-value(temp, n)
        } else {
          return temp
        }
      } else {
        return marker
      }
    }

    let styled-markers = {
      for i in range(it.children.len()) {
        (custom-text(i)((marker-display(i))),)
      }
    }

    let markers-size = styled-markers.map(marker => measure(marker))
    let markers-width = markers-size.map(marker => marker.width)
    let markers-height = markers-size.map(marker => marker.height)
    let marker-max-width = calc.max(..markers-width)

    /*feat: the style of indent label*/
    let curr-label-width = {
      if list-config-args.label-width != none {
        parse-label-width(
          list-config-args.label-width,
          marker-max-width,
          curr-enum-level,
          labels-width: markers-width,
          ..args-with-tags,
        )
      } else { parse-label-width(label-width, marker-max-width, rel-level, ..args-with-tags) }
    }

    /*
    need to update !!!!!!!!!!!!!!!!!!!
    */
    label-width-list.update(push(marker-max-width))
    label-width-el.update(push(marker-max-width))


    /* spacings */
    let (
      indent-f,
      body-indent-f,
      label-indent-f,
      hanging-indent-f,
      line-indent-f,
      enum-width-f,
      enum-above-spacing-f,
      enum-below-spacing-f,
      item-spacing-f,
      label-inset-f,
      first-line-inset-f,
    ) = parse-all-length(
      it,
      rel-level,
      level,
      marker-max-width, /*ver0.1.x*/
      absolute-level,
      indent: indent,
      body-indent: body-indent,
      label-indent: label-indent,
      is-full-width: is-full-width,
      item-spacing: item-spacing,
      enum-spacing: enum-spacing,
      enum-margin: enum-margin,
      hanging-indent: hanging-indent,
      line-indent: line-indent,
      tight-mode: tight-mode,
      tight-item-mode: tight-item-mode,
      label-inset: label-inset,
      first-line-inset: first-line-inset,
      ..args-with-tags,
    )

    let (
      indent-f-e,
      body-indent-f-e,
      label-indent-f-e,
      hanging-indent-f-e,
      line-indent-f-e,
      enum-width-f-e,
      enum-above-spacing-f-e,
      enum-below-spacing-f-e,
      item-spacing-f-e,
      label-inset-f-e,
      first-line-inset-f-e,
    ) = parse-all-length(
      it,
      curr-list-level,
      it-list-level,
      marker-max-width, /*ver0.1.x*/
      false,
      indent: list-config-args.indent,
      body-indent: list-config-args.body-indent,
      label-indent: list-config-args.label-indent,
      is-full-width: list-config-args.is-full-width,
      item-spacing: list-config-args.item-spacing,
      enum-spacing: list-config-args.enum-spacing,
      enum-margin: list-config-args.enum-margin,
      hanging-indent: list-config-args.hanging-indent,
      line-indent: list-config-args.line-indent,
      tight-mode: list-config-args.tight-mode,
      tight-item-mode: list-config-args.tight-item-mode,
      label-inset: list-config-args.label-inset,
      first-line-inset: list-config-args.first-line-inset,
      ..args-with-tags,
    )


    let (
      indent-f-item,
      body-indent-f-item,
      label-indent-f-item,
      hanging-indent-f-item,
      line-indent-f-item,
      enum-width-f-item,
      enum-above-spacing-f-item,
      enum-below-spacing-f-item,
      item-spacing-f-item,
      label-inset-f-item,
      first-line-inset-f-item,
    ) = {
      let item-args = n => {
        let args = item-config-args(n)
        parse-all-length(
          it,
          level-item(n),
          abs-list-level,
          marker-max-width, /*ver0.1.x might change in the future*/
          false,
          indent: args.indent,
          body-indent: args.body-indent,
          label-indent: args.label-indent,
          is-full-width: args.is-full-width,
          item-spacing: args.item-spacing,
          enum-spacing: args.enum-spacing,
          enum-margin: args.enum-margin,
          hanging-indent: args.hanging-indent,
          line-indent: args.line-indent,
          tight-mode: item-config-args(0).tight-mode, //
          tight-item-mode: item-config-args(0).tight-item-mode, //
          label-inset: args.label-inset,
          first-line-inset: args.first-line-inset,
          ..args-with-tags-item,
        )
      }
      let args-size = 11
      for i in range(args-size) {
        (n => item-args(n).at(i),)
      }
    }

    let (
      curr-indent,
      curr-body-indent,
      curr-label-indent,
      curr-hanging-indent,
      curr-line-indent,
      enum-width,
      enum-above-spacing,
      enum-below-spacing,
      curr-item-spacing,
      curr-label-inset,
      curr-first-line-inset,
    ) = (
      n => get-none-value(indent-f(n), get-none-value(indent-f-e(n), indent-f-item(n)(n))),
      n => get-none-value(body-indent-f(n), get-none-value(body-indent-f-e(n), body-indent-f-item(n)(n))),
      n => get-none-value(label-indent-f(n), get-none-value(label-indent-f-e(n), label-indent-f-item(n)(n))),
      n => get-none-value(hanging-indent-f(n), get-none-value(hanging-indent-f-e(n), hanging-indent-f-item(n)(n))),
      n => get-none-value(line-indent-f(n), get-none-value(line-indent-f-e(n), line-indent-f-item(n)(n))),
      n => get-none-value(enum-width-f(n), get-none-value(enum-width-f-e(n), enum-width-f-item(n)(n))),
      get-none-value(enum-above-spacing-f, get-none-value(enum-above-spacing-f-e, enum-above-spacing-f-item(0))),
      get-none-value(enum-below-spacing-f, get-none-value(enum-below-spacing-f-e, enum-below-spacing-f-item(0))),
      n => get-none-value(item-spacing-f(n), get-none-value(item-spacing-f-e(n), item-spacing-f-item(n)(n))),
      n => get-none-value(label-inset-f(n), get-none-value(label-inset-f-e(n), label-inset-f-item(n)(n))),
      n => get-none-value(first-line-inset-f(n), get-none-value(
        first-line-inset-f-e(n),
        first-line-inset-f-item(n)(n),
      )),
    )


    // label-align
    let curr-label-align = parse-general-args-with-level-n(
      label-align,
      rel-level,
      list-config-args.label-align,
      curr-list-level,
      right,
      n => item-config-args(n).label-align,
      level-item,
      ..args-with-tags,
    )
    // label-baseline
    let curr-label-baseline = parse-general-args-with-level-n(
      label-baseline,
      rel-level,
      list-config-args.label-baseline,
      curr-list-level,
      0pt,
      n => item-config-args(n).label-baseline,
      level-item,
      ..args-with-tags,
    )

    // Used to determine whether the `above` and `below` attributes of `item-spacing` are used in the first and last items
    let using-first-full-item = []
    let using-last-full-item = []

    let min-indent = float.inf * 1pt

    let dir = if text.dir == rtl { "right" } else { "left" }

    let item-body = for i in range(len) {
      let child = it.children.at(i)
      let curr-marker = styled-markers.at(i)
      let curr-width = markers-width.at(i)

      let item-item-label-width = item-config-args(i).label-width
      let (amount, style) = if item-item-label-width != none {
        parse-label-width(
          item-item-label-width,
          marker-max-width,
          level-item(i),
          labels-width: markers-width,
          ..args-with-tags-item,
        )(i)
      } else { curr-label-width(i) }

      let max-width = if amount == auto { curr-width } else { amount }

      /* list'marker (label) */
      let marker-width = if style == "native" {
        marker-max-width
      } else if amount != auto {
        if style == "default" {
          if curr-width <= amount.to-absolute() { amount } else { curr-width }
        } else if style == "constant" {
          amount
        } else if style == "auto" {
          curr-width
        }
      } else { max-width }

      let curr-text-style = (curr-body-style)(i)

      let curr-text-size = {
        if curr-text-style != none {
          let size = curr-text-style.at("size", default: none)
          if size != none {
            (size: size)
          }
        }
        (:)
      }


      let curr-checklist-label-baseline = auto
      // re-parse body to support checklist
      let child-body = if curr-checklist {
        let format = checklist-body.at(i)
        if format != false {
          curr-checklist-label-baseline = checklist-label-baseline
          assert(
            curr-checklist-label-baseline in ("center", "top", "bottom", auto),
            message: "The `baseline` of checklist should be: \"center\", \"top\", \"baseline\", or `auto`",
          )
          let func = child.body.func()
          if func == func-styled {
            if format != true {
              format(func(child.body.child.children.slice(3).sum(default: []), child.body.styles))
            } else {
              func(child.body.child.children.slice(3).sum(default: []), child.body.styles)
            }
          } else {
            if format != true {
              format(child.body.children.slice(3).sum(default: []))
            } else {
              child.body.children.slice(3).sum(default: [])
            }
          }
        } else { child.body }
      } else { child.body }

      let _enum-width = enum-width(i)
      let _item-spacing = curr-item-spacing(i)

      let _label-indent = curr-label-indent(i).to-absolute()
      let _label-inset = curr-label-inset(i).to-absolute()
      let _first-line-inset = curr-first-line-inset(i).to-absolute()
      let _body-indent = curr-body-indent(i).to-absolute()
      let _indent = curr-indent(i).to-absolute()
      if _indent < min-indent { min-indent = _indent }

      let real-box-width = marker-width.to-absolute()
      let real-box-height = markers-height.at(i).to-absolute()

      // feat (ver0.3.0): label-border
      let label-border = curr-label-border(i)
      let (label-border-inset, label-border-align, label-width-style) = {
        if label-border != none {
          (
            label-border.at("inset", default: none),
            label-border.remove("align", default: none),
            label-border.remove("width-style", default: none),
          )
        } else {
          (none, none, none)
        }
      }

      let (_label-inset-top, _label-inset-bottom, _label-inset-left, _label-inset-right) = if (
        label-border-inset != none
      ) {
        for dir in ("top", "bottom") {
          let _inset = get-dir-inset(label-border-inset, dir: dir)
          let _inset-abs = get-absolute-length(_inset)
          let _inset-ratio = get-relative-ratio(_inset)
          let _inset = _inset-abs + _inset-ratio * real-box-height
          (_inset,)
        }
        for dir in ("left", "right") {
          let _inset = get-dir-inset(label-border-inset, dir: dir)
          let _inset-abs = get-absolute-length(_inset)
          let _inset-ratio = get-relative-ratio(_inset)
          let _inset = _inset-abs + _inset-ratio * real-box-width
          (_inset,)
        }
      } else { (0pt, 0pt, 0pt, 0pt) }

      // width-style
      let x-inset = _label-inset-left + _label-inset-right
      let (label-amount, label-stretched) = parse-label-width-style(
        label-width-style,
        curr-width,
        real-box-width,
        x-inset,
      )

      let box-width = real-box-width + if label-stretched { x-inset }
      let box-height = real-box-height + _label-inset-top


      let baseline-inset = get-baseline-inset-in-box(curr-marker).to-absolute()

      let label-height = box-height - baseline-inset

      /*label baseline*/
      let (
        curr-baseline,
        same-line-style,
        base-align, /*ver0.3.0: different meaning*/
        is-alone,
        // label-height,
        relative-to, /*ver0.3.0*/
        impact-first-line, /*ver0.3.0*/
      ) = parse-baseline(
        if curr-checklist-label-baseline != auto { curr-checklist-label-baseline } else { curr-label-baseline(i) },
        curr-marker,
        curr-text-style,
        label-height: label-height,
      )

      /* current label */
      let label-box-fix-baseline(
        fix-baseline: 0pt,
        alone-shift-baseline: 0pt,
        not-alone-shift-baseline: 0pt,
        alone: true,
        fix-height: 0pt,
      ) = label-box-with-baseline(
        curr-marker,
        width: box-width,
        fix-baseline: fix-baseline,
        label-inset: _label-indent + _label-inset,
        body-inset: _body-indent,
        label-align: curr-label-align(i),
        alone: alone,
        fix-height: fix-height + _label-inset-bottom, // TODO
        // real-label-height: real-label-height,
        alone-shift-baseline: alone-shift-baseline,
        not-alone-shift-baseline: not-alone-shift-baseline,
        baseline-inset: baseline-inset,
        ..label-border,
        given-width: label-amount,
        given-align: label-border-align,
      )

      // all the labels (ver0.3.0: feat)
      let hide-marker = get-all-labels(
        curr-marker,
        i,
        base-align,
        label-height,
        curr-baseline,
        baseline-inset,
        impact-first-line,
        same-line-style,
      )


      // pre-parse body (in order to determine how to display label)
      let new-body = detect-block-level-elem(
        child-body,
        number: hide-marker,
        label-height: label-height,
        curr-baseline: curr-baseline,
        body: curr-marker,
        alone: is-alone,
        real-label-height: box-height,
      )

      // flag: show in same-line (like: 1.a.I.)
      let is-holding = false
      let (inline, body) = new-body
      let item-content = if inline == InlineType.list {
        // enum or list
        is-holding = true
        if base-align == none {
          parent-number-box.update(
            push((
              body: curr-marker,
              label-height: label-height,
              curr-baseline: curr-baseline,
              alone: is-alone,
              real-label-height: box-height,
            )),
          )
        }
        [#body]
      } else {
        // show terms.item: it => {
        //   par-state.update(0)
        //   it
        //   [|a|]
        //   par-state.update(1)
        // }
        // block-level or inline-level
        parent-number-box.update(())
        if inline == InlineType.blank {
          [#body#hide-marker#baseline-tag-meta(height: label-height, baseline: curr-baseline, weak: false)]
        } else {
          [#parbreak()#body]
        }
      }

      let curr-block-args = get-current-block-args(block)
      let item-baseline-align = if base-align == none { start } else { base-align }
      let alone = if is-holding { is-alone } else { true }

      let label-cell = grid.cell(x: 0, align: item-baseline-align)[
        #if base-align == none {
          context {
            let (dy, final-label-height, final-baseline) = get-body-baseline()
            if dy == none {
              label-box-fix-baseline(alone: false)
            } else {
              let curr-dy = here().position().y
              let fix-baseline = dy - curr-dy
              let p-baseline = get-baseline-with-style(
                same-line-style,
                label-height,
                final-label-height,
                final-baseline,
              )
              let max-height = box-height
              for p in parent-number-box.get() {
                // Since it occurs not many times, it doesn't matter to repeat the comparison multiple times
                if max-height < p.real-label-height {
                  max-height = p.real-label-height
                }
              }
              label-box-fix-baseline(
                alone-shift-baseline: curr-baseline,
                not-alone-shift-baseline: p-baseline,
                fix-baseline: fix-baseline,
                alone: alone,
                fix-height: max-height,
              )
            }
          }
        } else {
          label-box-fix-baseline(alone: true, fix-height: box-height)
        }
      ]


      let inner-box(body) = (curr-body-format.inner)(i)(show-text((curr-body-style)(i), body))

      /* hanging-indent, first-line-indent */
      let _temp-line-indent = curr-line-indent(i)
      let _line-indent = if _temp-line-indent == auto { auto } else { _temp-line-indent.to-absolute() }
      let _temp-hanging-indent = curr-hanging-indent(i)
      let _hanging-indent = if _temp-hanging-indent == auto { auto } else { _temp-hanging-indent.to-absolute() }

      let body-cell = grid.cell(x: 1)[
        // override (next)
        // #show grid: set block(..default-block-args) // need
        #inner-box({
          let (par-line-indent, par-hanging-indent) = {
            if hanging-type == "classic" {
              (0pt, 0pt)
            } else if hanging-type == "paragraph" {
              (-max-width - _body-indent, -max-width - _body-indent)
            }
          }
          par-state.update(0)
          let _first-line-indent = -max-width + real-box-width + _first-line-inset
          show terms.item: it => {
            par-state.update(0)
            it
            [|a|]
            par-state.update(1)
          }
          /// Note that: `hanging-indent` and `first-line-indent` of the `par` in the lists are no longer in effect if `_line-indent` and `_hanging-indent` are not `auto`.
          show par: par-box.with(
            line-indent: _line-indent,
            hanging-indent: _hanging-indent,
            line-inset: par-line-indent,
            hanging-inset: par-hanging-indent,
            first-line-indent: _first-line-indent,
          )
          // Sepecial case: terms
          show: fix-terms
          // #set block(..default-block-args)
          set block(..curr-block-args) // need
          item-content
        })
      ]

      // feat: item-spacing with above and below
      let is-full-item-spacing = false
      let above-item-spacing
      let below-item-spacing
      if type(_item-spacing) == dictionary {
        above-item-spacing = _item-spacing.remove("above", default: 0pt)
        above-item-spacing = get-auto-value(above-item-spacing, 0pt)
        below-item-spacing = _item-spacing.remove("below", default: 0pt)
        below-item-spacing = get-auto-value(below-item-spacing, 0pt)
        assert(
          type(above-item-spacing) in length-type-with-fraction
            and type(below-item-spacing) in length-type-with-fraction
            and _item-spacing == (:),
          message: "The key value of item-spacing must be \"above\" and \"below\", with value being a length or `auto`",
        )
        is-full-item-spacing = true
      }

      /* item-spacing */
      let (above-spacing, below-spacing) = if is-full-item-spacing == false {
        if i == 0 {
          if i == len - 1 {
            // last and first
            (enum-above-spacing, enum-below-spacing)
          } else {
            // first but not last
            (enum-above-spacing, _item-spacing)
          }
        } else if i == len - 1 {
          // last but not first
          (_item-spacing, enum-below-spacing)
        } else {
          // not first and not last
          (_item-spacing, _item-spacing)
        }
      } else {
        if i == 0 {
          using-first-full-item = hide-line(above: enum-above-spacing)
        }
        if i == len - 1 {
          using-last-full-item = hide-line(below: enum-below-spacing)
        }
        (above-item-spacing, below-item-spacing)
      }


      // label-cell-width too large, and body-cell-width is negative? Now we can't handle it
      let label-cell-width = box-width + _label-inset + _body-indent + _indent
      let body-cell-width = if _enum-width == 100% { 1fr } else {
        if _enum-width == auto { auto } else {
          _enum-width - label-cell-width
        }
      }


      let inner-border = (curr-body-border.inner)(i)
      let inner-outset = inner-border.remove("outset", default: (:))
      let inner-dir-outset = get-dir-inset(inner-outset, dir: dir)
      inner-outset = parse-inset-without-dir(inner-outset, dir: dir)
      inner-outset.insert(dir, -label-cell-width + inner-dir-outset)

      let inner-inset = inner-border.remove("inset", default: (:))
      let inner-dir-inset = get-dir-inset(inner-inset, dir: dir)
      inner-inset = parse-inset-without-dir(inner-inset, dir: dir)

      let inset = if text.dir == rtl {
        (right: _indent, left: -_label-indent, rest: 0pt)
      } else {
        (left: _indent, right: -_label-indent, rest: 0pt)
      }

      let sec-inset = if text.dir == rtl {
        (right: max-width - real-box-width + inner-dir-inset, rest: 0pt) + inner-inset
      } else {
        (left: max-width - real-box-width + inner-dir-inset, rest: 0pt) + inner-inset
      }


      let outer-border = (curr-body-border.outer)(i)
      let outer-outset = outer-border.remove("outset", default: (:))
      let outer-dir-outset = get-dir-inset(outer-outset, dir: dir)
      outer-outset = parse-inset-without-dir(outer-outset, dir: dir)
      outer-outset.insert(dir, -_indent + outer-dir-outset)

      let (out-spacing, inner-spacing) = {
        if outer-border == (:) {
          ((:), (above: above-spacing, below: below-spacing))
        } else {
          ((above: above-spacing, below: below-spacing), (:))
        }
      }
      let outer-block(body) = make-format-box.with(
        format-args: outer-border,
        outset: outer-outset,
        ..out-spacing,
      )(body)

      // display: label + body
      let outer-body = (curr-body-format.outer)(i)()[
        #show grid.where(label: grid-ID): set block(
          // inner
          ..default-block-args,
          ..inner-spacing,
          ..inner-border,
          outset: inner-outset,
        )
        // override
        // need
        #show grid.cell: set block(..default-block-args)
        #grid(
          ..default-grid-args,
          columns: (label-cell-width, body-cell-width),
          inset: (inset, sec-inset),
          label-cell, body-cell,
        )#grid-ID
      ]
      if is-full-item-spacing { [#hide-line()] }
      outer-block(outer-body)
      if is-full-item-spacing { [#hide-line()] }
      curr-parent-level.update(pop)
      if auto-base-level {
        curr-base-parent-level.update(pop)
      }
    }

    let whole-border = (curr-body-border.whole)(0)
    let whole-outset = whole-border.remove("outset", default: (:))
    let dir-outset = get-dir-inset(whole-outset, dir: dir)
    whole-outset = parse-inset-without-dir(whole-outset, dir: dir)
    whole-outset.insert(dir, -min-indent + dir-outset)
    let is-whole-block = whole-border != (:)
    let whole-block = make-format-box.with(
      format-args: whole-border,
      outset: whole-outset,
      above: enum-above-spacing,
      below: enum-below-spacing,
    )
    // display-whole
    if not is-whole-block { using-first-full-item }
    whole-block((curr-body-format.whole)(0)(next-show(item-body)))
    if not is-whole-block { using-last-full-item }
  }

  label-width-list.update(pop)
  label-width-el.update(pop)
  list-level.update(it => it - 1)
  item-level.update(pop)
}
