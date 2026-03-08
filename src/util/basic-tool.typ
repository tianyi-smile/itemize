#import "identifier.typ": *
#import "func-type.typ": length-type, length-type-with-fraction



/// Prevent line breaks at specific positions
///
/// Creates a context that prevents line breaks using non-breaking spaces.
///
/// -> content
#let no-line-break = context {
  [#h(-measure([#sym.wj#sym.space.nobreak]).width)#sym.wj#sym.space.nobreak]
}

/// Test if arr1 contains all elements of arr2
///
/// - arr1 (array): The array to check against
/// - arr2 (array): The array containing elements to check for
/// -> bool
#let contains-all(arr1, arr2) = {
  for v in arr2 {
    if v not in arr1 {
      return false
    }
  }
  return true
}

/// Get the type of an element, handling 'enum' and 'list' cases.
///
/// -> any
#let get_type-enum-or-list(elem) = {
  if elem == "enum" {
    enum
  } else if elem == "list" {
    list
  } else {
    elem
  }
}

/// Rebuild a label for an element, optionally adding a suffix.
///
/// -> any
#let rebuild-label(elem, _label) = {
  if _label == none {
    return elem
  } else {
    [#elem#_label]
  }
}


/// Define default arguments for text styling.
///
/// -> any
#let default-text-args = (
  alternates: false,
  baseline: 0pt,
  bottom-edge: "baseline",
  cjk-latin-spacing: auto,
  costs: (
    hyphenation: 100%,
    runt: 100%,
    widow: 100%,
    orphan: 100%,
  ),
  dir: auto,
  discretionary-ligatures: false,
  fallback: true,
  features: (:),
  fill: luma(0%),
  font: "libertinus serif",
  fractions: false,
  historical-ligatures: false,
  hyphenate: auto,
  kerning: true,
  lang: "en",
  ligatures: true,
  number-type: auto,
  number-width: auto,
  overhang: true,
  region: none,
  script: auto,
  size: 11pt,
  slashed-zero: false,
  spacing: 100% + 0pt,
  stretch: 100%,
  stroke: none,
  style: "normal",
  stylistic-set: (),
  top-edge: "cap-height",
  tracking: 0pt,
  weight: "regular",
)

/// Get current `par` arguments
///
/// Extracts relevant paragraph styling properties from a paragraph object.
///
/// - it (paragraph): The paragraph object to extract arguments from
/// -> dictionary
#let get_current-par-args(it) = (
  // first-line-indent: dictionary | length = (amount: 0pt, all: false),
  // hanging-indent: length = 0pt,
  justify: it.justify,
  leading: it.leading,
  linebreaks: it.linebreaks,
  spacing: it.spacing,
  ..(if sys.version >= version(0, 14, 0) { (justification-limits: it.justification-limits) } else { (:) }),
)

/// Get the current text arguments
///
/// -> Dictionary
#let get_current-text-args(it) = (
  alternates: it.alternates,
  baseline: it.baseline,
  bottom-edge: it.bottom-edge,
  cjk-latin-spacing: it.cjk-latin-spacing,
  costs: it.costs,
  dir: it.dir,
  discretionary-ligatures: it.discretionary-ligatures,
  fallback: it.fallback,
  features: it.features,
  fill: it.fill,
  font: it.font,
  fractions: it.fractions,
  historical-ligatures: it.historical-ligatures,
  hyphenate: it.hyphenate,
  kerning: it.kerning,
  lang: it.lang,
  ligatures: it.ligatures,
  number-type: it.number-type,
  number-width: it.number-width,
  overhang: it.overhang,
  region: it.region,
  script: it.script,
  size: it.size,
  slashed-zero: it.slashed-zero,
  spacing: it.spacing,
  stretch: it.stretch,
  stroke: it.stroke,
  style: it.style,
  stylistic-set: it.stylistic-set,
  top-edge: it.top-edge,
  tracking: it.tracking,
  weight: it.weight,
)

/// Define default arguments for box elements.
///
/// -> Dictionary
#let default-box-args = (
  // width: auto,
  height: auto,
  baseline: 0pt,
  fill: none,
  stroke: none,
  radius: 0pt,
  inset: 0em,
  outset: 0pt,
  clip: false,
)


/// Default arguments of block.
///
/// -> any
#let default-block-args = (
  // width: 100%,
  height: auto,
  fill: none,
  stroke: none, /**/
  radius: 0pt,
  inset: 0pt,
  outset: 0pt,
  // spacing: 0pt,
  above: 1.2em,
  below: 1.2em,
  clip: false,
  sticky: false,
  breakable: true,
)

/// Default arguments for grid cells
///
/// - breakable (auto): Whether the cell can break across pages
/// - colspan (int): Number of columns the cell spans
/// - fill (none): Cell background fill
/// - inset (0pt): Cell padding
/// - rowspan (int): Number of rows the cell spans
/// - stroke (none): Cell border stroke
///
/// -> dictionary
#let default-grid-cell-args = (
  // align: auto,
  breakable: auto,
  colspan: 1,
  fill: none,
  inset: 0pt,
  rowspan: 1,
  stroke: none,
)

/// Default arguments for grid layout
#let default-grid-args = (
  align: auto,
  column-gutter: (),
  fill: none,
  gutter: (),
  inset: (:),
  row-gutter: (),
  rows: (),
  stroke: none,
)

/// Get the current block arguments
///
/// Extracts block formatting properties while preventing override by user `set` commands.
///
/// - it (block): The block object to extract arguments from
/// -> dictionary
#let get-current-block-args(it) = (
  width: it.width,
  height: it.height,
  fill: it.fill,
  stroke: it.stroke,
  radius: it.radius,
  inset: it.inset,
  outset: it.outset,
  // spacing: block.spacing, // through `above`, `below`
  above: it.above,
  below: it.below,
  clip: it.clip,
  sticky: it.sticky,
  breakable: it.breakable,
)


/// Creates a formatted block to wrap content.
#let make-format-box(body, format-args: (:), ..args) = {
  if format-args not in ((:), none, auto, ()) {
    block.with(..default-block-args, ..format-args, ..args)(
      body,
    )
  } else {
    body
  }
}

/// Retrieves the marker text from the given body.
///
/// Parameters
/// - `body`: The input body to extract the marker text from.
///
/// Returns
/// The extracted marker text as a string, or `none` if no valid marker text is found.
#let get_marker-text(body) = {
  if body == [ ] {
    " "
  } else if body == ["] {
    "\""
  } else if body == ['] {
    "'"
  } else if body.has("text") {
    body.text
  } else {
    none
  }
}

/// Retrieves the description marker from a given body if it matches the expected metadata and list-ID kind.
///
/// Parameters
/// - `body`: The body to check for the description marker.
///
/// Returns
/// The description marker if found, otherwise `none`.
#let get_desc-marker(body) = {
  if (
    body.func() == metadata and type(body.value) == dictionary and body.value.at("kind", default: none) == item-label-ID
  ) {
    return body.value.body
  } else {
    return none
  }
}

/// Fixes the indentation issue for the first line of a paragraph.
///
/// -> any
#let fix-first-line-h(inset: 0pt) = {
  [#h(-par.first-line-indent.amount - inset)]
}

/// Get the label of an element if it exists.
///
/// -> any
#let get-elem-label(e) = {
  return if e.has("label") { e.label } else { none }
}

/// Get a label from a string, label, or object with a text property.
///
/// -> any
#let get-label(it) = {
  return if type(it) == str {
    label(it)
  } else if type(it) == label {
    it
  } else if it.has("text") {
    label(it.text)
  } else {
    panic("The argument should be a string or a label.")
  }
}

/// Helper function to get the dir's inset value from a dictionary or length
///
/// Parameters:
///   - inset: The inset value (can be length, relative, ratio, or dictionary)
///   - dir: The direction to get the inset value for
///
/// Returns:
///   Inset value for the given dir
#let get-dir-inset(inset, dir: "left") = {
  let left-inset = 0pt
  if type(inset) in length-type {
    //(length, relative, ratio)
    left-inset = inset
  } else if type(inset) == dictionary {
    // dictionary (not none)
    let left = inset.at(dir, default: none)
    if left == none {
      let two-dir = if dir in ("left", "right") { "x" } else { "y" }
      left = inset.at(two-dir, default: none)
      if left == none {
        left = inset.at("rest", default: none)
        if left == none {
          left = 0pt
        }
        left-inset = left
      } else {
        left-inset = left
      }
    } else {
      left-inset = left
    }
  }
  return left-inset
}


/// Parse inset values excluding the given dir's inset.
///
/// -> any
#let parse-inset-without-dir(inset, dir: "left") = {
  if type(inset) in length-type {
    return (rest: inset)
  } else if type(inset) == dictionary {
    let _ = inset.remove(dir, default: none)
    return inset
  } else {
    panic("Invalid arguments.")
  }
}

/// Get the ratio component of a relative length
///
/// - inset (relative, ratio, any): The inset value to extract ratio from
/// -> ratio
#let get-relative-ratio(inset) = {
  if type(inset) == relative {
    return inset.ratio
  } else if type(inset) == ratio {
    return inset
  } else {
    return 0%
  }
}

/// Get the length component of a relative length
///
/// - inset (relative, length, any): The inset value to extract length from
/// -> length
#let get-relative-length(inset) = {
  if type(inset) == relative {
    return inset.length
  } else if type(inset) == length {
    return inset
  } else {
    return 0%
  }
}

/// Measure the absolute length of an inset value
///
/// - inset (any): The inset value to measure
/// -> length
#let get-length(inset) = {
  return measure(line(length: inset)).width.to-absolute()
}

/// Get the absolute length value by combining absolute and em components
///
/// - inset (length, relative, any): The inset value to convert to absolute length
/// -> length
#let get-absolute-length(inset) = {
  if type(inset) == length {
    let abs = inset.abs
    let em = inset.em

    return (
      if abs < 0pt {
        -get-length(-abs)
      } else {
        get-length(abs)
      }
        + if em < 0 {
          -get-length(-em * 1em)
        } else {
          get-length(em * 1em)
        }
    )
  }
  if type(inset) == relative {
    return get-absolute-length(inset.length)
  }
}

/// Check if a body is marked to prevent recursion
///
/// Determines if the body contains metadata indicating recursion prevention.
///
/// - body (content): The body to check
/// -> bool
#let is-prevent-recursion-body(body) = {
  return (
    body.has("children")
      and body.children.at(0, default: []).func() == metadata
      and body.children.at(0).value == prevent-recursion-ID
  )
}


/// Create a baseline tag with metadata for vertical alignment
///
/// - height: Total height of the element
/// - baseline: Baseline position
/// - weak: Whether to use weak horizontal spacing
/// -> content
#let baseline-tag-meta(height: 0pt, baseline: 0pt, weak: true) = {
  let weak-h = if weak { h(0pt, weak: true) } else { none }
  [#metadata(
      (height: height, baseline: baseline),
    )#el-baseline-label#weak-h]
}

/// Get the value at a specific index in an array, handling LOOP cases.
///
/// Supports cyclic array access when the last element is `LOOP`.
///
/// - arr (array): The array to access
/// - n (int): The index to retrieve
/// -> any
#let get-array-value(arr, n) = {
  // arr is an array
  if arr != () {
    let last = arr.last()
    if last == LOOP {
      let len = arr.len()
      if len == 1 {
        return ()
      } else {
        let m = calc.rem-euclid(n, len - 1)
        return arr.at(m)
      }
    } else {
      return arr.at(n, default: last)
    }
  } else {
    return arr
  }
}

/// Retrieves a value from an array based on the current nesting level.
///
/// - value: The value or array of values.
/// - level: The current nesting level.
/// -> any
#let get-depth-value(value, level) = {
  if type(value) == array {
    if value == () {
      return value
    } else {
      return get-array-value(value, level)
    }
  } else {
    return value
  }
}


/// Get the default value for a given parameter.
///
/// -> any
#let get-default-value(value, initial, default) = {
  if value == initial { default } else { value }
}
/// Get the auto value for a given parameter.
///
/// -> any
#let get-auto-value(value, default) = {
  return get-default-value(value, auto, default)
}



// form: n => value
// return : n => value
/// Get the value at a specific index in an array.
///
/// -> any
#let get-value-by-n(func, initial, default) = {
  if type(func) == function {
    // form: n => value
    return n => get-default-value(func(n + 1), initial, default)
  } else if type(func) == array {
    n => get-default-value(get-array-value(func, n), initial, default)
  } else {
    return _ => get-default-value(func, initial, default)
  }
}
// form: level => n => value
// return: n => vallue
/// Get the value at a specific depth in a nested structure.
///
/// -> any
#let get-depth-value-by-n(func, level, initial, default) = {
  if type(func) == function {
    // func: level => n => value; level => array; level => value;
    return get-value-by-n(func(level + 1), initial, default)
  } else {
    // func: array; value
    return get-value-by-n(get-depth-value(func, level), initial, default)
  }
}

/// Return a default 'none' value.
///
/// -> none
#let get-none-value(value1, value2) = {
  if value2 != none {
    return value2
  } else {
    return value1
  }
}

/// Display text with specified formatting.
///
/// -> any
#let show-text(args, body) = {
  if args not in (none, (:)) {
    set text(..args)
    body
  } else {
    body
  }
}
