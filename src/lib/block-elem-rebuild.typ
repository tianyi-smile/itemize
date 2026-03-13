#import "../util/func-type.typ": *
#import "../util/identifier.typ": *
#import "../util/level-state.typ": *
#import "../util/basic-tool.typ": *

#import "../lib/par-lib.typ": fix-first-par-state, par-state

/// Defines different inline element types for layout processing
/// - inline (bool): Inline-level element
/// - block (bool): Block-level element
/// - list (none): List element (enum, list)
/// - blank (str): Blank element (no content)
#let InlineType = (
  inline: true,
  block: false,
  list: none,
  blank: "blank",
)

/// Process body content without numbering element
/// - body (dictionary): Body content dictionary
/// - func (function): Processing function
/// -> dictionary
#let with-no-number-body(body, func) = {
  if body != (:) {
    return (body-no: func(body.body-no))
  } else {
    (:)
  }
}

/// Resolve body with numbering and baseline alignment
/// - body (content): The content body to resolve
/// - number (none): Optional numbering element
/// - inset (length): Inset spacing
/// - label-height (length): Label height for baseline alignment
/// - curr-baseline (length): Current baseline position
#let resolved-body(body, number: none, label-height: 0pt, curr-baseline: 0pt) = {
  let number-box = if number != none {
    no-line-break
    number
  }
  h(0pt, weak: true)
  number-box
  baseline-tag-meta(
    height: label-height,
    baseline: curr-baseline,
  )
  body
}

/// Layout block elements with height adjustment for proper alignment
/// - func (function): Block layout function (block, par, etc.)
/// - original-body (content): Original body content without numbering
/// - revised-body (content): Revised body content with numbering
/// - field (dictionary): Layout field parameters (height, inset, etc.)
/// - _label (none): Optional label element for referencing
/// - display-hide (bool): Whether to display hidden content
/// -> content
#let block-layout(
  func,
  original-body,
  revised-body,
  field,
  _label,
  display-hide: false,
) = {
  layout(size => {
    // Try to measure line height (may not always work correctly)
    let block-height = field.at("height", default: func.height)
    let block-inset = field.at("inset", default: func.inset)
    let inset-args = if type(block-inset) != dictionary {
      (rest: block-inset)
    } else {
      block-inset
    }

    // Process: If top-inset is relative, calculate the actual top-inset length
    let top-inset = get-dir-inset(block-inset, dir: "top")
    let bottom-inset = get-dir-inset(block-inset, dir: "bottom")
    let top-inset-ratio = get-relative-ratio(top-inset)
    let bottom-inset-ratio = get-relative-ratio(bottom-inset)

    if block-height != auto {
      let user-height-ratio = get-relative-ratio(block-height)
      let user-height = get-absolute-length(block-height) + user-height-ratio * size.height
      // now top-inset is fixed
      top-inset = get-absolute-length(top-inset) + top-inset-ratio * user-height
      bottom-inset = get-absolute-length(bottom-inset) + bottom-inset-ratio * user-height
    }


    let original-auto = func(
      original-body,
      ..field,
      height: auto, // in order to measure the actual height
      inset: inset-args + (top: top-inset) + (bottom: bottom-inset), // make sure the top-inset and bottom-inset are correct
    )

    let real-height = measure(
      width: size.width,
      original-auto,
    ).height

    if block-height == auto {
      // now top-inset is fixed
      top-inset = get-absolute-length(top-inset) + top-inset-ratio * real-height
      bottom-inset = get-absolute-length(bottom-inset) + bottom-inset-ratio * real-height
    }

    let revised = func(
      revised-body,
      ..field,
      height: auto, // inorder to measure the height
      // stroke: blue, // debug
      inset: inset-args + (top: top-inset) + (bottom: bottom-inset), // make sure the top-inset and bottom-inset are correct
    )

    let revised-height = measure(
      width: size.width,
      revised,
    ).height

    let height-inset = revised-height - real-height

    let rebuild-top-inset = top-inset - height-inset
    let rebuild = if display-hide {
      rebuild-label(
        func(
          revised-body,
          ..field,
          // stroke: red, // debug
          inset: inset-args + (top: rebuild-top-inset) + (bottom: bottom-inset),
        ),
        _label,
      )
    } else {
      rebuild-label(
        func(
          original-body,
          ..field,
        ),
        _label,
      )
    }
    // Skip processing if heights are equal (within tolerance)
    if not display-hide and height-inset <= 0.01pt {
      return rebuild
    }
    let adjust-top-inset = calc.max(height-inset - top-inset, 0pt)
    pad(
      top: adjust-top-inset,
      rest: 0pt,
      rebuild,
    )
  })
}



/// General layout for block-level elements with height adjustment
/// - func (function): Block layout function
/// - original-body (content): Original body content
/// - revised-body (content): Revised body content
/// - field (dictionary): Layout field parameters
/// - pos-args (arguments): Positional arguments
/// - _label (none): Optional label element
/// - display-hide (bool): Whether to display hidden content
#let general-block-level-elem-layout(
  func,
  original-body,
  revised-body,
  field,
  pos-args: (),
  _label,
  display-hide: false,
) = {
  let hide-body-layout(elem) = {
    if is-prevent-recursion-body(elem.body) {
      return elem
    }
    layout(size => {
      let field = field
      // Try to measure line height (may not always work correctly)
      let elem-height = field.remove("height", default: none)
      let elem-inset = field.remove("inset", default: none)

      let block-height = if elem-height != none { elem-height } else { block.height }

      let block-inset = if elem-inset != none { elem-inset } else { block.inset }

      let inset-args = if type(block-inset) != dictionary {
        (rest: block-inset)
      } else {
        block-inset
      }

      let top-inset = get-dir-inset(block-inset, dir: "top")
      let bottom-inset = get-dir-inset(block-inset, dir: "bottom")
      let top-inset-ratio = get-relative-ratio(top-inset)
      let bottom-inset-ratio = get-relative-ratio(bottom-inset)

      // let user-height = auto
      if block-height != auto {
        let user-height-ratio = get-relative-ratio(block-height)
        let user-height = get-absolute-length(block-height) + user-height-ratio * size.height
        // now top-inset is fixed
        top-inset = get-absolute-length(top-inset) + top-inset-ratio * user-height
        bottom-inset = get-absolute-length(bottom-inset) + bottom-inset-ratio * user-height
      }

      let auto-height-args = if elem-height == none {
        (:)
      } else {
        (height: auto)
      }

      let real-height-args = if elem-height == none {
        (:)
      } else {
        (height: elem-height)
      }

      let re-inset-args = if elem-inset == none {
        (:)
      } else {
        (inset: inset-args + (top: top-inset) + (bottom: bottom-inset))
      }

      let original-auto = {
        set block(
          height: auto,
          inset: inset-args + (top: top-inset) + (bottom: bottom-inset),
        )
        func(
          {
            prevent-recursion-meta
            original-body
          },
          ..pos-args,
          ..field,
          ..auto-height-args, // in order to measure the actual height
          ..re-inset-args, // make sure the top-inset and bottom-inset are correct
        )
      }

      let real-height = measure(
        width: size.width,
        original-auto,
      ).height

      if block-height == auto {
        // now top-inset is fixed
        top-inset = get-absolute-length(top-inset) + top-inset-ratio * real-height
        bottom-inset = get-absolute-length(bottom-inset) + bottom-inset-ratio * real-height
      }

      let revised = {
        set block(
          height: auto,
          inset: inset-args + (top: top-inset) + (bottom: bottom-inset),
        )
        func(
          {
            prevent-recursion-meta
            revised-body
          },
          ..pos-args,
          ..field,
          ..auto-height-args,
          ..re-inset-args,
        )
      }

      let revised-height = measure(
        width: size.width,
        revised,
      ).height

      let height-inset = revised-height - real-height

      let rebuild-top-inset = top-inset - height-inset
      let rebuild = if display-hide {
        rebuild-label(
          func(
            {
              prevent-recursion-meta
              revised-body
            },
            ..pos-args,
            ..field,
            // stroke: red, // debug
            ..real-height-args,
            ..re-inset-args,
          ),
          _label,
        )
      } else {
        rebuild-label(
          func(
            {
              prevent-recursion-meta
              original-body
            },
            ..pos-args,
            ..field,
            ..real-height-args,
            ..re-inset-args,
          ),
          _label,
        )
      }
      // Skip processing if heights are equal (within tolerance)
      if not display-hide and height-inset <= 0.01pt {
        return rebuild
      }

      let adjust-top-inset = calc.max(height-inset - top-inset, 0pt)

      pad(
        top: adjust-top-inset, // adjust-top-inset
        rest: 0pt,
        rebuild,
      )
    })
  }
  show func: hide-body-layout
  rebuild-label(func(original-body, ..pos-args, ..field), _label)
}

/// Rebuild block equation element with height adjustment
/// - e (content): Equation element to rebuild
/// - number (none): Optional numbering element
/// - inset (length): Inset spacing
/// - label-height (length): Label height for baseline alignment
/// - curr-baseline (length): Current baseline position
/// - display-hide (bool): Whether to display hidden content
#let rebuild_block-eq(
  e,
  number: none,
  inset: 0pt,
  label-height: 0pt,
  curr-baseline: 0pt,
  display-hide: true,
) = {
  let field = e.fields()
  let _label = field.remove("label", default: none)
  let _body = field.remove("body")

  return (
    body: {
      let original = rebuild-label(
        e.func()(
          {
            baseline-tag-meta(height: label-height, baseline: curr-baseline)
            _body
          },
          ..field,
        ),
        _label,
      )

      let hide-body-layout(eq) = {
        if is-prevent-recursion-body(eq.body) {
          return eq
        }

        let block-height = block.height
        let block-inset = block.inset

        // Try to measure line height (may not always work correctly)
        let inset-args = if type(block-inset) != dictionary {
          (rest: block-inset)
        } else {
          block-inset
        }

        // Process: If top-inset is relative, calculate the actual absolute length

        let top-inset = get-dir-inset(block-inset, dir: "top")
        let bottom-inset = get-dir-inset(block-inset, dir: "bottom")
        let top-inset-ratio = get-relative-ratio(top-inset)
        let bottom-inset-ratio = get-relative-ratio(bottom-inset)

        if block-height != auto {
          // let user-height-ratio = get-relative-ratio(block-height)
          // `block-height` has ratio part is not common usage, we do not consider here
          let user-height = get-absolute-length(block-height)
          // now top-inset is fixed
          top-inset = get-absolute-length(top-inset) + top-inset-ratio * user-height
          bottom-inset = get-absolute-length(bottom-inset) + bottom-inset-ratio * user-height
        }

        let new-auto-body = {
          set block(
            height: auto,
            inset: inset-args + (top: top-inset) + (bottom: bottom-inset),
          )
          e.func()(
            {
              prevent-recursion-meta
              _body
            },
            ..field,
          )
        }

        let real-height = measure(new-auto-body).height

        if block-height == auto {
          // now top-inset is fixed
          top-inset = get-absolute-length(top-inset) + top-inset-ratio * real-height
          bottom-inset = get-absolute-length(bottom-inset) + bottom-inset-ratio * real-height
        }

        let hide-body = {
          set block(
            height: auto,
            inset: inset-args + (top: top-inset) + (bottom: bottom-inset),
          )
          e.func()(
            {
              prevent-recursion-meta
              number
              _body
            },
            ..field,
          )
        }

        let hide-height = measure(hide-body).height

        let height-inset = hide-height - real-height

        if height-inset <= 0.01pt {
          // Skip processing if heights are equal (within tolerance)
          eq
        } else {
          let adjust-top-inset = calc.max(height-inset - top-inset, 0pt)
          pad(
            top: adjust-top-inset,
            rest: 0pt,
            eq,
          )
        }
      }
      show math.equation.where(block: true): hide-body-layout
      original
      fix-first-par-state()
    },
    inline: InlineType.block,
  )
}

/// Rebuild general block-level elements with height adjustment
/// - e (content): Element to rebuild
/// - number (none): Optional numbering element
/// - inset (length): Inset spacing
/// - label-height (length): Label height for baseline alignment
/// - curr-baseline (length): Current baseline position
/// - elem-func (function): Element processing function
/// - pos-args (arguments): Positional arguments
#let rebuild-general-block-level-elem(
  e,
  number: none,
  inset: 0pt,
  label-height: 0pt,
  curr-baseline: 0pt,
  elem-func,
  ..pos-args,
) = {
  let field = e.fields()
  let _label = field.remove("label", default: none)
  let _body = field.remove("body", default: [])
  let pos-field = for (k, v) in pos-args.named() {
    let value = field.remove(str(k), default: v)
    (value,)
  }
  let (inline, body, ..body-no) = elem-func(_body)
  if inline == InlineType.blank {
    return (
      body: {
        baseline-tag-meta(height: label-height, baseline: curr-baseline, weak: false)
        e
        fix-first-par-state()
      },
      inline: InlineType.block,
    )
  }

  if inline == InlineType.inline {
    return (
      body: {
        let original-body = body-no.body-no
        let revised-body = body
        let hide-body-layout = general-block-level-elem-layout(
          e.func(),
          original-body,
          revised-body,
          field,
          _label,
          pos-args: pos-field,
        )
        hide-body-layout
        fix-first-par-state()
      },
      inline: InlineType.block,
    )
  } else {
    return (
      body: {
        let oringal-body = _body
        let revised-body = body
        let hide-body-layout = general-block-level-elem-layout(
          e.func(),
          oringal-body,
          revised-body,
          field,
          _label,
          pos-args: pos-field,
          display-hide: true,
        )
        hide-body-layout
      },
      inline: inline,
    )
  }
}

/// Rebuild block element
/// - e (content): Block element to rebuild
/// - number (none): Optional numbering element
/// - inset (length): Inset spacing
/// - label-height (length): Label height for baseline alignment
/// - curr-baseline (length): Current baseline position
/// - elem-func (function): Element processing function
#let rebuild-block-elem(
  e,
  number: none,
  inset: 0pt,
  label-height: 0pt,
  curr-baseline: 0pt,
  elem-func,
) = {
  let field = e.fields()

  let _label = field.remove("label", default: none)
  let _body = field.remove("body", default: [])
  let (inline, body, ..body-no) = elem-func(_body)
  if inline == InlineType.blank {
    return (
      body: {
        baseline-tag-meta(height: label-height, baseline: curr-baseline, weak: false)
        e
        fix-first-par-state()
      },
      inline: InlineType.block,
    )
  }
  if inline == InlineType.inline {
    return (
      body: {
        let original-body = body-no.body-no
        let revised-body = body
        let hide-body-layout = block-layout(e.func(), original-body, revised-body, field, _label)
        hide-body-layout
        fix-first-par-state()
      },
      inline: InlineType.block,
    )
  } else {
    return (
      body: {
        let oringal-body = _body
        let revised-body = body
        let hide-body-layout = block-layout(e.func(), oringal-body, revised-body, field, _label, display-hide: true)
        hide-body-layout
      },
      inline: inline,
    )
  }
}

/// Rebuild terms element
/// - e (content): Terms element to rebuild
/// - number (none): Optional numbering element
/// - inset (length): Inset spacing
/// - label-height (length): Label height for baseline alignment
/// - curr-baseline (length): Current baseline position
#let rebuild-terms-elem(
  e,
  number: none,
  inset: 0pt,
  label-height: 0pt,
  curr-baseline: 0pt,
) = {
  return (
    body: {
      if e.func() == terms {
        show terms: it => {
          if get-elem-label(it) == label(prevent-recursion-ID) {
            return it
          }
          let body = it.children
          let first = body.remove(0)
          let first-term = terms.item(
            {
              number
              baseline-tag-meta(height: label-height, baseline: curr-baseline)
              first.term
            },
            first.description,
          )
          // <= Typst 0.14.2
          [#terms(
              hanging-indent: it.hanging-indent,
              indent: it.indent,
              separator: it.separator,
              spacing: it.spacing,
              tight: it.tight,
              first-term,
              ..body,
            )#label(prevent-recursion-ID)]
        }
        e
        fix-first-par-state()
      } else {
        terms.item(
          {
            number
            baseline-tag-meta(height: label-height, baseline: curr-baseline)
            e.term
          },
          e.description,
        )
        fix-first-par-state()
      }
    },
    inline: InlineType.block,
  )
}

/// Rebuild pad element
/// - e (content): Pad element to rebuild
/// - number (none): Optional numbering element
/// - inset (length): Inset spacing
/// - label-height (length): Label height for baseline alignment
/// - curr-baseline (length): Current baseline position
/// - elem-func (function): Element processing function
#let rebuild-pad-elem(
  e,
  number: none,
  inset: 0pt,
  label-height: 0pt,
  curr-baseline: 0pt,
  elem-func,
) = {
  let field = e.fields()
  let _label = field.remove("label", default: none)
  let _body = field.remove("body", default: [])
  let (inline, body, ..body-no) = elem-func(_body)
  if inline == InlineType.blank {
    return (
      body: {
        baseline-tag-meta(height: label-height, baseline: curr-baseline, weak: false)
        e
        fix-first-par-state()
      },
      inline: InlineType.block,
    )
  }
  let func = e.func()

  let pad-layout(original-body, revised-body, display-hide: false) = {
    layout(size => {
      let top-inset = get-dir-inset(field, dir: "top")
      let bottom-inset = get-dir-inset(field, dir: "bottom")
      let top-inset-ratio = get-relative-ratio(top-inset)
      let bottom-inset-ratio = get-relative-ratio(bottom-inset)

      let original-auto = func(
        original-body,
        ..field,
        ..(top: top-inset, bottom: bottom-inset), // make sure the top-inset and bottom-inset are correct
      )

      let real-height = measure(
        width: size.width,
        original-auto,
      ).height

      // now top-inset is fixed
      top-inset = get-absolute-length(top-inset) + top-inset-ratio * real-height
      bottom-inset = get-absolute-length(bottom-inset) + bottom-inset-ratio * real-height


      let revised = func(
        revised-body,
        ..field,
        ..(top: top-inset, bottom: bottom-inset), // make sure the top-inset and bottom-inset are correct
      )

      let revised-height = measure(
        width: size.width,
        revised,
      ).height


      let height-inset = revised-height - real-height

      let rebuild-top-inset = top-inset - height-inset
      let rebuild = if display-hide {
        rebuild-label(
          func(
            revised-body,
            ..field,
            ..(top: top-inset, bottom: bottom-inset), // make sure the top-inset and bottom-inset are correct
          ),
          _label,
        )
      } else {
        rebuild-label(
          func(
            original-body,
            ..field,
          ),
          _label,
        )
      }
      // Skip processing if heights are equal (within tolerance)
      if not display-hide and height-inset <= 0.01pt {
        return rebuild
      }
      let adjust-top-inset = calc.max(height-inset - top-inset, 0pt)
      pad(
        top: adjust-top-inset,
        rest: 0pt,
        rebuild,
      )
    })
  }


  if inline == InlineType.inline {
    return (
      body: {
        let original-body = {
          body-no.body-no
        }
        let revised-body = body
        let hide-body-layout = pad-layout(original-body, revised-body)
        hide-body-layout
        fix-first-par-state()
      },
      inline: InlineType.block,
    )
  } else {
    return (
      body: {
        let oringal-body = _body
        let revised-body = body
        let hide-body-layout = pad-layout(oringal-body, revised-body, display-hide: true)
        hide-body-layout
      },
      inline: inline,
    )
  }
}

/// Rebuild layout element
/// - e (content): Layout element to rebuild
/// - number (none): Optional numbering element
/// - inset (length): Inset spacing
/// - label-height (length): Label height for baseline alignment
/// - curr-baseline (length): Current baseline position
/// - elem-func (function): Element processing function
/// - curr-number-args (arguments): Current numbering arguments
#let rebuild-layout-elem(
  e,
  number: none,
  inset: 0pt,
  label-height: 0pt,
  curr-baseline: 0pt,
  elem-func,
  ..curr-number-args,
) = {
  let _label = get-elem-label(e)
  let new-func = it => {
    let _body = (e.func)(it)
    let (inline, body) = elem-func([#_body])
    if inline == InlineType.blank {
      baseline-tag-meta(height: label-height, baseline: curr-baseline, weak: false)
      _body
      fix-first-par-state()
    } else if inline == InlineType.inline {
      body
      fix-first-par-state()
    } else if inline == InlineType.block {
      body
    } else {
      // same level: special case should be considered !!!
      parent-number-box.update(
        push((
          label-height: label-height,
          curr-baseline: curr-baseline,
          ..curr-number-args.named(),
        )),
      )
      body
    }
  }
  return (
    body: rebuild-label(layout(new-func), _label),
    inline: InlineType.block,
  )
}



/// Detect and process block-level elements with proper layout handling (add `baseline-tag-meta`, fix `first-line-indent`, add `hide-number`)
/// - e (content): Element to detect and process
/// - number (none): Optional numbering element
/// - inset (length): Inset spacing
/// - label-height (length): Label height for baseline alignment
/// - curr-baseline (length): Current baseline position
/// - curr-number-args (arguments): Current numbering arguments
#let detect-block-level-elem(
  e,
  number: none,
  label-height: 0pt,
  curr-baseline: 0pt,
  ..curr-number-args,
) = {
  if is_blank-elem(e) {
    return (body: e, inline: InlineType.blank)
  }

  let func = e.func()

  let _label = get-elem-label(e)

  let elem-func = detect-block-level-elem.with(
    number: number,
    label-height: label-height,
    curr-baseline: curr-baseline,
    ..curr-number-args,
  )

  if func == func-seq {
    let index = -1
    let children = e.children
    for child in children {
      index += 1
      let (inline, body, ..body-no) = elem-func(child)
      if inline == InlineType.blank {
        if child.func() == place {
          children.at(index) = body
        }
        continue
      }

      let _new-body-no = if body-no != (:) {
        let children-no = children
        children-no.at(index) = body-no.body-no
        (body-no: rebuild-label(func-seq(children-no), _label))
      } else {
        (:)
      }
      children.at(index) = body
      return (
        body: rebuild-label(func-seq(children), _label),
        inline: inline,
        .._new-body-no,
      )
    }
    // blank
    return (
      body: rebuild-label(func-seq(children), _label),
      inline: InlineType.blank,
    )
  } else if is_item(e) {
    // list, enum
    return (
      body: e,
      inline: InlineType.list,
    )
  } else if func == block {
    return rebuild-block-elem(
      e,
      number: number,
      label-height: label-height,
      curr-baseline: curr-baseline,
      elem-func,
    )
  } else if func == math.equation and e.has("block") and e.block {
    return rebuild_block-eq(e, number: number, label-height: label-height, curr-baseline: curr-baseline)
  } else if func in (repeat, move, skew, scale) {
    // move???
    return rebuild-general-block-level-elem(
      e,
      number: number,
      label-height: label-height,
      curr-baseline: curr-baseline,
      elem-func,
    )
  } else if func == rotate {
    return rebuild-general-block-level-elem(
      e,
      number: number,
      label-height: label-height,
      curr-baseline: curr-baseline,
      elem-func,
      angle: rotate.angle,
    )
  } else if func == align {
    return rebuild-general-block-level-elem(
      e,
      number: number,
      label-height: label-height,
      curr-baseline: curr-baseline,
      elem-func,
      alignment: align.alignment,
    )
  } else if func == columns {
    return rebuild-general-block-level-elem(
      e,
      number: number,
      label-height: label-height,
      curr-baseline: curr-baseline,
      elem-func,
      count: columns.count,
    )
  } else if func in (terms, terms.item) {
    return rebuild-terms-elem(
      e,
      number: number,
      label-height: label-height,
      curr-baseline: curr-baseline,
    )
  } else if func == v {
    return (
      body: {
        e
        baseline-tag-meta(height: label-height, baseline: curr-baseline)
      },
      inline: InlineType.block,
    )
  } else if func == place {
    // Consider as blank
    return (
      body: {
        e
        // need
        par-state.update(0)
      },
      inline: InlineType.blank,
    )
  } else if func == pad {
    return rebuild-pad-elem(
      e,
      number: number,
      label-height: label-height,
      curr-baseline: curr-baseline,
      elem-func,
    )
  } else if func == par {
    // Since block may not occur inside of a paragraph and was ignored,
    // we assume the body of par is inline-level elem
    // not common case; most common usage: set par(..) ...
    let field = e.fields()
    let _body = field.remove("body")
    // _ = field.remove("first-line-indent", default: none)
    let _label = field.remove("label", default: none)
    return (
      body: {
        set par(..field)
        [#resolved-body(
            _body + parbreak(),
            label-height: label-height,
            curr-baseline: curr-baseline,
            number: number,
          )#_label]
      },
      inline: InlineType.block,
    )
  } else if func == func-layout {
    return rebuild-layout-elem(
      e,
      elem-func,
      number: number,
      label-height: label-height,
      curr-baseline: curr-baseline,
      ..curr-number-args,
    )
  } else {
    if is_styled(e) {
      // styled: set text, set align, set par, etc.
      let field = e.fields()
      let _body = field.remove("child")
      let _label = field.remove("label", default: none)

      let (inline, body, ..body-no) = elem-func(_body)
      let _body-no = with-no-number-body(body-no, it => rebuild-label(e.func()(it, e.styles), _label))
      return (
        body: rebuild-label(e.func()(body, e.styles), _label),
        inline: inline,
        .._body-no,
      )
    } else if is_text-styled(e) {
      let field = e.fields()
      let _body = field.remove("body")
      let _label = field.remove("label", default: none)
      let (inline, body, ..body-no) = elem-func(_body)

      let _body-no = with-no-number-body(body-no, it => rebuild-label(e.func()(it, ..field), _label))
      return (
        body: rebuild-label(e.func()(body, ..field), _label),
        inline: inline,
        .._body-no,
      )
    } else if (
      func
        in (
          // complex containers
          table,
          grid,
          stack, // ??
          // shapes
          circle,
          ellipse,
          rect, // can be handled as a block, but for uniformity, no processing has been done here(ver0.3.0)
          square,
          curve,
          line,
          polygon,
          //
          figure,
          heading,
          image,
          outline,
        )
        or (func == raw and e.has("block") and e.block)
    ) {
      // other block-level elems (do not handle)
      return (
        body: {
          baseline-tag-meta(height: label-height, baseline: curr-baseline, weak: false)
          e
          fix-first-par-state()
        },
        inline: InlineType.block,
      )
    }

    // leaf
    let is-inline = is-inline-elem(e)
    if is-inline {
      if is-content-blank(e) {
        // should we need???
        return (body: e, inline: InlineType.blank)
      }
      // inline-level elem (but not blank)
      return (
        body: resolved-body(e, label-height: label-height, curr-baseline: curr-baseline, number: number),
        body-no: resolved-body(e, label-height: label-height, curr-baseline: curr-baseline),
        inline: InlineType.inline,
      )
    }
    // context + block-level elem or ref + block-level elem... or hide + block-level elem
    return (
      body: {
        baseline-tag-meta(height: label-height, baseline: curr-baseline, weak: false)
        e
      },
      inline: InlineType.block,
    )
  }
}
