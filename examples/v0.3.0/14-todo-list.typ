#import "../../lib.typ" as el

#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  it
}

#set page(height: auto, margin: 2em, width: 12cm)

#[
  = Todo list with custom SVG markers
  // See Michelle Barker https://codepen.io/michellebarker/pen/jOzOqNg

  #let marker0 = ```
  <svg xmlns="http://www.w3.org/2000/svg" xml:space='preserve' width="14" height="14" viewBox="0 0 50 50">
  <path d='M48.3 23.7c-1-9.9-9.9-15.6-18.9-17.8-8.2-2.1-18.8-2.6-24.6 4.8C.6 16.2 1 23.6 4.3 29.3c-.5 1-.8 2-1 3-.6 4 2 7.6 5.1 10 5.9 4.4 14 4.2 19.6-.4 1.5 0 2.9-.2 4.4-.5 1.8 0 3.5 0 5.3-.1 2.3-.1 3.5-1.9 3.5-3.7 4.5-3.3 7.7-8.2 7.1-13.9zM9.1 17.8c1.1-4.1 4.9-5.8 8.8-6.1.9-.1 1.9-.1 2.9-.1-3.2 1.6-6.3 4.6-8 7.4-.1.1-.1.2-.2.3-1.1.9-2.1 1.9-3 2.9-.2.2-.4.4-.5.6-.4-1.7-.5-3.3 0-3z' fill="#000" fill-rule="evenodd"></path>
  </svg>
  ```
  #let marker1 = ```
  <svg xmlns="http://www.w3.org/2000/svg" xml:space='preserve' width="14" height="14" viewBox="0 0 50 50">
  <path d='M46.5 12.5c-.4-1.1-1.3-1.8-2.2-2-4.2-4-11.6-4.3-17.1-4.1-6.9.3-13.9 2.1-19.4 6.5C2 17.5-2.4 25.7 2.5 32.6c2.2 3.2 5.5 4.9 9 5.5 3.3 1.7 6.7 3.3 10.2 4.4 7.8 2.3 17 1.6 23.2-4.3 7.3-7 4.8-17.3 1.6-25.7zm-20.2 2.7c.6 0 1.3 0 1.8.2 1.1.4 1.7 1.3 2 2.3-1-1.2-2.4-2.1-3.8-2.5zm-1.4 6.6c.9.9 1.3 2.2-.2 2.3-2 .2-1.1-1.9.2-2.3zm-11.8 9.8c-.6-.3-2.9-1.1-3.2-1.8-.2-.5 1.4-3.1 2.1-4.2.3.5.7 1 1.2 1.4 0 .3.1.6.2.8.5 1.9 1.5 3.1 2.9 4h-.2c-.8.1-1.6.1-2.5-.1-.2 0-.3 0-.5-.1zM24 36.4c1.6-.7 3-1.5 4.3-2.5.8.2 1.7.3 2.5.5 2.5.4 5.2.9 7.7.6-.9.6-2 1.1-3 1.4-3.9 1.3-7.7 1-11.5 5z' fill="#000" fill-rule="evenodd"></path>
  </svg>
  ```
  #let marker2 = ```
  <svg xmlns="http://www.w3.org/2000/svg" xml:space='preserve' width="14" height="14" viewBox="0 0 50 50">
  <path d='M46.4 16.2c-2.3-2.3-5.4-3.5-8.4-4.5-.5-.2-1.1-.3-1.6-.5-1.6-1.6-3.7-2.8-6.2-3.2-1-.2-1.9.1-2.5.6-.9-.3-1.8-.6-2.7-.8-3.2-1-6.4-1.8-9.5-.1-1 .5-1.9 1.2-2.7 2-6.4 1.4-11.7 5-12.4 12.7C0 27 1.9 31.5 4.9 34.9c.1.6.2 1.1.4 1.7 1 3.2 3.3 5.7 6.7 6.5 2.7.6 5.4-.2 7.9-1.2 3.3.4 6.7.3 9.9 0 6.5-.7 13.3-2.8 17.1-8.5 3.6-5.2 4-12.6-.5-17.2zm-17.3.9c2.1.4 4 1.7 4.7 3.8 0 .5-.1 1.1-.2 1.6-.3 1.4-.8 2.6-1.6 3.7-.7.2-1.5.1-2.3-.4-.8-.4-1.6-1-2.2-1.6-.4-.4-1.2-1.7-1.6-1.9 3.4 1.3 5.1-3 3.2-5.2zm-11.6 9.7c.2-1.9 1.1-3.9 2.3-5.5-.4 2.1.3 4.2 1.7 6 1.3 1.7 3.1 3.2 5 4.2-.2.1-.4.2-.6.4-.1 0-.1.1-.2.1-3.9.2-8.7-.8-8.2-5.2zm-6.4 3.1c.1.3.1.7.2 1 .2.6.4 1.2.7 1.8-.4-.2-.7-.5-1-.7.1-.8.1-1.4.1-2.1zm31.2-1.3c-.9 1.7-2.1 3.1-3.7 4.1 2-2.1 3.4-4.7 4-7.6.2-.7.3-1.4.3-2.1.6 1.5.5 3.3-.6 5.6z' fill="#000" fill-rule="evenodd"></path>
  </svg>
  ```
  #let marker = level => {
    if level == 0 {
      ([#image(bytes(marker0.text))], [#image(bytes(marker1.text))], [#image(bytes(marker2.text))], el.LOOP)
    } else {
      ([•], [‣], [–]).at(calc.rem-euclid(level - 1, 3))
    }
  }

  #import "@preview/shadowed:0.4.0": shadow
  #let todo-list = el.default-enum-list.with(
    label-baseline: "center",
    body-format: (
      whole: (inset: ((y: 10pt), auto)),
      outer: (
        stroke: ((0pt, (top: 1pt + blue)), auto),
        inset: (
          (
            (right: 12pt),
            (top: 10pt, right: 12pt),
          ),
          auto,
        ),
      ),
    ),
    item-spacing: (10pt, auto),
    label-indent: (12pt, auto),
  )

  #set list(marker: marker)
  #let shadowed(body) = shadow(
    blur: 10pt,
    fill: rgb(89, 85, 101, 25%),
    radius: 4pt,
    block(
      fill: white,
      radius: 5pt,
      body,
    ),
  )
  #todo-list[
    #set par(justify: true)
    #shadowed()[
      - Bread

        #lorem(15)
      - Milk
        + #lorem(5)
        + #lorem(5)
      - Eggs
        - #lorem(5)
        - #lorem(5)
      - Sugar

    ]
  ]
]
