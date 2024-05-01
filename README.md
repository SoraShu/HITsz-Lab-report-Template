# HITsz Lab-report Template

用于 HITsz 实验报告的 Typst 模版，轻量、低配置。

## 目的

此模版目标在于解决以下问题：

- 实验报告只能使用可以编辑 docx/doc 格式文件的富文本编辑器。这类编辑器大多存在兼容性问题，不一定在各个系统上运作良好，给使用某些操作系统的用户带来了困扰。
- 实验报告模版由 [MS Word](https://www.microsoft.com/en-ww/microsoft-365/word) 制作，在其它编辑器上可能出现排版错位。~~且 MS Word 需要付费购买，购买此软件可能给经济困难的同学带来经济压力。~~
- 实验老师对于是否使用模版态度比较模糊，但如果使用无格式的 plaintext 或者通过 markdown 等标记语言不加排版地生成 PDF 实验报告，实验老师可能不接受，而且给实验批改带来障碍。

因此本模版致力于提供一个开源跨平台的编写实验报告的方案，且此方案生成接近实验报告模版的产物。

## Why Typst

下面列出使用 Typst 之前我尝试过的工具，以及我为什么最终放弃使用。

- Markdown: 热门的标记语言。他的主要问题在于他只是一个等价于 HTML 的标记语言（甚至比 HTML 更弱，使用时时常需要嵌入 HTML），并不能很方便地支持复杂排版，且对于某些格式需要如何实现我毫无头绪，如页脚和页眉。
- Latex: 著名的排版系统。我在编写 Latex 模版上缺乏经验，整理出来的模版效果不佳。且 Latex 整套工具链较重。

Typst 可以说是介于以上两者之间。用它来编写文档上手很快，但它同时是一个较为完整的排版系统。同时 Typst 是一个轻量级的工具，本身配置也较为简单，0 配置下的效果就相当不错。

## 如何使用

安装 Typst 的 cli 工具，具体安装参考 [typst#installation](https://github.com/typst/typst#installation)。

clone 本项目，将本项目安装为本地包

```bash
./install.sh
```

该脚本默认会将包安装到 `${XDG_DATA_DIR}/typst/packages/${TYPST_LOCAL_NAMESPACE}/hitsz-lab-report-template/${VERSION}`。可以通过 export 对应环境变量的形式自定义该路径。

随后可以使用 Typst 自带的模版初始化功能在对应目录下初始化您的项目:

```bash
# 若您使用了自定义的环境变量, 请自行修改下面的命令
typst init @local/hitsz-lab-report-template:1.0.0 ${PROJECT_NAME}
```

## 说明

没有看过其它专业的实验报告模版，不确定是否可用于非计算机科学与技术学院的实验报告。

目前模版排版和实验报告的模版并不是 1:1 复刻，鉴于实验报告模版格式也不尽相同，本模版也无力 cover 实验报告的所有格式变体。

对于实验报告能否用本模版编写，以及本模版的产物能否作为实验报告提交，最终解释权在于接收实验报告的老师或助教，本项目不做任何保证。

## TODO

- [ ] 支持自定义各级标题的序号格式。
- [ ] 支持代码块显示行号。（等待 Typst 支持此特性）
- [ ] 线上编辑。（需要将字体同时上传）

## 参考

本模版几乎是从 [github:werifu/HUST-typst-template](https://github.com/werifu/HUST-typst-template) 修改而成，在此特别感谢。
