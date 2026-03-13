#import "basic-tool.typ": *
#import "../util/level-state.typ": *
#import "../util/func-type.typ": *

/// Pre-parse tag arguments for element processing
///
/// Processes tag arguments before element parsing, converting tag functions to values.
///
/// - n (int): Current index or level
/// - args (arguments): Additional arguments
/// -> dictionary
#let pre-parse-tag(n, ..args) = {
  let name-args = args.named()
  let tag = name-args.remove("tag", default: none)
  if tag != none { name-args.insert("tag", tag(n)) }
  return name-args
}

/// Parse a general function with a specified level of nesting
///
/// Handles function arguments with support for multiple input formats including
/// function-based, array-based, and direct value formats.
///
/// - func (function, array, any): Function or value to parse
/// - initial (any): Initial value for function processing
/// - default (any): Default value to return if processing fails
/// - args (arguments): Additional arguments for function processing
/// - level (int): Current nesting level
/// - n (int): Current index
/// -> any
#let parse-general-func-with-level-n(func, initial, default, ..args) = level => n => {
  if type(func) == function {
    let level-n-args = (level: level + 1, n: n + 1, ..pre-parse-tag(n, ..args))
    // form: it => value; it => array
    return get-value-by-n(func(level-n-args), initial, default)(n)
  } else {
    // func: array; value
    return get-value-by-n(get-depth-value(func, level), initial, default)(n)
  }
}

/// Parses text arguments with nesting level support
///
/// Processes text formatting arguments with support for nested level-based selection.
///
/// - args (arguments): Text named arguments to parse
/// - level (int): Current nesting level for value selection
/// - n-last (int): Last index value
/// - tag (none): Tag identifier
/// - enum-tag (none): Enum tag identifier
/// -> function
#let parse-text-args(..args, level, n-last: 0, tag: none, enum-tag: none) = {
  let dic = for (k, v) in args.named() {
    if k in default-text-args.keys() {
      let value = parse-general-func-with-level-n(v, auto, auto, n-last: n-last, tag: tag, enum-tag: enum-tag)(level)
      if value != auto {
        (str(k): value)
      }
    }
  }
  let dic-f = n => {
    if dic != none {
      for (k, v) in dic {
        if v(n) != auto {
          // (str(k): v(n))
          let value = if type(v(n)) == length { v(n).to-absolute() } else { v(n) }
          (str(k): value)
        }
      }
    } else {
      (:)
    }
  }
  return dic-f
}



/// Parse a format function for styling
///
/// Processes format configurations for styling elements, supporting both
/// function-based and value-based format specifications with tag preprocessing.
///
/// - format (function, array, any): Format configuration to parse
/// - args (arguments): Additional arguments for format processing
/// - level (int): Current nesting level
/// - n (int): Current index
/// - body (content): Content to format
/// -> content
#let parse-format-func(format, ..args) = level => n => body => {
  if type(format) == function {
    // form: it => any
    return [#format(
      (level: level + 1, n: n + 1, body: body, ..pre-parse-tag(n, ..args)),
    )]
  } else {
    let item = get-depth-value(format, level)
    if type(item) == function {
      return [#item(body)]
    } else {
      let item-n = get-value-by-n(item, none, none)(n)
      if type(item-n) == function {
        return [#item-n(body)]
      } else {
        if item-n in (none, auto, (), (:)) {
          return body
        }
        return [#item-n]
      }
    }
  }
}


/// Parse arguments with specified nesting level
///
/// Handles argument parsing based on nesting level, supporting both function and value types.
///
/// - args (any): Arguments to parse (function or value)
/// - level (int): Current nesting level
/// - other-args (arguments): Additional arguments
/// -> any
#let parse-args-with-level(args, level, ..other-args) = {
  if type(args) == function {
    return args((level: level + 1, ..other-args.named()))
  } else {
    return get-depth-value(args, level)
  }
}

/// Parse general arguments with a specified level of nesting
///
/// Processes arguments with support for both relative and absolute nesting levels.
/// Prioritizes enum arguments over current arguments.
///
/// - curr-args (any): Current arguments to parse
/// - rel-level (int): Relative nesting level
/// - enum-args (any): Enum-specific arguments
/// - abs-level (int): Absolute nesting level
/// - args (arguments): Additional arguments
/// -> any
#let parse-general-args-with-level(curr-args, rel-level, enum-args, abs-level, ..args) = {
  let _enum-args = parse-args-with-level(enum-args, abs-level, ..args)
  if _enum-args != none {
    _enum-args
  } else {
    parse-args-with-level(curr-args, rel-level, ..args)
  }
}


/// Parse supplement content
///
/// Adds supplemental content before or after the main body content.
/// Supports dictionary-based, function-based, and direct supplement formats.
///
/// - body (content): Main content body
/// - supplement (any): Supplemental content to add
/// - args (arguments): Additional arguments
/// -> content
#let supp(body, supplement, ..args) = {
  if supplement not in (auto, [], none) {
    if type(supplement) == dictionary {
      let prefix = supplement.at("prefix", default: [])
      let suffix = supplement.at("suffix", default: [])
      [#prefix#h(0em, weak: true)~#body#h(0em, weak: true)~#suffix]
    } else if type(supplement) == function {
      let level-n-args = (body: body, ..args.named())
      [#supplement(level-n-args)]
    } else {
      [#supplement#h(0em, weak: true)~#body]
    }
  } else {
    [#body]
  }
}

/// Pre-parse item supplement arguments
///
/// Processes supplement configurations before item parsing, supporting
/// function-based and value-based supplement specifications with tag preprocessing.
///
/// - supplement (any): Supplement configuration to pre-parse
/// - level (int): Current nesting level
/// - args (arguments): Additional arguments
/// - n (int): Current index
/// - body (content): Content to supplement
/// -> content
#let pre-parse-supplement(supplement, level, ..args) = n => body => {
  if supplement in (none, auto) {
    return supplement
  }
  if type(supplement) == function {
    supp(body, supplement, level: level + 1, n: n + 1, ..pre-parse-tag(n, ..args))
  } else {
    let _supplement = get-depth-value(supplement, level)
    if _supplement in (none, auto) {
      return _supplement
    }
    if type(_supplement) == function {
      supp(body, _supplement, n: n + 1, ..pre-parse-tag(n, ..args))
    } else {
      _supplement = get-value-by-n(_supplement, none, none)(n)
      if _supplement in (none, auto) {
        return _supplement
      }
      supp(body, _supplement)
    }
  }
}

/// Parse item supplement arguments
///
/// Processes supplement configurations for item elements, supporting both
/// current and enum-specific supplement specifications with priority handling.
///
/// - curr-supplement (any): Current supplement configuration
/// - rel-level (int): Relative nesting level
/// - enum-supplement (any): Enum-specific supplement configuration
/// - abs-level (int): Absolute nesting level
/// - args (arguments): Additional arguments
/// - n (int): Current index
/// - body (content): Content to supplement
/// -> content
#let parse-supplement(curr-supplement, rel-level, enum-supplement, abs-level, ..args) = n => body => {
  let supplement = pre-parse-supplement(enum-supplement, abs-level, ..args)(n)(body)
  if supplement in (auto, none) {
    supplement = pre-parse-supplement(curr-supplement, rel-level, ..args)(n)(body)
    if supplement not in (auto, none) {
      return supplement
    }
  }
  return body
}



/// Parse general arguments with a specified level of nesting and an index
///
/// Processes arguments with support for both relative and absolute nesting levels,
/// handling item-specific arguments and priority-based value selection.
///
/// - curr-args (any): Current arguments to parse
/// - rel-level (int): Relative nesting level
/// - enum-args (any): Enum-specific arguments
/// - abs-level (int): Absolute nesting level
/// - default (any): Default value to use if no valid argument is found
/// - args (arguments): Additional arguments
/// -> function
#let parse-general-args-with-level-n(curr-args, rel-level, enum-args, abs-level, default, ..args) = {
  let _curr-args = parse-general-func-with-level-n(curr-args, auto, default, ..args)(rel-level)
  let _enum-args = parse-general-func-with-level-n(enum-args, auto, default, ..args)(abs-level)
  let item-pos = args.pos()
  let _item-args = if item-pos.len() > 0 {
    let item-args = item-pos.at(0)
    let item-level = item-pos.at(1)
    n => parse-general-func-with-level-n(item-args(n), auto, default, ..args)(item-level(n))
  } else {
    n => n => none
  }
  return n => get-none-value(_curr-args(n), get-none-value(_enum-args(n), _item-args(n)(n)))
}



/// Parse the width of a label
///
/// Processes label width configurations with support for various width formats
/// including auto, length values, and function-based width calculations.
///
/// - label-width (any): Label width configuration
/// - max-width (length): Maximum available width
/// - level (int): Current nesting level
/// - labels-width (array): Array of label widths for function-based calculations
/// - args (arguments): Additional arguments
/// -> function
#let parse-label-width(label-width, max-width, level, labels-width: (), ..args) = {
  let width-f = parse-general-func-with-level-n(label-width, auto, auto, ..args)(level)
  return n => {
    let width = width-f(n)
    if width == auto {
      return (amount: max-width, style: "native")
    }
    let _type = type(width)
    if _type == dictionary {
      let (amount, style) = width
      assert(
        amount == auto or type(amount) in length-type or amount == "max" or type(amount) == function,
        message: "`amount` should be a length, `auto` or a string \"max\".",
      )
      assert(
        style in ("default", "constant", "auto", "native"),
        message: "Unknown style. The label-width's style should be one of the following strings: \"default\", \"constant\", \"auto\" and \"native\".",
      )
      if amount == "max" {
        return (amount: max-width, style: style)
      }
      if type(amount) == function {
        return (amount: amount(labels-width), style: style)
      }
      return width
    } else if _type in length-type {
      return (amount: width, style: "default")
    } else {
      panic("`label-width` should be a length or `auto`.")
    }
  }
}


/// Parse the format of an item
///
/// Processes item formatting configurations with support for outer, inner, and whole
/// format specifications through dictionary-based or direct format values.
///
/// - item-format (dictionary, function, array): Item format configuration
/// - level (int): Current nesting level
/// - args (arguments): Additional arguments
/// -> dictionary
#let parse-item-format(item-format, level, ..args) = {
  let outer
  let inner
  let whole
  if type(item-format) == dictionary {
    outer = item-format.at("outer", default: none)
    inner = item-format.at("inner", default: none)
    whole = item-format.at("whole", default: none)
  } else {
    outer = item-format
  }
  let outer-format = parse-format-func(outer, ..args)(level)
  let inner-format = parse-format-func(inner, ..args)(level)
  let whole-format = parse-format-func(whole, ..args)(level)
  return (outer: outer-format, inner: inner-format, whole: whole-format)
}


/// Define body border arguments for styling
///
/// Version 0.2.0 arguments: "stroke", "radius", "outset", "fill", "inset", "clip"
/// Version 0.3.0 additions: "sticky", "breakable"
///
/// -> array
#let body-border-args = ("stroke", "radius", "outset", "fill", "inset", "clip", "sticky", "breakable")

/// Define label border arguments for styling (ver0.3.0)
///
/// - stroke: Border stroke style
/// - radius: Border corner radius
/// - outset: Border outset distance
/// - fill: Border fill color
/// - inset: Border inset distance
/// - clip: Whether to clip content
/// - width-style: Label width styling
/// - align: Label alignment
///
///
/// -> array
#let label-border-args = ("stroke", "radius", "outset", "fill", "inset", "clip", "width-style", "align")


/// Parse border and formatting arguments for an element
///
/// Processes format configurations with border arguments support, extracting
/// and processing specific border arguments from a format dictionary.
///
/// - format (dictionary, none): Format configuration containing border arguments
/// - level (int): Current nesting level
/// - args (arguments): Additional arguments
/// - border-args (array): Array of border argument names to process
/// -> function
#let parse-format-with(format, level, ..args, border-args: body-border-args) = {
  let border = (:)
  if type(format) == dictionary {
    for k in border-args {
      let v = format.at(k, default: (:))
      if v != (:) {
        let value = parse-general-func-with-level-n(v, auto, (:), ..args)(level)
        border.insert(k, value)
      }
    }
  }
  return n => {
    for (k, v) in border {
      if v(n) not in ((:), none) {
        (str(k): v(n))
      }
    }
  }
}

/// Parse text formatting arguments for body content
///
/// Processes text style configurations for body elements, extracting
/// and processing text formatting arguments from a format dictionary.
///
/// - format (dictionary, none): Format configuration containing text arguments
/// - level (int): Current nesting level
/// - args (arguments): Additional arguments
/// -> function
#let parse-body-text-format-with(format, level, ..args) = {
  let style = (:)
  // text
  if format not in (none, (), (:)) {
    // let style-format = format.at("style", default: (:))
    for k in default-text-args.keys() {
      let v = format.at(k, default: auto)
      if v != auto {
        let value = parse-general-func-with-level-n(v, auto, none, ..args)(level)
        style.insert(k, value)
      }
    }
  }
  let style-f = n => {
    for (k, v) in style {
      if v(n) != none {
        // (str(k): v(n))
        let value = if type(v(n)) == length { v(n).to-absolute() } else { v(n) }
        (str(k): value)
      }
    }
  }
  return style-f
}

/// Parse the complete format configuration for a body element
///
/// Processes body formatting configurations including border styles, text styles,
/// and format specifications for outer, inner, and whole body elements.
///
/// - body-format (dictionary, function, array): Body format configuration
/// - level (int): Current nesting level
/// - args (arguments): Additional arguments
/// -> dictionary
#let parse-body-format(body-format, level, ..args) = {
  let border = (outer: _ => (:), inner: _ => (:), whole: _ => (:))
  let format = (outer: none, inner: none, whole: none)
  let style = _ => (:)
  // assert(body-format != none and type(body-format) == dictionary)

  if type(body-format) == dictionary {
    let outer = body-format.at("outer", default: none)
    let inner = body-format.at("inner", default: none)
    let whole = body-format.at("whole", default: none)

    let text-style = body-format.at("style", default: none)

    if outer == none and inner == none and whole == none {
      outer = body-format
    }

    if type(outer) in (function, array) {
      format.outer = outer
    } else {
      format.outer = if type(outer) == dictionary { outer.remove("format", default: none) }
    }
    if type(inner) in (function, array) {
      format.inner = inner
    } else {
      format.inner = if type(inner) == dictionary { inner.remove("format", default: none) }
    }
    if type(whole) in (function, array) {
      format.whole = whole
    } else {
      format.whole = if type(whole) == dictionary { whole.remove("format", default: none) }
    }

    border.outer = parse-format-with(outer, level, ..args)
    border.inner = parse-format-with(inner, level, ..args)
    border.whole = parse-format-with(whole, level, ..args)


    style = parse-body-text-format-with(text-style, level, ..args)
  } else {
    if type(body-format) in (function, array) {
      format.outer = body-format
    }
  }
  format.outer = parse-format-func(format.outer, ..args)(level)
  format.inner = parse-format-func(format.inner, ..args)(level)
  format.whole = parse-format-func(format.whole, ..args)(level)
  return (border, style, format)
}

/// Parse the format of a label
///
/// Processes label formatting configurations with support for both
/// dictionary-based and direct format specifications.
///
/// - label-format (dictionary, function, array): Label format configuration
/// - level (int): Current nesting level
/// - args (arguments): Additional arguments
/// -> dictionary
#let parse-label-format(label-format, level, ..args) = {
  let border = (:)
  let format = none
  if type(label-format) == dictionary {
    let label-format = label-format
    format = label-format.remove("format", default: none)
    border = label-format
  } else {
    format = label-format
  }
  format = parse-format-func(format, ..args)(level)
  border = parse-format-with(border, level, ..args, border-args: label-border-args)

  return (border, format)
}

/// Parse label width style configuration
///
/// Processes width-style configurations for label elements, supporting both
/// dictionary-based and string-based width specifications.
///
/// - width-style (dictionary, string, none): Width style configuration
/// - real-width (length): Actual width of the label content
/// - box-width (length): Box width of the label container
/// - x-inset (length): Horizontal inset value
///
/// Returns a dictionary with:
/// - label-amount (length): Calculated label width including inset
/// - label-stretched (bool): Whether the label should be stretched
///
/// Supported width-style formats:
/// - Dictionary: {amount: "real-width"|"label-width"|length, stretched: bool}
/// - String: "real-width", "label-width", or a length value
/// - none: Uses default behavior
///
/// -> dictionary
#let parse-label-width-style(width-style, real-width, box-width, x-inset) = {
  if width-style != none {
    let stretched = false
    let amount
    if type(width-style) == dictionary {
      let width-style = width-style
      amount = width-style.remove("amount", default: "real-width")
      stretched = width-style.remove("stretched", default: false)
      assert(width-style == (:), message: "The key value of `width-style` should be: amount and stretched")
    } else {
      amount = width-style
    }

    if amount == "real-width" {
      amount = real-width
    } else if amount == "label-width" {
      amount = box-width
    } else if type(amount) in length-type {
      // nothing to do
    } else {
      panic(
        "The value of `width-style` should be the following string: real-width, label-width, or a length, or a dictionary with keys: amount and stretched." 
      )
    }
    assert(type(stretched) == bool, message: "The value of `stretched` should be a bool.")
    return (label-amount: amount + x-inset, label-stretched: stretched)
  } else {
    (label-amount: real-width + x-inset, label-stretched: false)
  }
}


/// Get the baseline value with specified style.
///
/// -> any
#let get-baseline-with-style(same-line-style, prev-label-height, curr-label-height, curr-baseline) = {
  if same-line-style == "center" {
    curr-baseline + (prev-label-height - curr-label-height) * 0.5
  } else if same-line-style == "top" {
    curr-baseline + (prev-label-height - curr-label-height)
  } else if same-line-style == "bottom" {
    curr-baseline
  }
}

/// Parse the baseline value. (ver0.3.0: add `impact-first-line` and `relative-to`, allow to align in whole item)
///
/// -> any
#let parse-baseline(baseline, number, text-style, label-height: 0pt) = {
  let text-height = 0pt
  let base-align = none
  let alone = false
  let amount
  let same-line-style = "bottom"
  let relative-to = "baseline"
  let text-height = 0pt
  let text-baseline = text-style.at("baseline", default: 0pt).to-absolute()
  let relative-baseline = 0pt
  let impact-first-line = false
  if type(baseline) == dictionary {
    // legel keys: `amount`, `same-line-style`, `alone`, relative-to, impact-first-line
    let allowed-keys = ("amount", "same-line-style", "alone", "relative-to", "impact-first-line")
    let keys = baseline.keys()

    if not contains-all(allowed-keys, keys) {
      panic("The legal keys are: `amount`, `same-line-style`, `alone`, `relative-to`, and `impact-first-line`.")
    }

    amount = baseline.at("amount", default: 0pt)
    same-line-style = baseline.at("same-line-style", default: auto)
    alone = baseline.at("alone", default: false)
    relative-to = baseline.at("relative-to", default: "baseline")
    impact-first-line = baseline.at("impact-first-line", default: false)

    assert(
      type(amount) in length-type
        or amount in ("center", "top", "bottom", "top-item", "horizon-item", "bottom-item")
        or amount == auto,
      message: "The value of amount should be: `length`, `relative`, `ratio`, `auto`; or one of the following strings: \"center\", \"top\", \"bottom\", \"top-item\", \"horizon-item\", \"bottom-item\".",
    )
    amount = get-auto-value(amount, 0pt)
    assert(
      same-line-style in ("center", "top", "bottom", auto),
      message: "The value of the key `same-line-style` should be one of the following strings: \"center\", \"top\", \"bottom\"; or \`auto\`.",
    )
    assert(
      type(alone) == bool,
      message: "The value of the key `alone` should be a bool.",
    )

    let _type = type(relative-to)

    if relative-to in ("bottom", "center", "top", "baseline") {
      text-height = measure(show-text(text-style, [A])).height.to-absolute()
      same-line-style = get-auto-value(same-line-style, "bottom")
    } else if _type == content {
      text-height = measure(show-text(text-style, relative-to)).height.to-absolute()
      relative-to = "baseline"
      same-line-style = get-auto-value(same-line-style, "bottom")
    } else if _type == length {
      text-height = relative-to
      relative-to = "baseline"
      same-line-style = get-auto-value(same-line-style, "bottom")
    } else if (
      _type == array
        and relative-to.len() == 2
        and type(relative-to.at(0)) in (content, length)
        and relative-to.at(1) in ("bottom", "center", "top", "baseline")
    ) {
      if type(relative-to.at(0)) == content {
        text-height = measure(show-text(text-style, relative-to.at(0))).height.to-absolute()
      } else {
        text-height = relative-to.at(0)
      }
      relative-to = relative-to.at(1)
      same-line-style = get-auto-value(same-line-style, "bottom")
    } else if relative-to in ("top-item", "horizon-item", "bottom-item") {
      text-height = measure(show-text(text-style, [A])).height.to-absolute()
      if relative-to == "top-item" {
        same-line-style = get-auto-value(same-line-style, "top")
        base-align = top + start
      } else if relative-to == "horizon-item" {
        same-line-style = get-auto-value(same-line-style, "center")
        base-align = horizon + start
      } else if relative-to == "bottom-item" {
        same-line-style = get-auto-value(same-line-style, "bottom")
        base-align = bottom + start
      }
    } else {
      panic(
        "The value of the key `relative-to` should be one of the following strings: baseline, top, center, bottom; top-item, horizon-item, bottom-item; a content; or an array of two elements: a content and one of the following strings: baseline, top, center, bottom",
      )
    }
    if relative-to == "baseline" {
      relative-baseline = text-baseline
    } else if relative-to == "center" {
      relative-baseline = (label-height - text-height) * .5
    } else if relative-to == "top" {
      relative-baseline = label-height - text-height
    } else if relative-to == "bottom" {
      relative-baseline = 0pt
    }
    assert(
      type(impact-first-line) == bool,
      message: "The value of the key `impact-first-line` should be a bool.",
    )
  } else {
    amount = baseline
    text-height = measure(show-text(text-style, [A])).height.to-absolute()
    relative-baseline = text-baseline
  }

  // panic(amount)
  if amount == auto {
    amount = 0pt
  } else if amount == "center" {
    relative-to = "baseline"
    amount = (label-height - text-height) * .5 + relative-baseline
    base-align = none
  } else if amount == "top" {
    relative-to = "baseline"
    amount = label-height - text-height + relative-baseline
    base-align = none
  } else if amount == "bottom" {
    relative-to = "baseline"
    amount = relative-baseline
    base-align = none
  } else if amount == "top-item" {
    amount = 0pt
    base-align = start + top
    same-line-style = get-auto-value(same-line-style, "top")
  } else if amount == "horizon-item" {
    amount = 0pt
    base-align = start + horizon
    same-line-style = get-auto-value(same-line-style, "center")
  } else if amount == "bottom-item" {
    amount = 0pt
    base-align = start + bottom
    same-line-style = get-auto-value(same-line-style, "bottom")
  } else {
    assert(
      type(amount) in (length, relative, ratio),
      message: "The value of `label-baseline` should be: `length`, `relative`, `ratio`, `auto`; or one of the following strings: \"center\", \"top\", \"bottom\", \"top-item\", \"horizon-item\", \"bottom-item\".",
    )
    let amount-radio = get-relative-ratio(amount)
    let amount-length = get-relative-length(amount)
    amount = amount-length + amount-radio * label-height
    if relative-to in ("bottom", "center", "top", "baseline") {
      amount = amount + relative-baseline
    }
  }
  // panic(amount)

  return (amount, same-line-style, base-align, alone, relative-to, impact-first-line)
}

/// Define default formatting arguments for an element
///
/// Contains all supported formatting arguments for list and enum elements.
///
/// Arguments include:
/// - indent: Element indentation
/// - body-indent: Body content indentation
/// - label-indent: Label indentation
/// - is-full-width: Full width setting
/// - item-spacing: Spacing between items
/// - enum-spacing: Enum-specific spacing
/// - enum-margin: Enum margin settings
/// - hanging-indent: Hanging indent
/// - line-indent: Line indentation
/// - label-width: Label width
/// - body-format: Body formatting
/// - label-format: Label formatting
/// - label-align: Label alignment
/// - label-baseline: Label baseline
/// - label-inset: Label inset
/// - first-line-inset: First line inset
/// - tight-mode: Tight spacing mode
/// - tight-item-mode: Tight item spacing mode
/// - step: Step increment (enum only)
/// - ref-numbering: Reference numbering (enum only)
/// - supplement: Supplemental content
///
/// -> array
#let default-elem-format-args = (
  "indent",
  "body-indent",
  "label-indent",
  "is-full-width",
  "item-spacing",
  "enum-spacing",
  "enum-margin",
  "hanging-indent",
  "line-indent",
  "label-width",
  "body-format",
  "label-format",
  // "item-format", for future
  "label-align",
  "label-baseline",
  "label-inset",
  "first-line-inset",
  "tight-mode",
  "tight-item-mode",
  "step", /*only works for enum*/
  "ref-numbering", /*only works for enum*/
  "supplement",
)

/// Parse arguments for list or enum.
///
/// -> any
#let parse-elem-args(elem-args: (:)) = {
  if type(elem-args) == dictionary {
    for k in default-elem-format-args {
      let value = elem-args.at(k, default: none)
      (str(k): value)
    }
    // text args
    let dic = for k in default-text-args.keys() {
      let v = elem-args.at(k, default: none)
      if v != none {
        (str(k): v)
      }
    }
    (text-args: arguments(..dic))
  } else {
    for k in default-elem-format-args {
      (str(k): none)
    }
    (text-args: none)
  }
}

/// Define default arguments for an item
///
/// Contains all supported item arguments with their default values.
/// Used as a template for item argument parsing and validation.
///
/// Arguments include:
/// - indent: Item indentation
/// - body-indent: Body content indentation
/// - label-indent: Label indentation
/// - is-full-width: Full width setting
/// - item-spacing: Spacing between items
/// - enum-spacing: Enum-specific spacing
/// - enum-margin: Enum margin settings
/// - hanging-indent: Hanging indent
/// - line-indent: Line indentation
/// - label-width: Label width
/// - body-format: Body formatting
/// - label-format: Label formatting
/// - label-align: Label alignment
/// - label-baseline: Label baseline
/// - label-inset: Label inset
/// - first-line-inset: First line inset
/// - tight-mode: Tight spacing mode
/// - tight-item-mode: Tight item spacing mode
/// - supplement: Supplemental content
/// - skipped: Whether enum's number should be skipped
/// - body: Label content
/// - absolute: Whether to use absolute nesting levels
/// - tag: Item identifier
/// - enum-tag: Enum or list identifier
///
/// -> dictionary
#let default-item-args = (
  "indent": none,
  "body-indent": none,
  "label-indent": none,
  "is-full-width": none,
  "item-spacing": none,
  "enum-spacing": none, // for all, only index = 1 will be used
  "enum-margin": none,
  "hanging-indent": none,
  "line-indent": none,
  "label-width": none,
  "body-format": none, // for all
  "label-format": none,
  // "item-format",
  "label-align": none,
  "label-baseline": none,
  "label-inset": none,
  "first-line-inset": none,
  "tight-mode": none, // for all
  "tight-item-mode": none, //for all
  // "ref-numbering": none, /*only works for enum*/
  "supplement": none, // different meaning, need labelled to `item`
  "skipped": false, // should be skipped for current's label (number for enum, marker for list), default: false,
  "body": none, // label's content
  "absolute": false, // true for abs-level else for rel-level
  "tag": none, // The identifier of the item (list or enum).
  "enum-tag": none, // The identifier of the lists (list or enum).
)


/// Check if the element is an item label
///
/// Determines whether an element represents an item label by checking
/// its metadata and identifier properties.
///
/// - e (element): Element to check
/// -> bool
#let is-item-label(e) = {
  return e.func() == metadata and type(e.value) == dictionary and e.value.at("kind", default: none) == item-label-ID
}

/// Parse the arguments of an item label
///
/// Extracts and processes arguments from an item label element,
/// removing the internal "kind" identifier from the metadata.
///
/// - body (element): Item label element to parse
/// - args (arguments): Additional arguments
/// -> dictionary
#let parse-item(body, ..args) = {
  if is-item-label(body) {
    let item-args = body.value
    let _ = item-args.remove("kind")
    return item-args
  } else {
    return none
  }
}

/// Parse the arguments of an item
///
/// Processes item arguments with support for text formatting arguments
/// and merges them with default item argument values.
///
/// - elem-args (dictionary): Item arguments to parse
/// -> dictionary
#let parse-item-args(elem-args: (:)) = {
  if type(elem-args) == dictionary {
    for (k, v) in default-item-args {
      let value = elem-args.at(k, default: v)
      (str(k): value)
    }
    // text args
    let dic = for k in default-text-args.keys() {
      let v = elem-args.at(k, default: none)
      if v != none {
        (str(k): v)
      }
    }
    (text-args: arguments(..dic))
  }
  // default-item-args
}

/// Get the configuration arguments of an item
///
/// Extracts and processes item configuration arguments from item body content,
/// supporting both single-item and multi-item formats with proper argument parsing.
///
/// - item-body (array): Array of item body elements to process
/// -> function
#let get-item-config-args(item-body) = {
  return n => {
    let body = item-body.at(n).body
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
}

/// Parses a length value with support for nested level-based selection
///
/// Handles complex length values with support for function-based and array-based selection.
///
/// - complex-len (any): The length value or array of values to parse
/// - max-width (length): Maximum width of the current list label
/// - it (enum, list): Type of the current list
/// - absolute-level (bool): Whether to use absolute nesting levels
/// - default (any): Default value if `auto` is specified
/// - level (int): Current nesting level
/// - abs-level (int): Absolute nesting level
/// - args (arguments): Additional arguments
/// - n (int): Current index
///
/// -> any
#let parse-len(complex-len, max-width, it, absolute-level, default, level, abs-level, ..args) = n => {
  if complex-len == auto {
    return default
  } else {
    let increment = abs-level - level
    // complex-len: it => value; it => array
    let label-w = if absolute-level {
      label-width-el.get()
    } else {
      if it.func() == enum { label-width-enum.get() } else if it.func() == list { label-width-list.get() }
    }
    if type(complex-len) == function {
      let temp-len = complex-len(
        (
          level: level + 1,
          n: n + 1,
          // n-last: it.children.len(),
          label-width: (
            get: l => {
              label-w.at(l - 1 + increment, default: max-width)
            },
            current: max-width,
          ),
          e: (
            get: l => if absolute-level {
              get_type-enum-or-list(item-level.get().at(l - 1 + increment, default: it))
            } else { it },
            current: it,
          ),
          ..pre-parse-tag(n, ..args),
        ),
      )
      return get-value-by-n(temp-len, auto, default)(n)
    } else {
      // complex-len: array; value
      return get-value-by-n(get-depth-value(complex-len, level), auto, default)(n)
    }
  }
}

/// Get the auto tight spacing.
#let get-auto-tight-spacing(spacing, tight, detect-par) = {
  if spacing == auto {
    if tight { if detect-par { par.spacing } else { par.leading } } else { par.spacing }
  } else { spacing }
}



/// Parses and calculates all length values for enum/list elements
///
/// Comprehensive function that processes and calculates various length-related
/// parameters for enumeration and list elements, including indentation, spacing,
/// and formatting configurations with support for nested level-based selection.
///
/// - it (enum, list): Enumeration or list element to process
/// - curr-level (int): Current nesting level for relative calculations
/// - abs-level (int): Absolute nesting level for fixed calculations
/// - max-width (length): Maximum available width for the element
/// - absolute-level (bool): Whether to use absolute nesting levels
/// - indent (length, auto): Element indentation
/// - body-indent (length, auto): Body content indentation
/// - label-indent (length, auto): Label indentation
/// - is-full-width (bool): Whether to use full width
/// - item-spacing (length, auto): Spacing between items
/// - enum-spacing (length, auto): Enum-specific spacing
/// - enum-margin (length, auto): Enum margin settings
/// - hanging-indent (length, auto): Hanging indent for multiline content
/// - line-indent (length, auto): Line indentation for nested content
/// - tight-mode (string, dictionary, auto): Tight spacing mode configuration
/// - tight-item-mode (string, dictionary, auto): Tight item spacing mode
/// - label-inset (length, auto): Label inset from edges
/// - first-line-inset (length, auto): First line inset for special formatting
/// - args (arguments): Additional arguments for function processing
///
/// -> array
#let parse-all-length(
  it,
  curr-level,
  abs-level,
  max-width,
  absolute-level,
  indent: auto,
  body-indent: auto,
  label-indent: auto,
  is-full-width: true,
  item-spacing: auto,
  enum-spacing: auto,
  enum-margin: auto,
  hanging-indent: auto,
  line-indent: auto,
  tight-mode: auto,
  tight-item-mode: auto,
  label-inset: auto,
  first-line-inset: auto,
  ..args,
) = {
  let curr-indent = parse-len(indent, max-width, it, absolute-level, it.indent, curr-level, abs-level, ..args)

  let curr-body-indent = parse-len(
    body-indent,
    max-width,
    it,
    absolute-level,
    it.body-indent,
    curr-level,
    abs-level,
    ..args,
  )

  let curr-label-indent = parse-len(label-indent, max-width, it, absolute-level, 0pt, curr-level, abs-level, ..args)

  let curr-label-inset = parse-len(label-inset, max-width, it, absolute-level, 0pt, curr-level, abs-level, ..args)

  let curr-first-line-inset = parse-len(
    first-line-inset,
    max-width,
    it,
    absolute-level,
    0pt,
    curr-level,
    abs-level,
    ..args,
  )

  let curr-hanging-indent = parse-len(
    hanging-indent,
    max-width,
    it,
    absolute-level,
    auto,
    curr-level,
    abs-level,
    ..args,
  )

  let curr-line-indent = parse-len(
    line-indent,
    max-width,
    it,
    absolute-level,
    auto,
    curr-level,
    abs-level,
    ..args,
  )

  let enum-width = {
    if is-full-width == true {
      n => 100%
    } else {
      let margin-f = parse-general-func-with-level-n(enum-margin, auto, auto, ..args)(curr-level)
      n => {
        let margin = margin-f(n)
        if margin == auto {
          auto
        } else if type(margin) in length-type {
          100% - margin
        } else if margin != none {
          panic("Invalid arguments: enum-margin should be a length.")
        } // none
      }
    }
  }

  let spacing = if it.spacing == auto {
    if it.tight { par.leading } else { par.spacing }
  } else {
    it.spacing
  }
  let item-args = args.named()
  let _ = item-args.remove("tag", default: none)

  let curr-tight-mode = parse-args-with-level(tight-mode, curr-level, ..item-args)
  let is-auto-tight-mode = false
  let (default-above, default-below) = (spacing, par.spacing)

  if it.spacing == auto {
    if curr-tight-mode not in (auto, none) and type(curr-tight-mode) != dictionary {
      if curr-tight-mode == "always-tight" {
        (default-above, default-below) = (par.leading, par.spacing)
      } else if curr-tight-mode == "never-tight" {
        (default-above, default-below) = (par.spacing, par.spacing)
      } else if curr-tight-mode == "compact-tight" {
        (default-above, default-below) = (par.leading, par.leading)
      } else if curr-tight-mode == "default" {
        //
      } else {
        panic(
          "Invalid tight-mode. The legal values are the following strings: always-tight, never-tight, compact-tight, default; or `auto`; or `dictionary` with keys: tight, not-tight, par-tight.",
        )
      }
    } else {
      is-auto-tight-mode = true
    }
  } else {
    // native behavior in typst >= 0.14
    (default-above, default-below) = (spacing, spacing)
  }

  let is-enabel-par-tight-spacing = false
  let (tight-h-spacing, not-tight-h-spacing, par-tight-h-spacing) = if is-auto-tight-mode == true {
    if curr-tight-mode == auto {
      ((spacing, par.spacing), (par.spacing, par.spacing), (par.spacing, par.spacing))
    } else {
      if type(curr-tight-mode) == dictionary {
        let default-tight-spacing = (par.leading, par.spacing)
        let default-not-tight-spacing = (par.spacing, par.spacing)

        let tight-spacing = curr-tight-mode.at("tight", default: default-tight-spacing)
        let not-tight-spacing = curr-tight-mode.at("not-tight", default: default-not-tight-spacing)
        let par-tight-spacing = curr-tight-mode.at("par-tight", default: not-tight-spacing)

        // auto value case
        tight-spacing = get-auto-value(tight-spacing, default-tight-spacing)
        not-tight-spacing = get-auto-value(not-tight-spacing, default-not-tight-spacing)
        par-tight-spacing = get-auto-value(par-tight-spacing, not-tight-spacing)

        assert(
          type(tight-spacing) == array
            and tight-spacing.len() == 2
            and type(not-tight-spacing) == array
            and not-tight-spacing.len() == 2
            and type(par-tight-spacing) == array
            and par-tight-spacing.len() == 2,
          message: "Hint: The values of `tight`, `not-tight` and `par-tight` should be an array with two elements (length or `auto`).",
        )

        // auto element case
        tight-spacing.at(0) = get-auto-value(tight-spacing.at(0), par.leading)
        tight-spacing.at(1) = get-auto-value(tight-spacing.at(1), par.spacing)
        for i in range(0, 2) {
          not-tight-spacing.at(i) = get-auto-value(not-tight-spacing.at(i), par.spacing)
          par-tight-spacing.at(i) = get-auto-value(par-tight-spacing.at(i), not-tight-spacing.at(0))
          assert(
            type(tight-spacing.at(i)) in length-type-with-fraction
              and type(not-tight-spacing.at(i)) in length-type-with-fraction
              and type(par-tight-spacing.at(i)) in length-type-with-fraction,
            message: "Hint: The two elements should be length or `auto`.",
          )
        }
        is-enabel-par-tight-spacing = (
          not-tight-spacing.at(0) != par-tight-spacing.at(0) or not-tight-spacing.at(1) != par-tight-spacing.at(1)
        )
        (tight-spacing, not-tight-spacing, par-tight-spacing)
      } else {
        ((none, none), (none, none), (none, none))
      }
    }
  } else { ((none, none), (none, none), (none, none)) }

  /*feat: auto-detect-tight (ver0.3.0)*/
  let parbreak-tight-spacing = {
    if is-auto-tight-mode == true {
      let is-par = false
      if it.spacing == auto and (is-enabel-par-tight-spacing or it.tight) {
        let enable-auto-detect-tight = auto-detect-tight.get()
        if enable-auto-detect-tight {
          let _pars = query(selector(paragraph-ID).before(here()))
          is-par = _pars.len() > 0 and _pars.last().location().position() == here().position() // is this enough? at least in default it looks fine.
        }
      }
      if is-par {
        // 首行有空行
        if not it.tight { not-tight-h-spacing } else { par-tight-h-spacing }
      } else {
        // 首行无空行
        if it.tight { tight-h-spacing } else {
          if is-enabel-par-tight-spacing { par-tight-h-spacing } else { not-tight-h-spacing }
        }
      }
    } else {
      (default-above, default-below)
    }
  }

  let (enum-above-spacing, enum-below-spacing) = {
    if enum-spacing == auto {
      parbreak-tight-spacing
    } else {
      // feat: support for function type
      let _enum-spacing = parse-args-with-level(enum-spacing, curr-level, ..item-args)
      if _enum-spacing == auto {
        parbreak-tight-spacing
      } else {
        let _type = type(_enum-spacing)
        if _type in length-type-with-fraction {
          (_enum-spacing, _enum-spacing)
        } else if _type == dictionary {
          // 这里可以处理更仔细些
          let (above, below) = _enum-spacing
          (if above == auto { default-above } else { above }, if below == auto { default-below } else { below })
        } else if _enum-spacing != none {
          panic("Invalid arguments.")
        } else {
          (none, none)
        }
      }
    }
  }

  /*feat: tight-item-mode (ver0.3.0)*/
  let curr-tight-item-mode = parse-args-with-level(tight-item-mode, curr-level, ..item-args)
  let auto-item-spacing = if curr-tight-item-mode == "always-tight" {
    par.leading
  } else if curr-tight-item-mode == "never-tight" {
    par.spacing
  } else if curr-tight-item-mode == auto {
    spacing
  } else if type(curr-tight-item-mode) == dictionary {
    let tight-item-spacing = curr-tight-item-mode.at("tight", default: par.leading)
    let not-tight-item-spacing = curr-tight-item-mode.at("not-tight", default: par.spacing)
    assert(
      type(tight-item-spacing) in length-type-with-fraction
        and type(not-tight-item-spacing) in length-type-with-fraction,
      message: "Hint: The values of `tight` and `not-tight` should be length or `auto`.",
    )
    tight-item-spacing = get-auto-value(tight-item-spacing, par.leading)
    not-tight-item-spacing = get-auto-value(not-tight-item-spacing, par.spacing)
    if it.tight { tight-item-spacing } else { not-tight-item-spacing }
  } else if curr-tight-item-mode != none {
    panic(
      "The legal values of `tight-item-mode` should be the following strings: always-tight, never-tight; or `auto`; or dictionary with keys: tight and not-tight",
    )
  }

  let curr-item-spacing = parse-general-func-with-level-n(
    item-spacing,
    auto,
    auto-item-spacing,
    ..args,
  )(
    curr-level,
  )


  return (
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
  )
}




/// Parses the auto-label-width argument to validate its value
///
/// Validates that the auto-label-width argument contains acceptable values.
///
/// - auto-label-width (any): The auto-label-width value to parse
/// - level (int): Current nesting level
/// - args (arguments): Additional arguments
/// -> any
#let parse-auto-label(auto-label-width, level, ..args) = {
  let curr-auto-label = parse-args-with-level(auto-label-width, level, ..args)
  assert(
    curr-auto-label in (none, auto, "none", "each", "all", "enum", "list"),
    message: "The argument should be `none`, `auto`, or one of the following strings: \"each\", \"all\", \"enum\", \"list\".",
  )
  return curr-auto-label
}
