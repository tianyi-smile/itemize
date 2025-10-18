#import "../lib.typ" as el
#set page(height: auto, margin: 35pt)

#let test = [
  + #lorem(10)

    #lorem(10)
    + #lorem(10)

      #lorem(10)
    + #lorem(10)
  + #lorem(10)
  - #lorem(10)
    - #lorem(10)
  + - + - #lorem(10)
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
    #show: el.default-enum-list.with(auto-base-level: true)
    #test
  ],
  [
    #set enum(numbering: "(A).(I).(i)")
    #show: el.paragraph-enum-list.with(auto-base-level: true)
    #test
  ],
)
