
#import "../lib.typ" as el
#import "helper.typ": *


= Changelog and All Features



Breaking Change: ⚠️

New Feature: 🆕 for ver0.2.x // (`emoji.new`)

If you were using ver0.1.x, please read this section carefully when upgrading to ver0.2.x, as we have made some changes to the configuration methods.
- Two styles of enum-list
  - Default (native typst)
  - Paragraph
- Customize labels and bodies for enums and lists by level and item
  - [N] Allow per-item configuration
  - [N] Enable loop usage of array element values: `LOOP`
  - [N] If a property can be set at both the level and item, it allows passing a function
    - The function format is now standardized as `it => ...`, where you can control it by accessing its properties, typically `it.level` and `it.n`
      - More properties may be added in the future
      - [!] *Breaking change*: Properties related to horizontal spacing now follow this format, and additional properties like `it.label-width` (stores the actual maximum width of the label) and `it.e` (represents the current level's construction object: enum or list) are provided
      - [!] *Breaking change*: Deprecated `level`, `level-count`, and `list-level`
        - Using these methods to configure enum and list properties may sometimes cause "layout did not converge within 5 attempts"
        - In ver0.1.x, per-level and per-item settings for `enum.numbering` can now be combined with the `numbly` package and the `label-format` method
  - [N] When using the `*-enum-list` method, you can separately configure enums and lists: `enum-config`, `list-config`
  - Horizontal spacing settings: `indent`, `body-indent`, `label-indent`, `enum-margin` (`is-full-width`)
  - Vertical spacing settings: `item-spacing`, `enum-spacing`
  - Label customization
    - `text-style` (..args)
    - [N] `label-align`
    - [N] `label-baseline`
    - [N] `label-format`
    - [N] `label-width`
  - [N] Label alignment between items at different levels: `auto-label-width`
  - `auto-base-level`
    - [!]  *Breaking change*: When configuring enums and lists using `*-enum-list`, `*-enum`, or `*-list`, the current level is treated as 1
      - Version 0.1.x used absolute levels
    - To maintain compatibility with native behavior, the display of numbering and markers still follows absolute levels. Even if you reconfigure `enum.numbering` and `list.marker` in sublists, their display adheres to absolute level rules
      - In this case, `auto-base-level` is set to `true`, treating the current level as 1

  - Body formatting: `hanging-indent`, `line-indent`
    - [N] `body-format`:
      - `text-style`: `style`
      - Border settings: `outer`, `inner`, `whole`: (`stroke`, `radius`, `outset`, `fill`, `inset`)
    - [<] Experimental: `item-format`
- Enum numbering references: `elabel` and `config.ref`
  - [!] The `ref-enum` method from ver0.1.x will be deprecated in the future. Please use `config.ref` for configuration
- Resume enum (#link("https://github.com/tianyi-smile/itemize/issues/1", [`issue#1`]))
  - [N] `auto-resuming`
    - `none`: Disable resume functionality
    - `auto`: Using the following methods:
      - `resume`
      - `resume-label`, `resume-list`
      - `auto-resume-enum`
      - `isolated-resume-enum` (independent sublists)
    - Globally use `true` or `(true, false)` etc. to enable functionality; `false` means the functionality does not apply to this level

- List enhancements
  - Enhanced `list.marker`: Allows passing a `function` parameter in the form of `level => n => content` or `level => array`
  - [N] Terms-like functionality: `item`
  - [N] Checklist (from the `cheq` package, with minor enhancements and fixes for compatibility with `itemize`)
    - Configure using `config.checklist`
- Add manual
- Fixes
  - Alignment of labels and bodies
  - [N] Block-level elements displayed on the same line (#link("https://github.com/tianyi-smile/itemize/issues/4", [`issue#4`]))
    - Now better handles blank content in typst, ensuring correct alignment, e.g.,
      #example(
        ```
        #show: el.default-enum-list
        + #state("").update(none)
          + 111
        ```,
      )
      is now correctly processed
    - Due to limitations in typst, content within `context` cannot be retrieved in pure typst, making it impossible to correctly process cases like:
      #example(
        ```
        #show: el.default-enum-list
        + #context {block[#text.fill]}
        ```,
      )
      - Temporary solution: Use `layout(_ => {...})` instead of `context {...}`, e.g.,
        #example(
          ```
          #show: el.default-enum-list
          + #layout(_ => {block[#text.fill]})
          ```,
        )
    - Similarly, output content in `ref(...)` cannot be processed
    - For block-level elements, our handling is more refined compared to native behavior:
      - If a block-level element behaves like a paragraph (`par`, `pad`, `block`, `repeat`, `layout`), it is treated as paragraph behavior, ensuring alignment of labels and bodies within the same paragraph
      - If it is not a paragraph (`block-equation`, `block-raw` `rect`, `table`, `grid`, `stack`, `heading`, `figure`, etc.), it follows native behavior
      - [?] `align` here is paragraph behavior but cannot be correctly implemented (currently follows native behavior)
  - Resolved some cases where "layout did not converge within 5 attempts" occurred
    - However, this may lead to "maximum show rule depth exceeded" when nesting levels increase
    - Mainly occurs with complex configurations of `label-format` and `body-format`
  - Other fixes:
    - [S] Support for `enum.start`
    - [!] *Breaking change*: For compatibility with the native `list.marker` behavior, unlike the methods provided by `itemize`, the level here starts from 0 (see #link("https://github.com/tianyi-smile/itemize/issues/3", [`issue#3`])).
    - [x] Fixed: Incorrect label display when mixing enums and lists with `*-enum` and `*-list` configurations
      - Now, we rewrite all the behaviors of `enum` and `list`, but `*-enum` does not configure list formatting, and vice versa
    - [x] Compatibility with typst 0.14 behavior (`[#6609]` and `[#6242]`)


// = Example
