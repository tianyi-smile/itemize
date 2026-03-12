#import "version.typ": package-version


/// State variable to record the global setting of auto-label-width.
#let global-setting-ID-auto-label-width = state("__cdl_global-setting-ID-auto-label-width__" + package-version, false)

/// State varable to record the global setting of auto-resume.
#let global-setting-ID-auto-resuming = state("__cdl_global-setting-ID-auto-resuming__" + package-version, false)

/// State varable to record the setting of auto-resume for nested lists.
#let nested-auto-resume = state("__nested-auto-resume___" + package-version, false)

/// State variable to record the preceding numbers or symbols of "same-level" lists.
#let parent-number-box = state("__parent-number-box__" + package-version, ())

/// State variable to record the parent-level numbering of `enum`.
#let curr-parent-level = state("__enum-parent-number__" + package-version, ())

/// State variable to record the base parent-level numbering of `enum`.
///
/// This variable is used to track the base numbering of parent levels in nested `enum` lists.
#let curr-base-parent-level = state("__curr-base-parent-level__" + package-version, ())

/// State variable to record the nesting level of `list`.
#let list-level = state("__list-level__" + package-version, 0)

/// State variable to record the nesting level of `enum`.
#let enum-level = state("__enum-level__" + package-version, 0)

/// State variable to record the nesting level for items.
#let item-level = state("__item-level__" + package-version, ())

/// State variable to record the `numbering`, `full` and `supplement` parameters of the current `enum`.
#let enum-numbering = state("__enum-numbering__" + package-version, ())

/// State variable to record the maximum width of the current `enum` list.
#let label-width-enum = state("__label-width-enum__" + package-version, ())

/// State variable to record the maximum width of the current `list` list.
#let label-width-list = state("__label-width-list__" + package-version, ())

/// State variable to record the maximum width of the current `enum` and `list` lists.
#let label-width-el = state("__label-width-el__" + package-version, ())

/// State variable to record the form parameter in the `auto-label-enum` method.
#let width-label-form = state("__width-label-form__" + package-version, auto)

/// State variable to record the `auto-resume` parameter in the `auto-resume-enum` method.
#let auto-resuming-form = state("__auto-resuming-form__" + package-version, none)

/// State variable to record whether enable the tight-mode of `auto-detect` (ver0.3.0).
#let auto-detect-tight = state("__auto-detect-tight__" + package-version, false)

/// Default settings for checklist functionality.
///
/// This object defines the default configuration for checklist items, including:
/// - `enable`: Whether the checklist is enabled (default: `false`)
/// - `label-baseline`: Baseline alignment for labels (default: `auto`)
/// - `checklist-fill`: Fill color for checklist items (default: `auto`)
/// - `checklist-solid`: Solid fill option (default: `none`)
/// - `checklist-radius`: Border radius for checklist items (default: `.1em`)
/// - `extras`: Additional features (default: `false`)
/// - `enable-character`: Whether to enable character symbols (default: `true`)
/// - `enable-format`: Whether to enable custom formatting (default: `false`)
/// - `checklist-map`: Mapping for checklist symbols (default: `(:)`)
/// - `checklist-format-map`: Mapping for checklist formatting (default: `(:)`)
#let default-setting-checklist = (
  "enable": false,
  "label-baseline": auto,
  "checklist-fill": auto,
  "checklist-solid": none,
  "checklist-radius": .1em,
  "extras": false,
  "enable-character": true,
  "enable-format": false,
  "checklist-map": (:),
  "checklist-format-map": (:),
)

/// State variable for checklist settings.
///
/// This variable combines the default checklist settings with additional runtime configurations.
/// It includes a `prev-checklist` field to track previous settings.
#let setting-checklist = state(
  "__setting-checklist__" + package-version,
  default-setting-checklist + ("prev-checklist": ()),
)


/// Basic operator for state


/// Pushes an element to the end of an array.
///
/// - e: The element to push.
/// - it: The array to modify.
/// -> array
#let push(e) = it => {
  it.push(e)
  return it
}

/// Removes the last element from an array.
///
/// - it: The array to modify.
/// -> array
#let pop = it => {
  if it == () { return it }
  _ = it.pop()
  return it
}













