
#import "export-el.typ" as ex-el

#import "@preview/elembic:1.1.1" as e: field, types


#let fold = prev-fold => (outer, inner) => {
  if inner != auto {
    if outer == auto {
      inner
    } else {
      outer + inner
    }
  } else {
    (:)
  }
}
#let elem-enum-list = e.element.declare(
  "elem_enum-list",
  prefix: "@preview/itemize,v3",
  doc: "Element of enum-list",
  display: it => {
    ex-el.get-list-enum-method(
      it.doc,
      it.elem, // "both", "list", "enum"
      it.indent,
      it.body-indent,
      it.label-indent,
      it.is-full-width,
      it.item-spacing,
      it.enum-spacing,
      it.enum-margin,
      it.hanging-type,
      it.hanging-indent,
      it.line-indent,
      it.label-width,
      it.body-format,
      it.label-format,
      it.item-format,
      it.auto-base-level,
      it.label-align, //
      it.label-baseline, //
      it.auto-resuming,
      it.auto-label-width,
      it.checklist,
      it.enum-config, //
      it.list-config, //
      it.ref-numbering, //0.3.0
      it.step, //0.3.0
      it.supplement, //0.3.0
      it.tight-item-mode, //0.3.0
      it.tight-mode, //0.3.0
      it.label-inset, //0.3.0
      it.first-line-indent, //0.3.0
      ..it.args,
    )
  },
  fields: (
    field("doc", types.any, folds: false, required: true),
    field("elem", types.any, default: "both", folds: false),
    field("indent", types.any, default: auto, folds: false),
    field("body-indent", types.any, default: auto, folds: false),
    field("label-indent", types.any, default: auto, folds: false),
    field("is-full-width", bool, default: true, folds: false),
    field("item-spacing", types.any, default: auto, folds: false),
    field("enum-spacing", types.any, default: auto, folds: false),
    field("enum-margin", types.any, default: auto, folds: false),
    field("hanging-type", str, default: "classic", folds: false),
    field("hanging-indent", types.any, default: auto, folds: false),
    field("line-indent", types.any, default: auto, folds: false),
    field("label-width", types.any, default: auto, folds: false),
    field("body-format", types.any, default: none, folds: false),
    field("label-format", types.any, default: none, folds: false),
    field("item-format", types.any, default: none, folds: false),
    field("auto-base-level", bool, default: false, folds: false),
    field("label-align", types.any, default: auto, folds: false),
    field("label-baseline", types.any, default: auto, folds: false),
    field("auto-resuming", types.any, default: none, folds: false),
    field("auto-label-width", types.any, default: none, folds: false),
    field("checklist", bool, default: false, folds: false),
    field("ref-numbering", types.any, default: none, folds: false),
    field("supplement", types.any, default: none, folds: false),
    field("tight-mode", types.any, default: none, folds: false),
    field("tight-item-mode", types.any, default: none, folds: false),
    field("step", types.any, default: none, folds: false),
    field("label-inset", types.any, default: none, folds: false),
    field("first-line-inset", types.any, default: none, folds: false),
    field(
      "enum-config",
      types.wrap(types.union(dictionary, auto), fold: fold),
      default: auto,
      folds: true,
    ),
    field(
      "list-config",
      types.wrap(types.union(dictionary, auto), fold: fold),
      default: auto,
      folds: true,
    ),
    field(
      "args",
      types.wrap(types.union(dictionary, auto), fold: fold),
      default: auto,
      folds: true,
    ),
  ),
)
#let default-setting = (
  indent: auto,
  body-indent: auto,
  label-indent: auto,
  is-full-width: true,
  item-spacing: auto,
  enum-spacing: auto,
  enum-margin: auto,
  hanging-indent: auto,
  line-indent: auto,
  label-width: auto,
  body-format: none,
  label-format: none,
  item-format: none,
  auto-base-level: false,
  label-align: auto, //
  label-baseline: auto, //
  enum-config: (:),
  list-config: (:),
  ref-numbering: none, /** new ver0.3.0 */
  supplement: auto, /** new ver0.3.0 */
  tight-mode: auto, /** new ver0.3.0 */
  tight-item-mode: auto, /** new ver0.3.0 */
  step: auto, /** new ver0.3.0 */
  label-inset: auto, /** new ver0.3.0 */
  first-line-inset: auto, /** new ver0.3.0 */
)
#let set_elem-enum-list(
  elem: "both", // "both", "list", "enum"
  indent: none,
  body-indent: none,
  label-indent: none,
  is-full-width: none,
  item-spacing: none,
  enum-spacing: none,
  enum-margin: none,
  hanging-type: "classic", // "classic" "paragraph"
  hanging-indent: none,
  line-indent: none,
  label-width: none,
  body-format: none,
  label-format: none,
  item-format: none,
  auto-base-level: none,
  label-align: none, //
  label-baseline: none, //
  auto-resuming: none,
  auto-label-width: none,
  enum-config: none, //
  list-config: none, //
  checklist: false,
  ref-numbering: none, /** new ver0.3.0 */
  supplement: none, /** new ver0.3.0 */
  tight-mode: none, /** new ver0.3.0 */
  tight-item-mode: none, /** new ver0.3.0 */
  step: none, /** new ver0.3.0 */
  label-inset: none, /** new ver0.3.0 */
  first-line-inset: none, /** new ver0.3.0 */
  ..args,
) = doc => {
  let args-none = (
    indent == none
      and body-indent == none
      and label-indent == none
      and is-full-width == none
      and item-spacing == none
      and enum-spacing == none
      and enum-margin == none
      and hanging-indent == none
      and line-indent == none
      and label-width == none
      and body-format == none
      and label-format == none
      and item-format == none
      and auto-base-level == none
      and label-align == none
      and label-baseline == none
      and enum-config == none
      and list-config == none
      and tight-mode == none
      and tight-item-mode == none
      and step == none
      and label-inset == none
      and first-line-inset == none
      and args.named().len() == 0
  )
  let dic = {
    if indent != none {
      (indent: indent)
    }
    if body-indent != none {
      (body-indent: body-indent)
    }
    if label-indent != none {
      (label-indent: label-indent)
    }
    if is-full-width != none {
      (is-full-width: is-full-width)
    }
    if item-spacing != none {
      (item-spacing: item-spacing)
    }
    if enum-spacing != none {
      (enum-spacing: enum-spacing)
    }
    if enum-margin != none {
      (enum-margin: enum-margin)
    }
    if hanging-indent != none {
      (hanging-indent: hanging-indent)
    }
    if line-indent != none {
      (line-indent: line-indent)
    }
    if label-width != none {
      (label-width: label-width)
    }
    if body-format != none {
      (body-format: body-format)
    }
    if label-format != none {
      (label-format: label-format)
    }
    if item-format != none {
      (item-format: item-format)
    }
    if label-align != none {
      (label-align: label-align)
    }
    if label-baseline != none {
      (label-baseline: label-baseline)
    }
    if auto-base-level != none {
      (auto-base-level: auto-base-level)
    }
    if tight-mode != none {
      (tight-mode: tight-mode)
    }
    if tight-item-mode != none {
      (tight-item-mode: tight-item-mode)
    }
    if step != none {
      (step: step)
    }
    if label-inset != none {
      (label-inset: label-inset)
    }
    if first-line-inset != none {
      (first-line-inset: first-line-inset)
    }
    if enum-config not in (none, (), (:)) {
      (enum-config: enum-config)
    }
    if list-config not in (none, (), (:)) {
      (list-config: list-config)
    }
  }
  show: e.set_(
    elem-enum-list,
    auto-resuming: auto-resuming,
    auto-label-width: auto-label-width,
    checklist: checklist,
    ref-numbering: ref-numbering,
    supplement: supplement,
    ..if args-none { default-setting } else { dic },
    args: if args-none { auto } else { args.named() },
  )
  show: elem-enum-list.with(elem: elem, hanging-type: hanging-type)
  doc
}


/// Configures default styling for `enum` and `list`.
///
/// See `default-enum-list`.
#let set-default = set_elem-enum-list.with(hanging-type: "classic", elem: "both")

/// Configures paragraph styling for `enum` and `list`.
///
/// See `default-enum-list`.
#let set-paragraph = set_elem-enum-list.with(hanging-type: "paragraph", elem: "both")

