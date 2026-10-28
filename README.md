## Overview


The `itemize` package allows users to easily customize `enum` and `list` for Typst. To use this package, include the following at the beginning of your document:

```typst
#import "@preview/itemize:0.3.0" as el
```

Use the method `default-enum-list` to override the native behaviour of `enum` and `list` by adding the following at the beginning of your document:

```typst
#show: el.default-enum-list
```

to apply all `enum` and `list` in your document. Or use
```typst
#el.default-enum-list()[
  /* content */
]
```
to only apply the `enum` and `list` in `/* content */`.

Now you can use `enum` and `list` as usual. `itemize` revises some default behaviors of `enum` and `list` (of Typst 0.15.1):

- Labels on the same line are now aligned with the list;
- If the label has no baseline, bottom alignment is used by default (which better fits common usage).

Below is a comparison.

![comparison](asserts/native.svg)

<details>
<summary>Code:</summary>

```typst
#set page(height: auto, margin: 15pt, width: 12cm)
#import "@preview/itemize:0.3.0" as el
#let test = [
  + + $vec(1, 1, 1)$ #lorem(2)
  #set list(marker: circle(width: 2em))
  - #lorem(2)
]
#table(
  columns: (1fr, 1fr),
  table.header([*Native*], [*Itemize*]),
  [#test],
  [
    #show: el.default-enum-list
    #test
  ],
)
```

</details>

- `itemize` currently does not support exporting to HTML format (see https://github.com/tianyi-smile/itemize/issues/18).
- `itemize:0.3.0` requires at least Typst 0.15.1.
- See [manual.pdf](doc/manual/manual.pdf) and also the source code [manual.typ](doc/manual/manual.typ) for more details. The manual contains the API reference and examples.
- See [changelog.md](changelog/changelog.md) for the changes and new features for version 0.3.0.
 
### Examples

<table>
<!----->
<tr>
  <td>  
      <a href="examples/v0.3.0/04-aligned-lists.typ">
      <img src="examples/v0.3.0/04-aligned-lists.svg" width="250px", alt="aligned lists">
      </a>
  </td>
  <td>
      <a href="examples/v0.3.0/05-resumed-numbering.typ">
      <img src="examples/v0.3.0/05-resumed-numbering.svg" width="250px", alt="resumed numbering list">
      </a>
  </td>
  <td>
      <a href="examples/v0.3.0/20-memorandum.typ">
      <img src="examples/v0.3.0/20-memorandum.svg" width="250px", alt="memorandum">
      </a>
  </td>
</tr>
<!----->
<tr>
  <td>  
      <a href="examples/v0.3.0/01-numbered-counter-badges.typ">
      <img src="examples/v0.3.0/01-numbered-counter-badges.svg" width="250px", alt="numbered counter badges">
      </a>
  </td>
  <td>
      <a href="examples/v0.3.0/02-checklist-colored-badges.typ">
      <img src="examples/v0.3.0/02-checklist-colored-badges.svg" width="250px", alt="checklist colored badges">
      </a>
  </td>
  <td>
      <a href="examples/v0.3.0/03-pinned-labels-references.typ">
      <img src="examples/v0.3.0/03-pinned-labels-references.svg" width="250px", alt="pinned labels with references">
      </a>
  </td>
<tr>
<!----->
<tr>
  <td>
      <a href="examples/v0.3.0/06-simple-tree.typ">
      <img src="examples/v0.3.0/06-simple-tree.svg" width="250px", alt="simple tree list">
      </a>
  </td>
  <td>
      <a href="examples/v0.3.0/16-pseudocode-listing.typ">
      <img src="examples/v0.3.0/16-pseudocode-listing.svg" width="250px", alt="pseudocode listing">
      </a>
  </td>
  <td>  
      <a href="examples/v0.3.0/07-colorful-tree.typ">
      <img src="examples/v0.3.0/07-colorful-tree.svg" width="250px", alt="colorful tree list">
      </a>
  </td>
<tr>
<!----->
<tr>
  <td>
      <a href="examples/v0.3.0/09-cards-inner-border.typ">
      <img src="examples/v0.3.0/09-cards-inner-border.svg" width="250px", alt="cards with inner border">
      </a>
  </td>
  <td>  
      <a href="examples/v0.3.0/10-cards-outer-border.typ">
      <img src="examples/v0.3.0/10-cards-outer-border.svg" width="250px", alt="cards with outer border">
      </a>
  </td>
  <td>  
      <a href="examples/v0.3.0/11-cards-gradient-shadow.typ">
      <img src="examples/v0.3.0/11-cards-gradient-shadow.svg" width="250px", alt="cards with gradient and shadow">
      </a>
  </td>
<tr>
<!----->
<tr>
  <td>
      <a href="examples/v0.3.0/15-circle-numbered-list.typ">
      <img src="examples/v0.3.0/15-circle-numbered-list.svg" width="250px", alt="circle numbered list">
      </a>
  </td>
  <td>
      <a href="examples/v0.3.0/12-cards-nested-filled.typ">
      <img src="examples/v0.3.0/12-cards-nested-filled.svg" width="250px", alt="cards with nested filled">
      </a>
  </td>
  <td>
      <a href="examples/v0.3.0/13-cards-vertical-accent.typ">
      <img src="examples/v0.3.0/13-cards-vertical-accent.svg" width="250px", alt="cards with vertical accent">
      </a>
  </td>
</tr>
<!----->
<tr>
  <td>
      <a href="examples/v0.3.0/08-cards-left-accent-border.typ">
      <img src="examples/v0.3.0/08-cards-left-accent-border.svg" width="250px", alt="cards wiht left accent border">
      </a>
  </td>
  <td>  
      <a href="examples/v0.3.0/14-todo-list.typ">
      <img src="examples/v0.3.0/14-todo-list.svg" width="250px", alt="todo list">
      </a>
  </td>
  <td>
      <a href="examples/v0.3.0/17-disclosure-tree.typ">
      <img src="examples/v0.3.0/17-disclosure-tree.svg" width="250px", alt="disclosure tree">
      </a>
  </td>
</tr>
<!---->
<tr>
  <td>  
      <a href="examples/v0.3.0/18-timeline.typ">
      <img src="examples/v0.3.0/18-timeline.svg" width="250px", alt="timeline">
      </a>
  </td>
  <td>
      <a href="examples/v0.3.0/19-editorial-cards.typ">
      <img src="examples/v0.3.0/19-editorial-cards.svg" width="250px", alt="editorial cards">
      </a>
  </td>
  <td>
      <a href="examples/v0.3.0/21-leaderboard.typ">
      <img src="examples/v0.3.0/21-leaderboard.svg" width="250px", alt="leaderboard">
      </a>
  </td>
</tr>
</table>



*Click on the example image to jump to the code.*


## Override `enum` and `list`

The `itemize` package primarily provides the following methods to override the native `enum` and `list`:

- `default`-style (Typst's native style): `default-enum-list`, `default-enum`, `default-list`.
- `paragraph`-style: `paragraph-enum-list`, `paragraph-enum`, `paragraph-list`.
  - This is equivalent to using `default-enum-list.with(hanging-type: "paragraph")`.
- `inline`-style: `inline-enum-list`, `inline-enum`, `inline-list`.
  - Any `block-level` elements appearing in the item body are laid out flush left.
  - Contents at every level of the list span the full width of the parent container.
  - Because of this paragraph behavior, some features of `default-enum-list` (`default-enum`, `default-list`) no longer take effect (`label-baseline`, `border` of `body-format`, `body-margin`, `auto-label-width`, and `auto-resuming`).

By default, the `default-*` methods indent paragraphs after the item label, while the `paragraph-*` methods align paragraphs with the item label.
`inline-*` methods interpret the list content as paragraphs.

See the example below:

<a href="asserts/styles-el.typ">
<img src="asserts/styles-el.svg" width="550px", alt="Different styles of lists">
</a>

<details>
<summary>Code:</summary>

```typst
#import "@preview/itemize:0.3.0" as el
#set page(height: auto, margin: 35pt)

#[
  #let test = [
    + #lorem(8)

      #lorem(8)
      + #lorem(8)

        #lorem(8)
      + #lorem(8)
    + #lorem(8)
    - #lorem(8)
      - #lorem(8)
    + - + - #lorem(8)
  ]
  #table(
    columns: (1fr, 1fr),
    [
      default-style
      ```typ
      #set enum(numbering: "(A).(I).(i)")
      #show: el.default-enum-list
      ```
    ],
    [
      paragraph-style
      ```typ
      #set enum(numbering: "(A).(I).(i)")
      #show: el.paragraph-enum-list
      ```
    ],

    [
      #set enum(numbering: "(A).(I).(i)")
      #show: el.default-enum-list
      #test
    ],
    [
      #set enum(numbering: "(A).(I).(i)")
      #show: el.paragraph-enum-list
      #test
    ],
  )
]

#[
  #let test = [
    #set block(stroke: red) // debug
    #lorem(8)
    $
      a^2 + b^2 = c^2
    $
    + #lorem(8)
      $
        a^2 + b^2 = c^2
      $
      #lorem(8)
      + #lorem(8)

        #lorem(8)
      + #lorem(8)
        #block[*Block:* #lorem(8)]
    + #lorem(8)
    - #lorem(8)
      - #lorem(8)
    + - + - #lorem(8)
  ]
  #table(
    columns: (1fr, 1fr),
    [
      default-inline
      ```typ
      #set enum(numbering: "(A).(I).(i)")
      #show: el.inline-enum-list
      ```
    ],
    [
      paragraph-inline
      ```typ
      #set enum(numbering: "(A).(I).(i)")
      #show: el.inline-enum-list.with(hanging-type: "paragraph")
      ```
    ],

    [
      #set enum(numbering: "(A).(I).(i)")
      #show: el.inline-enum-list
      #test
    ],
    [
      #set enum(numbering: "(A).(I).(i)")
      #show: el.inline-enum-list.with(hanging-type: "paragraph")
      #test
    ],
  )
]
```

</details>

## Model

The diagram below illustrates the model for `enum` and `list` in `itemize`.
- `enum` and `list` consist of multiple items.
- Each item is composed of a `label` and a `body`:
  - `label` (`item label`): The enum number or list marker
    - Also, including the spacings: `label-indent`, `body-indent`.
  - `body` (`item body`): The content following the label.
- Level (`level`): Starts from 1, and increments if an item contains nested items.
- Item index (`n`): Starts from 1. The index of items in the same level.

Now (since version 0.3.0), each of the `default-*`, `paragraph-*`, and `inline-*` methods will have a separately maintained level counter. When the method is used, its level will start counting from 1 again. If you want to use the level counting from `itemize 0.2.0` (where a single level counter is maintained throughout the entire document), you need to set the parameter `auto-base-level` to `false`.

<a href="asserts/model.typ">
<img src="asserts/model.svg" width="550px", alt="Model">
</a>

<details>
<summary>Code Example:</summary>

```typst
#set page(height: auto, margin: 15pt, width: 12cm)
#import "@preview/itemize:0.3.0" as el
#set par(justify: true)
#set align(left)
#show: el.default-enum-list.with(
  indent: 1em,
  label-align: right,
  label-width: 3em,
  label-format: (stroke: red),
  body-indent: 1em,
  hanging-indent: 2em,
  line-indent: 4em,
  body-margin: (right: 1em),
  whole-spacing: 2.5em,
  item-spacing: 2em,
  body-format: (
    whole: (stroke: blue, inset: 5pt),
    inner: (stroke: green, inset: 2pt),
  )
)
Preceding Text. #lorem(10)
1. Item 1: Paragraph 1. #lorem(10)

  Paragraph 2. #lorem(10)

100. Item 2. #lorem(10)
Following Text. #lorem(10)
```

Output:

![Model Example Code](asserts/model-code.svg)

</details>

## Features

Using `itemize`, you can customize the _labels_ and _bodies_ of `enum` and `list` for each *level* and each *item*.

> *Click on the example image to jump to the code.*

### Support for styling by level and item
  - Most parameters support being set per level and per item, which is achieved by passing an `array` or a `function`. In the API Reference, these are marked as `array` (level-property) and `function` (level-property).
  - `array` (level-property): Each element of the `array` sets the style of the item at the corresponding level; that is, the value at array index `l` sets the style of the item at level `l + 1`.
    - If the last element of the array is `LOOP`, the values in the array will be used cyclically;
    - otherwise, the last element's value applies to subsequent levels.
  - `function` (level-property): If it is a `function`, its form is `it => value`, where `value` is one of the values allowed by the parameter (in most cases).
    - You can usually access the relevant values provided by `itemize` through the keys available on `it`, for example:
      - `it.level`: The level of the item, starting from 1.
      - `it.n-last`: The index of the last item in the current level.
      - `it.e`: The field of the current construct element (`enum`, `list`), but excluding the `children`.
      - `it.n`: The index of the item, starting from 1.
      
      ... (For more accessible values, see the API Reference)

  For example: the `fill` parameter sets the style of the item label.
  
  <a href="doc/example/level-array-arg.typ">
    <img src="doc/example/level-array-arg.svg" width="550px", alt="level array arg">
  </a>
  <a href="doc/example/level-func-arg.typ">
    <img src="doc/example/level-func-arg.svg" width="550px", alt="level func arg">
  </a>
  <a href="doc/example/level-func-e.typ">
    <img src="doc/example/level-func-e.svg" width="550px", alt="level func with keys">
  </a>

### Separating setting of `enum` and `list`
  - Set the styles of `enum` and `list` separately through the parameters `enum-config` and `list-config`.
  - Also, use `*-enum` and `*-list` methods to set the styles of `enum` and `list` separately.

### Individual setting
  - Set the style for the current item separately through the `item` method.
  - Use `item` to set `tag` and `elem-tag` attributes, then format items or lists with these attributes.

It must be placed between the label and the body, for example:
```typst
+ #el.item(...) body
```

<a href="doc/example/item-for-elem.typ">
  <img src="doc/example/item-for-elem.svg" width="550px", alt="item with for-elem arg">
</a>
<a href="doc/example/item-tag.typ">
  <img src="doc/example/item-tag.svg" width="550px", alt="item with elem-tag arg">
</a>
<a href="doc/example/tag.typ">
  <img src="doc/example/tag.svg" width="550px", alt="item with tag arg">
</a>

### Different styles of description list
  - Checklist: Enable through the parameter `checklist`, and configure through the method `config:checklist`.
    - Using the syntax `- [ ] body`

<a href="doc/example/checklist.typ">
<img src="doc/example/checklist.svg" width="550px", alt="checklist">
</a>
<a href="doc/example/checklist-symbol-map.typ">
  <img src="doc/example/checklist-symbol-map.svg" width="550px", alt="checklist with symbol-map">
</a>

  - Terms-like description list: Change the item label of the current item (`enum` or `list`) using the `item` method.
    - Using the syntax `- #el.item([..]) body` and `+ #el.item([..]) body`

<a href="doc/example/item-marker.typ">
<img src="doc/example/item-marker.svg" width="550px", alt="terms-like list">
</a>
<a href="doc/example/item-number.typ">
  <img src="doc/example/item-number.svg" width="550px", alt="terms-like enum">
</a> 

  - Horizontal description list, hanging description list, stacked description list, plain description list:
    - Using the syntax `+ / term: description` and `- / term: description`
    - Configure through the argument `description-config`.

<a href="doc/example/description.typ">
  <img src="doc/example/description.svg" width="550px", alt="different styles of description lists">
</a> 

  - Checklist description list
    - *Note*: In order to enable checklist style, the `checklist` in `default-*` (or `paragraph-*`) must be `true`.

<a href="doc/example/description-checklist.typ">
  <img src="doc/example/description-checklist.svg" width="550px", alt="checklist description list">
</a>   

### Item label formatting

  - Setting the _text style_ of item label: `..args`
  - Label alignment: `label-align`
  - Horizontal movement of the label: `label-inset`
  - Vertical movement of the label: `label-baseline`

<a href="doc/example/label-baseline-size.typ">
  <img src="doc/example/label-baseline-size.svg" width="550px", alt="center label-baseline">
</a>   

  - Setting the label width: `label-width`
    - Allow different `enum` and `list` to share the maximum label width: `auto-label-width`
  
<a href="doc/example/label-width-default.typ">
  <img src="doc/example/label-width-default.svg" width="550px", alt="label-baseline with default style">
</a>   
<a href="doc/example/auto-label-1.typ">
  <img src="doc/example/auto-label-1.svg" width="550px", alt="share the maximum label width">
</a> 


  - Formatting the label in any way: `label-format`
    - Support setting the _border_ of the label.

<a href="doc/example/label-format.typ">
  <img src="doc/example/label-format.svg" width="550px", alt="label-format">
</a> 


  - Setting the step size for `enum` numbers: `step`

<a href="doc/example/step.typ">
  <img src="doc/example/step.svg" width="550px", alt="step size">
</a> 

### Item body formatting
  - Formatting the body in any way (_text style_, `border`, etc): `body-format`
  
<a href="doc/example/body-format-style.typ">
  <img src="doc/example/body-format-style.svg" width="550px", alt="body-format for text style">
</a> 
<a href="doc/example/body-format-inner-green.typ">
  <img src="doc/example/body-format-inner-green.svg" width="550px", alt="body-format for border">
</a> 
<a href="doc/example/body-format-nested.typ">
  <img src="doc/example/body-format-nested.svg" width="550px", alt="body-format example">
</a> 

### Horizontal spacing setting
  - The indentation of the item: `indent`
  - The indentation for the label: `label-indent`
  - The indentation between the item label and the item body: `body-indent`
  - The item body margin: `body-margin`

1. The body of all nested lists is aligned to the left.

<a href="doc/example/body-margin-left-align.typ">
  <img src="doc/example/body-margin-left-align.svg" width="550px", alt="The body of all nested lists is aligned to the left">
</a> 

2. Align the (first-level) item body and the first line of the paragraph, e.g., indent both by 2em.

<a href="doc/example/body-margin-align-par.typ">
  <img src="doc/example/body-margin-align-par.svg" width="550px", alt="Align the (first-level) item body and the first line of the paragraph">
</a> 

3. Align the (first level) item body and the first line of the paragraph with the `paragraph` hanging style.

<a href="doc/example/body-margin-align-par-hanging.typ">
  <img src="doc/example/body-margin-align-par-hanging.svg" width="550px", alt="Align the (first level) item body and the first line of the paragraph with the `paragraph` hanging style">
</a> 

### Vertical spacing setting
  - The above and below spacing of whole `enum` or `list`: `whole-spacing`
    - Different compact modes: `tight-mode`
  
<a href="doc/example/tight-config.typ">
  <img src="doc/example/tight-config.svg" width="550px", alt="tight-mode config">
</a> 

  - The above and below spacing of each item: `item-spacing`
    - Different compact modes: `tight-item-mode`

<a href="doc/example/item-spacing-below.typ">
  <img src="doc/example/item-spacing-below.svg" width="550px", alt="item-spacing">
</a> 


### Referencing `enum` number and item label

To enable this feature, use the method `config:ref` like the following at the beginning of the document:

```typst
#show: el.config.ref
```

> Usage: 
> - In the enum item you want to reference, label it with `<some-label>`, and then use `@<some-label>` to reference the enum number of that item.
> - If the enum number cannot be retrieved correctly, use the method `elabel` to label the enum item.
  
<a href="doc/example/ref-enum-number.typ">
  <img src="doc/example/ref-enum-number.svg" width="550px", alt="referencing enum number">
</a>   

  - Support relative form references
  
<a href="doc/example/rel-ref.typ">
  <img src="doc/example/rel-ref.svg" width="550px", alt="relative form reference">
</a> 
  
  - Allow using `ref-numbering` and `supplement` to set citation styles for different `enum`s

<a href="doc/example/ref-theorem.typ">
  <img src="doc/example/ref-theorem.svg" width="550px", alt="ref-theorem">
</a>   
  
  - Support referencing item labels for `enum` and `list`.

<a href="doc/example/list-ref.typ">
  <img src="doc/example/list-ref.svg" width="550px", alt="list-ref">
</a>   
<a href="doc/example/ref-item-args.typ">
  <img src="doc/example/ref-item-args.svg" width="550px", alt="enum-ref">
</a>   

### Resuming `enum` number
Enable through the parameter `auto-resuming`, and use in conjunction with the methods `resume`, `resume-label`, `resume-list`, `auto-resume-enum`.

- Set `auto-resuming` to `auto`. Then you can use the following methods:
1. `resume` is to continue using the enum numbers from the previous enum at the same level.

<a href="doc/example/resume-level.typ">
  <img src="doc/example/resume-level.svg" width="550px", alt="resuming enum with resume method">
</a>   

2. Use the method `resume-label` to label the enum you want to resume, and then use `resume-list` in the desired enum to continue using the labelled enum numbers.

<a href="doc/example/resume-label.typ">
  <img src="doc/example/resume-label.svg" width="550px", alt="resuming enum with resume-list method">
</a>  

3. Use the method `auto-resume-enum[..]` and the `enum` numbers in `[..]` will continue from the previous ones.

<a href="doc/example/auto-resume-enum.typ">
  <img src="doc/example/auto-resume-enum.svg" width="550px", alt="resuming enum with auto-resume-enum method">
</a>

- If `auto-resuming` is set to `true`, then all enum numbers will continue from the previous ones.


### Body paragraph setting
  - The indentation of the first line for first paragraph in item body: `first-line-inset`
  - The line indentation  for paragraphs in item body: `line-indent`
  - The hanging indentation for paragraphs in item body: `hanging-indent`
      - **Note**: Paragraphs inside `block-level` elements that appear in the item body are not processed.

## Acknowledge

- [@pacaunt](https://github.com/typst/typst/issues/1204#issuecomment-2909417340)
- [@Andrew](https://forum.typst.app/t/can-i-use-show-rule-only-in-content-of-enum-but-not-numbering/4590/2)
- [cheq](https://typst.app/universe/package/cheq)
- [@cady-b](https://github.com/tianyi-smile/itemize/issues/9)

## License

This project is licensed under the MIT License.
