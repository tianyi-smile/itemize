#import "../lib.typ" as el
#set page(height: auto, margin: 35pt)

#show: el.config.ref-resume
#let auto-resume = el.default-enum-list.with(auto-resuming: auto)
#auto-resume[
  + #lorem(5)
    + #lorem(5)
    + #lorem(5)
    - #lorem(5)
    #el.resume() // continue
    + #lorem(5) #el.resume-label(<resume:demo>)
  #lorem(5)
  @resume:demo // resume the enum labelled with `resume:demo`
  + #lorem(5)
]
