// some handly functions
#let equation_num(_) = {
  locate(loc => {
    let chapt = counter(heading).at(loc).at(0)
    let c = counter("equation-chapter" + str(chapt))
    let n = c.at(loc).at(0)
    "(" + str(chapt) + "-" + str(n + 1) + ")"
  })
}

#let table_num(_) = {
  locate(loc => {
    let chapt = counter(heading).at(loc).at(0)
    let c = counter("table-chapter" + str(chapt))
    let n = c.at(loc).at(0)
    str(chapt) + "-" + str(n + 1)
  })
}

#let image_num(_) = {
  locate(loc => {
    let chapt = counter(heading).at(loc).at(0)
    let c = counter("image-chapter" + str(chapt))
    let n = c.at(loc).at(0)
    str(chapt) + "-" + str(n + 1)
  })
}


#let equation(equation, caption: "") = {
  figure(
    equation,
    caption: caption,
    supplement: [公式],
    numbering: equation_num,
    kind: "equation",
  )
}

#let tbl(tbl, caption: "") = {
  figure(
    tbl,
    caption: caption,
    supplement: [表],
    numbering: table_num,
    kind: "table",
  )
}

#let img(img, caption: "") = {
  figure(
    img,
    caption: caption,
    supplement: [图],
    numbering: image_num,
    kind: "image",
  )
}


#let empty_par() = {
  v(-1em)
  box()
}


#let project(
  logopath: "",
  subject: "",
  labname: "",
  kwargs: (),
  firstlineindent: 0em,
  heiti: ("Noto Sans CJK SC", "Times New Roman"),
  songti: ("Noto Serif CJK SC", "Times New Roman"),
  mono: ("FiraCode Nerd Font Mono", "Sarasa Mono SC","Courier New", "Courier", "Noto Serif CJK SC"),
  body,
) = {
  // 引用的时候，图表公式等的 numbering 会有错误，所以用引用 element 手动查
  show ref: it => {
    if it.element != none and it.element.func() == figure {
      let el = it.element
      let loc = el.location()
      let chapt = counter(heading).at(loc).at(0)

      // 自动跳转
      link(loc)[#if el.kind == "image" or el.kind == "table" {
          // 每章有独立的计数器
          let num = counter(el.kind + "-chapter" + str(chapt)).at(loc).at(0) + 1
          it.element.supplement
          " "
          str(chapt)
          "-"
          str(num)
        } else if el.kind == "equation" {
          // 公式有 '(' ')'
          let num = counter(el.kind + "-chapter" + str(chapt)).at(loc).at(0) + 1
          it.element.supplement
          " ("
          str(chapt)
          "-"
          str(num)
          ")"
        } else {
          it
        }
      ]
    } else {
      it
    }
  }

  // 图表公式的排版
  show figure: it => {
    set align(center)
    if it.kind == "image" {
      set text(font: heiti, size: 12pt)
      it.body
      it.supplement
      " " + it.counter.display(it.numbering)
      " " + it.caption
      locate(loc => {
        let chapt = counter(heading).at(loc).at(0)
        let c = counter("image-chapter" + str(chapt))
        c.step()
      })
    } else if it.kind == "table" {
      set text(font: songti, size: 12pt)
      it.body
      set text(font: heiti, size: 12pt)
      it.supplement
      " " + it.counter.display(it.numbering)
      " " + it.caption
      locate(loc => {
        let chapt = counter(heading).at(loc).at(0)
        let c = counter("table-chapter" + str(chapt))
        c.step()
      })
    } else if it.kind == "equation" {
      // 通过大比例来达到中间和靠右的排布
      grid(
        columns: (20fr, 1fr),
        it.body,
        align(center + horizon, 
          it.counter.display(it.numbering)
        )
      )
      locate(loc => {
        let chapt = counter(heading).at(loc).at(0)
        let c = counter("equation-chapter" + str(chapt))
        c.step()
      })
    } else {
      it
    }
  }
  set page(paper: "a4", margin: (
    top: 2.5cm,
    bottom: 2cm,
    left: 2cm,
    right: 2cm
  ))

  // 封面
  align(center)[
    #v(30pt)

    #image(logopath, width: 100%)

    #v(50pt)

    #text(
      size: 36pt,
      font: songti,
      weight: "bold"
    )[《#subject》#linebreak()实验报告]

    #v(40pt)

    #text(
      font: heiti,
      size: 22pt,
    )[
      #labname
    ]

    #set align(bottom)
    #let info_value(body) = {
      rect(
        width: 100%,
        inset: 2pt,
        stroke: (
          bottom: 1pt + black
        ),
        text(
          font: songti,
          size: 16pt,
          bottom-edge: "descender"
        )[
          #body
        ]
      ) 
    }
    
    #let info_key(body) = {
      rect(width: 100%, inset: 2pt, 
       stroke: none,
       text(
        font: songti,
        size: 16pt,
        body
      ))
    }
    
    #let pair_into(pair) = {
      let (key, value) = pair
      (info_key(key + ":"), info_value(value))
    }
    
    #grid(
      columns: (70pt, 240pt),
      rows: (40pt, 40pt),
      gutter: 3pt,
      ..kwargs.pairs().map(pair_into).flatten()
    )
  ]

  counter(page).update(1)
  
  set page(
    header: {
      set text(font: songti, 10pt, baseline: 8pt, spacing: 3pt)
      set align(center)
      [《#subject》 实验报告]
      line(length: 100%, stroke: 0.7pt)
    },
    footer: {
      set align(center)
      text(font: songti, 10pt, baseline: -3pt, 
          counter(page).display("1"))

      
      // grid(
      //   columns: (5fr, 1fr, 5fr),
      //   line(length: 100%, stroke: 0.7pt),
      //   text(font: songti, 10pt, baseline: -3pt, 
      //     counter(page).display("1")
      //   ),
      //   line(length: 100%, stroke: 0.7pt)
      // )
    }
  )

  set text(font: songti, 12pt)
  set par(justify: true, leading: 1.24em, first-line-indent: firstlineindent)
  show par: set block(spacing: 1.24em)

  // TODO
  // 目前先硬编码
  set heading(
    numbering: (..nums) => {
      let vars = nums.pos()
      if vars.len() == 1 {
        numbering("一、 ", vars.last())
      } else {
        numbering("1. ", vars.last())
      }
    },
  )

  show heading.where(level: 1): it => {
    // set align(center)
    set text(weight: "bold", font: heiti, size: 18pt)
    set block(spacing: 1.5em)
    it
  }
  show heading.where(level: 2): it => {
    set text(weight: "bold", font: heiti, size: 14pt)
    set block(above: 1.5em, below: 1.5em)
    it
  }

  // 首段不缩进，手动加上 box
  show heading: it => {
    set text(weight: "bold", font: heiti, size: 12pt)
    set block(above: 1.5em, below: 1.5em)
    it
  } + empty_par()


  counter(page).update(1)

  // 行内代码
  show raw.where(block: false): it => {
    set text(font: mono, 12pt)
    it
  }
  
  show raw.where(block: false): box.with(
     fill: rgb(217, 217, 217, 1),
     inset: (x: 3pt, y: 0pt),
     outset: (y: 3pt),
     radius: 2pt
  )

  // 代码块
  // 紧接着的段落无缩进，加入一个空行
  show raw.where(block: true): it => {
    set text(font: mono, 10pt)
    set block(inset: 5pt, fill: rgb(217, 217, 217, 1), radius: 4pt, width: 100%)
    set par(leading: 0.62em, first-line-indent: 0em)
    it
  } + empty_par()
  
  // 无序列表
  show list: it => {
    it
  } + empty_par()

  // 有序列表
  show enum: it => {
    it
  } + empty_par()

  body
}