---
layout: post
title: HTML系列
copyright: true
date: 2020-02-23 15:00:03
catalog: true
tags: [HTML]
categories: [技术分享, 前端]
related_posts: false
---
这篇博文是在自定义博客页面中不断回顾和使用 HTML 知识后做的记录，以前学的前端知识尽管是基础知识，但是只是前端的皮毛，对 HTML5 以及脚本甚至最新的W3C认证的WEB语言`WebAssembly`，因此本文依据博客制作完善过程的前端应用将对应知识进行记录分享。
<!-- more -->

## HTML5

### 网页背景音乐

传统的在 HTML 页面中存在多种方法能进行插入音频，除了浏览器中插入浏览器插件外，在 HTML 中可以使用`embed`和`object`标签[^1]。

#### `<embed>`元素
此标签元素可定义外部资源的容器，是 HTML5 标签。使用此标签，可以对外部资源进行引用并定义资源嵌入网页的容器，引入 MP3 资源如下:
``` html
<embed height="100" width="100" src="song.mp3" />
```
具体使用效果可参考我的一篇博客中的教程说明，可参阅[博客主题优化-添加音乐](https://linwhitehat.github.io/Blog/2020/01/30/%E5%8D%9A%E5%AE%A2%E4%B8%BB%E9%A2%98%E4%BC%98%E5%8C%96.html)。

#### `<object>`元素
此标签元素与`embed`元素功能基本相同，引入 MP3 资源如下：
``` html
<object height="100" width="100" data="song.mp3"></object>
```

#### `<audio>`标签
本文推荐在 HTML 中使用此元素标签，此元素是一个 HTML5 元素，在所有浏览器中均有效[^2][^4]。示例如下：
``` html
<audio controls="controls">
    <source src="song.mp3" />
Your browser does not support this audio format.
</audio>
```
建议在标签之间写入文本，意在旧浏览器访问设置此标签的网站时能够显示文本内容。
此标签包含的属性如下，更多属性说明如在 Firefox 浏览器中的所有属性说明可参照[^3]：

|属性|值|说明|
|---|:---:|--|
|autoplay|布尔值|音频资源加载后自动播放，默认值为`false`|
|controls|controls|在页面中显示控制播放窗口|
|loop|布尔值|音频资源循环播放|
|preload|`none`/`metadata`/`auto`|当所在页面加载时便进行资源加载|
|muted|muted|音频设置静音|
|src|url|音频资源的链接地址，可以使用`<source>`标签设置|

浏览器支持情况如下，更多浏览器支持情况参照浏览器兼容性[^3]：

|支持情况|IE|Edge|Firefox|Chrome|Safari|Opera|
|---|:---:|:---:|:---:|:---:|:---:|---|
|audio标签|9+|12+|3.5+|3+|3.1+|10.5+|
|buffered属性|unknown|yes|4+|unknown|unknown|unknown|
|preload属性|9+|12+|4+|64+在属性`metadata`中默认配置|3.1+|51+在属性`metadata`中默认配置|

**注意：**
不同浏览器对支持播放的音频格式存在差异，如果要满足多种浏览器的音频格式支持，可以使用多个`<source>`标签加载多种音频格式的资源。

## 结束
本文博文将对前端中 HTML 的语法进行整理，整理进程以实际使用为参照，对新加入的语法及语言应用也会适当更新在博文中。


[^1]: [W3school HTML 音频](https://www.w3school.com.cn/html/html_audio.asp)
[^2]: [HTML5 标签audio添加网页背景音乐代码](https://blog.csdn.net/ithomer/article/details/48622023)
[^3]: [audio](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/audio)
[^4]: [HTML <audio> 标签](https://www.w3school.com.cn/tags/tag_audio.asp)