#import "version.typ": package-version

/// Unique identifier
#let enum-label-ID = "__cdl_enum-label-ID__" + package-version
#let tag-label-ID = "__cdl_tag-label-ID__" + package-version
#let enum-resume-ID = "__cdl_enum-resume-ID__" + package-version
#let item-label-ID = "__cdl-item-label-ID__" + package-version
#let auto-label-ID = "__cdl_auto-label-end__" + package-version

#let Unique-CDL-Meta = "__Unique-CDL-Meta__" + package-version

/// Mark the last element in the array for cyclic usage. I.e., for `array` parameters, if the last element of the array is `LOOP`, then the values in the array will be used cyclically.
#let LOOP = _ => none


// ver0.3.0

#let el-baseline-label = label("__cdl-baseline-label__" + package-version)

/// Prevent recursion flag
#let prevent-recursion-ID = "__cdl_prevent-recursion-ID__" + package-version
#let prevent-recursion-meta = metadata(prevent-recursion-ID)

/// for grid
#let grid-ID = label("__cdl-grid-ID__" + package-version)

/// for tight mode
#let paragraph-ID = label("__cdl-is-paragraph-ID__" + package-version)
