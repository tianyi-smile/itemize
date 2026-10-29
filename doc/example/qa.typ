#set page(height: auto, margin: 15pt, width: 12cm)

#import "../../lib.typ" as el

#let qa(body) = {
  let ask-badge = box(
    width: 1.8em,
    height: 1.8em,
    radius: 2pt,
    fill: rgb("#8a4b4b"),
    stroke: .5pt + rgb("#8a4b4b"),
    inset: 5pt,
  )[
    #align(center + horizon)[
      #text(
        fill: rgb(20, 15, 15),
        weight: "bold",
        size: 18pt,
      )[问]
    ]
  ]
  show: el.default-list.with(
    body-format: (
      whole: (
        fill: (rgb(20, 15, 15).lighten(6%), auto),
        inset: (10pt, auto),
      ),
      outer: (
        stroke: ((bottom: 0.5pt + rgb("#5a2626").lighten(5%)), auto),
        inset: ((bottom: 10pt), auto),
      ),
      style: (fill: rgb(220, 210, 210)),
    ),
    label-format: (ask-badge, auto),
    label-baseline: ("center", auto),
    description-config: (
      style: "stacked",
      term-format: (text.with(fill: rgb(180, 100, 100)), auto),
    ),
  )
  body
}

#qa[
  - / 如何第一时间了解《黑神话：钟馗》的最新消息？: 每年的8月20日，游戏科学都会例行给大家汇报最新的工作进度。所以最简单的办法，就是在820当天瞅瞅B站、抖音、快手、微博、小红书、微信视频号等社媒的【黑神话】官号动态，然后顺手点个关注。
  - / 作为黑神话系列的第二作，《黑神话：钟馗》与《黑神话：悟空》会有哪些异同？: 首先，从名字就能看出，《黑神话：钟馗》依然取材于中国的古代神话与民间传说。其次，它依然是一款标准的单机·动作·角色扮演游戏，商业模式与前作别无二致。再次，从最新的实机演示中大家或许能感受到：一方面，我们希望保留黑神话前作广受认可的诸多乐趣；另一方面，也乐于探索契合新主角的特色玩法、前沿的技术特性与差异化的叙事方式。特别提醒：提前公布的宣传视频难免与最终发售内容存在一定差别，有些探索目前仍是实验性的尝试，如果不是因为每年都得硬着头皮出来献艺……
  - / 能再多透露点《黑神话：钟馗》的剧情和玩法吗？: 透不了，真透不了。很多玩家对视频解读的角度之刁、考据之细、脑洞之大，已远远超出开发团队自己对项目的理解，学习都来不及。
  - / 《黑神话：钟馗》将登陆哪些平台？: PC+主流主机平台，正式信息请以发售前通知为准。
  - / 《黑神话：钟馗》大概什么时候发售？: 尽量快！但考虑到综合品质必须先打动内部见多识广的同事们，那就一定快不起来，嘻嘻。
]
