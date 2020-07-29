---
layout: post
title: Markdown·博客写作
catalog: true
date: 2020-02-17 00:26:17
tags: [写作]
categories: [技术分享, Markdown]
related_posts: true
---
博客撰写使用的是`Markdown`，一般博客搭建教程会推荐Hexo写作[^1]给初学者进行博客撰写，但其实`Markdown`具有很多丰富的语法，同时支持Html语法，运用得当，将可以写出排版优美，内容丰富的文章，此篇博客默认读者了解Markdown的基本语法，但是也会提及，参照来自《Learning-Markdown》[^2]。
![Markdown](/Blog/images/markdown_1.webp "Markdown")
<!-- more -->

## 关于Markdown
Markdown 是一种轻量级标记语言，创始人为约翰·格鲁伯（John Gruber）。它允许“使用易读易写的纯文本格式编写文档，然后转换成有效的 XHTML（或者 HTML）文档”。这种语言吸收了很多在电子邮件中已有的纯文本标记的特性。更多可参照[维基百科](https://zh.wikipedia.org/wiki/Markdown)。

### 选择 Markdown
主要原因在于 Markdown 很适合用于编写文档、记录笔记、攥写文章，当然其他因素包括：

- 它基于纯文本，方便修改和共享；
- 几乎可以在所有的文本编辑器中编写；
- 有众多编程语言的实现，以及应用的相关扩展；
- 在 GitHub 等网站中有很好的应用；
- 很容易转换为 HTML 文档或其他格式。

### 兼容 HTML
Markdown 完全兼容 HTML 语法，可以直接在 Markdown 文档中插入 HTML 内容。

## 基础语法详解
本文列述的语法是基于 John Gruber 定义的[Markdown Syntax](https://daringfireball.net/projects/markdown/syntax)，当然 Markdown 还有其他不同的编译解释语法，可以后续关注。在 Hexo 博客中解析语法不完全遵循此处的语法，但是本文列述的语法是基本语法，算是通用的，如果本地使用 MarkdownPad 编辑器，那么本文语法完全适用。

### 段落与换行
1. 段落的前后必须是空行
  空行指的是行内什么都没有，或者只有空白符（空格或制表符），相邻两行文本，如果中间没有空行 会显示在一行中（换行符被转换为空格）。
2. 段落内换行（`<br>`）
  可以在前一行的末尾加入至少两个空格，然后换行写其它的文字。
3. Markdown 中的多数区块都需要在两个空行之间。

### 标题
标题样式有两种：
1. Setext 形式
  这种形式只支持`H1`和`H2`的标题样式，即使用`=`和`-`分别表示标题1和标题2，符号数量没有限制，原则以文本看起来舒服为主，使用如下:
  ``` markdown
  H1
  ====
  
  H2
  ----
  ```
2. atx 形式
  这种方式更为常用，即使用`#`的数量对标题进行表示，数量的多少即代表标题的样式，如`#`表示标题1，`##`表示标题2，使用方式有两种种，可任选使用：
  - 使用对称的 `#` 括住标题文本，如`## Title ##`；
  - 只在标题文本左侧使用`#`，如`## Tile`。

  **注意**
  标题符号左侧不能出现空格，但空格可以在标题文本中使用。

### 引用
要在文章中显示引用内容，可以在开头使用`>`，则之后的文本都将被标记为引用，引用的方式如下：
1. 单行引用
  ``` markdown
  > 引用内容
  ```
2. 多行引用
  ``` markdown
  >多行引用
  >可以在每行前加 `>`
  
  >如果仅在第一行使用 `>`
  后面相邻的行即使省略 `>`，也会变成引用内容
  
  >如果引用内容需要换行，  
  >可以在行尾添加两个空格
  >
  >或者在引用内容中加一个空行
  ```
3. 嵌套引用
  ``` markdown
  >也可以在引用中
  >>使用嵌套的引用
  ```

### 列表
列表分为三种，分别是无序列表，有序列表和嵌套的列表。无序和有序的区别即列表显示内容前的符号是否是数字，嵌套列表即多种列表嵌套使用。列表具体使用如下:
1. 无序列表
  ``` markdown
  * 可以使用 `*` 作为标记，文本需要间隔一个空格后输入；
  + 也可以使用 `+`；
  - 或者 `-`。
  ```
2. 有序列表
  ``` markdown
  1. 有序列表以数字和 . 开始，同时 . 与文本内容之间同样需要一个空格；
  3. 数字的序列并不会影响生成的列表序列；
  4. 但仍然推荐按照自然顺序（1.2.3...）编写。
  ```
3. 嵌套列表
  ``` markdown
  1. 第一层
    + 1-1
    + 1-2
  2. 无序列表和有序列表可以随意相互嵌套
    1. 2-1
    2. 2-2
  ```

### 代码
在技术博客中，代码往往缺少不了，因为代码示例是最直接的展示，代码的表示主要有两种：
1. 代码块
  使用缩进表示代码区域，代码块前后需要有至少一个空行，且每行代码前需要有至少一个 Tab 或四个空格；
  ``` markdown
  <html> // Tab开头
      <title>Markdown</title>
  </html> // 四个空格开头
  ```
  代码区域也可以使用连续三个\`即 \`\`\` 来表示起止位置，即代码块的起始和结束位置，格式具体如下：

  ```
  ``` key
   代码段
  ``` 
  ```

2. 行内代码
  在文本之间插入代码，当只需要展示少量变量或代码可以使用这种方式。通过单个 ` 在代码内容前后表示起止，插入行内代码（ 该符号即英文输入法下数字 1 键左侧的那个按键）。
3. 代码高亮[^8]
  为了让代码部分看起来更加美观和符合语法高亮，markdown中有对应的语言标记，通过对代码块中的 `key` 进行标记替换便能实现高亮效果。参照表格如下：

  |language|key|language|key|
  |--------|:-:|--------|:-:|
  |1C|1c|ActionScript|actionscript|
  |Apache|apache|AppleScript|applescript|
  |AsciiDoc|asciidoc|AspectJ|asciidoc|
  |AutoHotkey|autohotkey|AVR Assembler|avrasm|
  |Axapta|axapta|Bash|bash|
  |BrainFuck|brainfuck|||
  |Cap’n Proto|capnproto|Clojure REPL|clojure|
  |Clojure|clojure|CMake|cmake|
  |CoffeeScript|coffeescript|C++|cpp|
  |C#|cs|CSS|css|
  |D|d|Dart|d|
  |Delphi|delphi|Diff|diff|
  |Django|django|DOS.bat|dos|
  |Dust|dust|Elixir|elixir|
  |ERB(Embedded Ruby)|erb|Erlang REPL|erlang-repl|
  |Erlang|erlang|FIX|fix|
  |F#|fsharp|G-code(ISO 6983)|gcode|
  |Gherkin|gherkin|GLSL|glsl|
  |Go|go|Gradle|gradle|
  |Groovy|groovy|Haml|haml|
  |Handlebars|handlebars|Haskell|haskell|
  |Haxe|haxe|HTML|html|
  |HTTP|http|Ini file|ini|
  |Java|java|JavaScript|javascript|
  |JSON|json|Lasso|lasso|
  |Less|less|Lisp|lisp|
  |LiveCode|livecodeserver|LiveScript|livescript|
  |Lua|lua|Makefile|makefile|
  |Markdown|markdown|Mathematica|mathematica|
  |Matlab|matlab|MEL (Maya Embedded Language)|mel|
  |Mercury|mercury|Mizar|mizar|
  |Monkey|monkey|Nginx|nginx|
  |Nimrod|nimrod|Nix|nix|
  |NSIS|nsis|Objective C|objectivec|
  |OCaml|ocaml|Oxygene|oxygene|
  |Parser 3|parser3|Perl|perl|
  |PHP|php|PowerShell|powershell|
  |Processing|processing|Python’s profiler output|profile|
  |Protocol Buffers|protobuf|Puppet|puppet|
  |Python|python|Q|q|
  |R|r|RenderMan RIB|rib|
  |Roboconf|roboconf|RenderMan RSL|rsl|
  |Ruby|ruby|Oracle Rules Language|ruleslanguage|
  |Rust|rust|Scala|scala|
  |Scheme|scheme|Scilab|scilab|
  |SCSS|scss|Smali|smali|
  |SmallTalk|smalltalk|SML|sml|
  |SQL|sql|Stata|stata|
  |STEP Part21(ISO 10303-21)|step21|Stylus|stylus|
  |Swift|swift|Tcl|tcl|
  |Tex|tex|text|text/plain|
  |Thrift|thrift|Twig|twig|
  |TypeScript|typescript|Vala|vala|
  |VB.NET|vbnet|VBScript in HTML|vbscript-html|
  |VBScript|vbscript|Verilog|verilog|
  |VHDL|vhdl|Vim Script|vim|
  |Intel x86 Assembly|x86asm|XL|xl|
  |XML|xml|YAML|yml|

### 分隔线
在一行中使用三个或更多的`*`、`-`或`_`表示分隔线，字符间可以存在空格但是不能存在其他字符，使用如下：
``` markdown
***
---
```

### 超链接
在攥写文档中对文本加上超链接，当阅读到相应内容想直接访问时可以点击文件即跳转访问。超链接的表示有三种方式：
1. 行内式
  这是最常见的一种使用超链接的方式，使用格式为`[link text](URL)`，其中 URL 可以是网络链接也可以是本地链接。
2. 参考式
  参考式链接的写法相当于行内式拆分成两部分，并通过一个 *识别符* 来连接两部分。参考式能尽量保持文章结构的简单，也方便统一管理 URL。这种方式表示如下:
  - 定义链接,`[link text][识别符]`，识别符可以是字母、数字、空白或标点符号，识别符不区分大小写；
  - 定义链接内容，`[识别符]: URL "title"`，URL可以使用 `<>` 包括起来，title 可以使用 ""、''、() 包括；
  - 省略识别符也可以表示，定义链接及内容为`[link text][]`，`[link text]: URL "title"`。
3. 自动链接
  使用`<>`包括的URL或邮箱地址会被自动转换为超链接。

### 图片
在文档中插入图片的方式与插入超链接的方式基本一致，语法的差异在于插入图片需要在最前面加一个感叹号`!`，插入图片方式如下：
1. 行内式
  插入图片格式为`![pic text](URL "title")`，方括号中的部分是图片的替代文本，括号中的 'title' 部分和超链接一样，是可选的。
2. 参考式
  参考式插入图片格式为`![pic text][识别符]`，`[识别符]: URL "title"`。
3. 指定图片显示大小
  在 Markdown 中对图片大小及位置进行设置需要使用 HTML 语法，使用`<img />`标签属性设定图片大小，示例如下：
  `<img src="URL" alt="Alt" title="Tiltle" width="50" height="50" />`

### 强调
通过不同文本样式对特殊的文本内容进行强调，这里讲述斜体和加粗的使用。
1. 斜体，使用`*`成对表示，将需要斜体展示的文本放置在成对的`*`之间；
2. 加粗，使用`**`成对表示，将需要加粗展示的文本放置在成对的`**`之间。

上述的符号也可以使用`_`替换`*`。

### 字符转义
在 Markdown 中存在一些特殊字符，如前述的插入代码、斜体等，要正常显示字符且使其不表达特殊作用则需要对其进行转义。反斜线（`\`）用于插入在 Markdown 语法中有特殊作用的字符。

## 扩展语法

### 删除线
删除线一般很少用，当旧文档的内容存在失效时，为了显示新旧的差异，可以在失效内容上显示删除线，表示该内容已经不适用。
删除线使用即加上波浪线，表示为`~~失效内容~~`，效果为：~~失效内容~~。

### 代码块和语法高亮
根据前述介绍的插入代码块方法可以插入代码，但是要使文档代码更美观，使不同语言的代码能够显示对应语法高亮。此时需要使用 \`\`\` 作为代码块区域标识，在起始的 \`\`\` 之后的`key`写上代码块对应的程序语言名称，如代码为 Javascript ，起始位置则写为：

```
``` javascript
code
``` 
```

### 表格
表格可以用于展示多种比较的内容项，而表格的展示主要包括表头和单元格，使用`|`进行单元格分隔，使用`-`分隔表头和其他行，三行两列的表格表示如下：

```
name | age
---- | ---
LearnShare | 12
Mike |  32
```

要使表格内容对齐，可以在第二行的分界处使用下述标记内容进行对齐：

- `:---` 代表左对齐
- `:--:` 代表居中对齐
- `---:` 代表右对齐

**注意**
在Hexo博客中加入表格时需要注意先空行，否则在解析时会出现错误，表格无法显示，同时也可以使用 HTML 语法进行表格添加，表格美化可参照[^3]。

### ToDo列表
ToDo列表也是 Task List，展示待做的事情。使用如下:

``` markdown
 - [ ] Eat
 - [x] Code
  - [x] HTML
  - [x] CSS
  - [x] JavaScript
 - [ ] Sleep
```

### 目录
给攥写的文章加上目录内容，在文中需要显示文章目录结构的位置，独立一行写上`[TOC]`。

### 插入Emoji表情
插入 Emoji 表情主要是在 GitHub 和博客中可能会用到，这里介绍三种方式如下，来源参照[^4]。
1. 图片格式
  使用 HTML 的图片标签`<img>`插入图像，此方法需要知道 Emoji 表情的链接地址，使用效果如下：<img src="https://www.webpagefx.com/tools/emoji-cheat-sheet/graphics/emojis/octocat.png" height="40" width="40" align="middle">
  > 推荐 Emoji 源：
  - GitHub / GitHub_Icon：[github markdown emoji markup](https://blog.codecarrot.net/markdown-emoji-markup/)
  - iemoji：[iEmoji](https://www.iemoji.com/)
  - webpagefx：[WebFX EMOJI CHEAT SHEET](https://www.webfx.com/tools/emoji-cheat-sheet/)
2. 源码粘贴
  这种方式较为推荐，因为 Markdown 兼容 HTML 语法，因此 HTML 支持复制粘贴 Emoji 表情也可以直接在 Markdown 中使用。这里推荐[emojipedia](https://emojipedia.org/)和[emojicopy](https://www.emojicopy.com/)，可以搜索所需的表情然后点击`copy`即可直接粘贴到文中相应位置。
3. Unicode编码
  Emoji表情在 Unicode 标准编码中已经集成，直接使用 Unicode 编码也能表示 Emoji 表情。在[Emoji Charts](http://unicode.org/emoji/charts/full-emoji-list.html)可查找每个 Emoji 表情的 Unicode 编码。

## 博客写作
在了解上述 Markdown 语法之后，基本能完成博客的撰写，这里介绍一些博客撰写的注意地方。博客的维护中重要的一项即博客文章，而文章有时候不一定能一次性写完，但是又不希望未写完就发布到博客中，也不希望一直存放在博客文件目录外，此时便可以使用`草稿 draft`进行存放未完成的文章。博客写作并不是简单写完一篇文章发布就结束，一篇优质博文需要细心和耐心，对于需要注意的地方本文会进行记录分享。参照来源[^6]。

### 新建文章
创建文章有两种方式，一种是在`git bash`下生成即`hexo new [layout] <title>`，一种是手动新建即在文章目录文件夹中手动建立。

### 布局（layout）
在 Hexo 中有三种默认布局即`post`、`page`和`draft`，若不希望文章被 Hexo 布局渲染，可以在文章的 Front-Matter 中设置`layout: false`。

### 草稿（draft）
草稿创建后一般存放在`../hexo/source/_drafts`目录下，草稿默认不会发布到博客中显示。

### Front Matter
Front-Matter 即文章中最上面的设置区，以`---`作为分隔，更多可参照[^7]，默认的参数如下：

|参数名称|描述|默认值|
|-------|:--:|-----|
|layout|布局||
|title|标题||
|date|建立日期|文件创建时间|
|updated|更新日期|文件更新日期|
|comments|开启文章评论|true|
|tags|标签||
|categories|分类||

### 模板（scaffolds）
此处为 Hexo 对文章建立时采用的模板，可以在新建文章时选择模板，如`hexo new scaffold_1 "file"`则会根据自定义的模板`../scaffolds/scaffold_1.md`对新建的文章按照相同的样式进行初始化。

### 分类及标签
在 Front-Matter 中对文章的参数`分类-categories`和`标签-tags`进行设置，具体可参照前述`Front Matter`一节。这里要说明的是，对标签和分类进行设置有两种方式：
1. 类似无序表格的方式即使用`-`进行表示，如:
  ``` markdown
  tags:
  - tag_1
  ```
2. 使用中括号表示多个标签或分类，如：
  ``` markdown
  tags: [tag_1, tag_2]
  ```

## README写作
在GitHub建立项目往往都需要一份README做项目的介绍说明，README的目的主要是让读者更容易和快速了解项目并使用，但是一份糟糕的README可能让读者陷入“糊涂”的境地，非当没有起到作用还让读者花费更多时间去理解项目内容，因此一份良好的README对项目本身十分重要。尽管这一章节没法详尽去叙述一篇README怎么写好，但是已经有大量热门的项目都具备良好的README，同时也有一些教科书式README可以参考[^9][^10][^11]。
在这一部分我可能先补充一些README里较为不熟悉的部分，比如badge部分->如何建立合适的svg。

### Badge
这部分可能一些使用GitHub的人会又熟悉又陌生，因为这部分其实并非README必须，但是在热门的项目中时常能看到，这部分内容可以为项目内容做评估也可以展示项目的特色，通常都是以`svg`格式展现，可以视作徽标。徽标的制作可以基于`shields.io`[^12]，这里提供了大量的摸板。
![badge colors](/Blog/images/markdown_2.webp "badge colors")

#### 徽标的基本格式如下：
1. 图标格式
  ```
  https://img.shields.io/badge/{徽标标题}-{徽标内容}-{徽标颜色}.svg
  ```
2. 带链接图标格式
  ```
  [![](https://img.shields.io/badge/{徽标标题}-{徽标内容}-{徽标颜色}.svg)]({linkUrl})
  ```
3. 带logo图标格式
  ```
  https://img.shields.io/badge/{徽标标题}-{徽标内容}-{徽标颜色}.svg?logo={徽标图形名称}
  ```
4. 带`quert string`参数
  ```
  https://img.shields.io/badge/{徽标标题}-{徽标内容}-{徽标颜色}.svg?{参数名1}={参数值1}&{参数名2}={参数值2}
  ```

#### 徽标效果
1. 效果1
  [![](https://img.shields.io/badge/blog-@lin-red.svg)](https://linwhitehat.github.io/Blog/)

2. 效果2
  ![](https://img.shields.io/badge/blog-@lin-success.svg?style=flat-square)

3. 效果3
  ![](https://img.shields.io/badge/blog-@lin-blue.svg?style=flat-square&logo=python)

## 结束
这篇博文基本介绍了 Markdown 和博客撰写的基本内容，看完这些内容能够实现自己博客的博文撰写，同时能规范写作语法并使内容排版整洁美观，后续进阶语法可以继续阅读相关阅读推荐篇章。


[^1]: [Hexo写作](https://hexo.io/zh-cn/docs/writing.html)
[^2]: [Learning-Markdown](http://xianbai.me/learn-md/index.html)
[^3]: [Hexo下表格的美化和优化](https://hexo.imydl.tech/archives/6742.html)
[^4]: [在博客中插入emoji表情](https://blog.csdn.net/u014636245/article/details/82945997)
[^5]: [Markdown 书写风格指南](https://einverne.github.io/markdown-style-guide/zh.html#code-blocks)
[^6]: [Hexo 博客 github.io MD](https://baiqiantao.github.io/%E5%85%B6%E4%BB%96/%E5%B7%A5%E5%85%B7/RraEBz/#%E8%B5%84%E6%BA%90%E6%96%87%E4%BB%B6%E5%A4%B9-asset)
[^7]: [Front Matter](https://jekyllrb.com/docs/front-matter/)
[^8]: [MarkDown支持高亮的语言](https://blog.csdn.net/u012102104/article/details/78950290)
[^9]: [有哪些 GitHub 项目的 README 堪称教科书？](https://www.zhihu.com/question/299390628)
[^10]: [开发工具总结（9）之开源项目的README文档的最全最规范写法](https://www.jianshu.com/p/813b70d5b0de)
[^11]: [如何写好Github中的readme？](https://www.zhihu.com/question/29100816)
[^12]: [shields.io](https://shields.io/)
[^13]: [GitHub项目徽标](https://juejin.im/post/5d98b2666fb9a04e1c07e071)