// set PDF document metadata
#set document(title: "摸鱼与摸鱼工程实验一", author: "张三")

#import "@local/hitsz-lab-report-template:1.0.0": *

#show: project.with(
  logopath: "./asset/hitsz_logo.jpg",
  subject: "摸鱼与摸鱼工程",
  labname: "实验一\n系统性摸鱼设计",
  kwargs: (
    "学院": "计算机科学与技术学院",
    "姓名": "张三",
    "学号": "1145141919810",
    "专业": "计算机科学与技术",
    "日期": "2050 年 2 月 30 日",
  ),
  // 段首缩进, 2em 意为缩进两个字符
  firstlineindent: 2em,
  // 黑体字体设置
  heiti: ("Noto Sans CJK SC", "Times New Roman"),
  // 宋体字体设置
  songti: ("Noto Serif CJK SC", "Times New Roman"),
  // 等宽字体设置
  mono: ("FiraCode Nerd Font Mono", "Sarasa Mono SC","Courier New", "Courier", "Noto Serif CJK SC"),
)

= h1

== h1.1

#lorem(30)

== h1.2

#lorem(30)

= h2

== h2.1

#lorem(30)

== h2.2

#lorem(30)

