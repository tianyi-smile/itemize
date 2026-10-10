#import "../util/parse-args.typ": *

/// Parse supplement content
#let supp(body, supplement, ..args) = {
  if supplement not in (auto, [], none) {
    if type(supplement) == dictionary {
      let prefix = supplement.remove("prefix", default: [])
      let suffix = supplement.remove("suffix", default: [])
      assert(
        supplement == (:),
        message: "The key of `supplement` should be: `prefix`, `suffix`."
          + "\nBut found: "
          + supplement.keys().join(", "),
      )
      [#prefix~#h(0em, weak: true)#body#h(0em, weak: true)~#suffix]
    } else if type(supplement) == function {
      let level-n-args = (body: body, ..args.named())
      [#supplement(level-n-args)]
    } else {
      [#supplement~#h(0em, weak: true)#body]
    }
  } else {
    [#body]
  }
}

/// Pre-parse item supplement arguments (do not handle `auto`, `none`)
#let pre-parse-supplement(supplement, level, ..args) = n => (body, ..other-args) => {
  if supplement in (none, auto) {
    return supplement
  }
  if type(supplement) == function {
    supp(body, supplement, level: level + 1, n: n + 1, ..pre-parse-tag(n, ..args), ..other-args)
  } else {
    let _supplement = get-depth-value(supplement, level)
    if _supplement in (none, auto) {
      return _supplement
    }
    if type(_supplement) == function {
      supp(body, _supplement, n: n + 1, ..pre-parse-tag(n, ..args), ..other-args)
    } else {
      _supplement = get-value-by-n(_supplement, none, none)(n)
      if _supplement in (none, auto) {
        return _supplement
      }
      supp(body, _supplement)
    }
  }
}

/// Parse item supplement arguments (handle `auto`, `none` as `_ => body`)
#let parse-supplement(
  curr-supplement,
  rel-level,
  elem-supplement,
  abs-level,
  ..args,
) = n => (body, ..other-args) => {
  let supplement = pre-parse-supplement(elem-supplement, abs-level, ..args)(n)(body, ..other-args)
  if supplement in (auto, none) {
    supplement = pre-parse-supplement(curr-supplement, rel-level, ..args)(n)(body, ..other-args)
    if supplement not in (auto, none) {
      return supplement
    } else {
      return body
    }
  } else {
    return supplement
  }
}
