#set page(height: auto, margin: 15pt, width: 12cm)

#import "../../lib.typ" as el

#show: el.default-enum-list
#show: el.config.ref.with(full: "rel")
#set enum(numbering: "1.a.i.")
#show link: set text(fill: orange)
+ #lorem(5) <p:a>
  + #lorem(5) <p:b>
  + #lorem(5)
    + #lorem(5) <p:c>
    + #lorem(5) Rel-ref: @p:a, @p:b and @p:c
  + #lorem(5) Rel-ref: @p:a, @p:b and @p:c
    + #lorem(5) Rel-ref: @p:a, @p:b and @p:c
  #lorem(10)
  + Rel-ref: @p:a, @p:b and @p:c
+ #lorem(5) Rel-ref: @p:a, @p:b and @p:c
  + Rel-ref: @p:a, @p:b and @p:c
Paragraph
+ #lorem(5) Rel-ref: @p:a, @p:b and @p:c
+ #lorem(5)
