#set page(height: auto, margin: 15pt, width: 12cm)

#import "../../lib.typ" as el

#show: el.default-enum-list
- 3333333
+ 33333
+ 33333
  #[
    + 3333333
    #show: el.default-enum-list.with(auto-resuming: true)
    // #show: el.default-enum-list.with(auto-resuming: it => {})
    // #show: el.default-enum-list.with(auto-resuming: true)
    + Item one
    + Item two
      + Sub item one
      + Sub item Two #el.resume-label(<resume:sub>)
      + 33333
      + 2222
      + 222
      + 11111
    + 11111111
    Paragraph
    #el.resume()
    + New Item // resume
      + 222222
    + #el.isolated-resume-enum()[
      + $vec(1,1,1)$ 11111
        + 333
        + 2222222
      + 3333
    ]
    + 33333
      #[
        #show: el.default-enum-list.with(fill: red)
        + 33333
        + 2222
      ]
    + 333333
      + 2222222
  ]
- 333333
  + 1111111
    + 333333333
    + 3333
    #[
      #show: el.default-enum-list.with(auto-resuming: true)
      + + Item one
      + Item two
        + Sub item one
        + Sub item Two // The enum you want to resume
        + 111111
        + 3333
      Paragraph
      #el.resume-list(<resume:sub>)
      #el.resume()
      + New Item // resume
        #el.resume-list(<resume:sub>)
        + 222222
    ]

- 333

