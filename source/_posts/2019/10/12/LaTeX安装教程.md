---
layout:     post
title:      LaTeX-安装教程
subtitle:   TexLive-2019 + TexStudio-2.12.16-win
date:       2019-10-12
author:     XinJ. L
type:
top:
catalog: true
tags: [Latex安装, Windows10]
categories: [Handbook, Latex]
related_posts: true
---

作为一名研究僧，写论文，写文档，写日志，写报告，写书……还是比较平常的一件事，而office系列对于排版要求严格又惜时如金的人而言还是次选，所以开始入坑LaTeX，经过慎重的调研之后，选择了texlive+texstudio的形式开始入坑，当然还有很多其他选择，如果写完这篇还记得会在参考链接下附上[^1][^2]。
<!-- more -->

## 调研选择

其实这部分只是自己做一点记录，急需安装教程的请跳过，请看第2节。

经过多番Google、csdn以及知乎的查阅，大概了解了latex的编译环境和编辑环境，主流的有ctex、texlive、texstudio+winedt等等，我的选择变化大致如下：
1. 在上过的一门算法课中老师推荐了跨平台下的latex集成工具，ctex被建议在windows下使用，所以最初我的选择是ctex，附上清华镜像，[Ctex-mirror](https://mirrors.tuna.tsinghua.edu.cn/ctex/legacy/2.9/ "ctex清华镜像")，官方网站[CTeX](http://www.ctex.org/HomePage)，加上ctex对中文的支持很好，且集成工具完整，当下载3G的安装包时，我又调研了不少教程，但是在某csdn的教程中看的评论有人评价ctex已不维护很久，同时ctex安装后会对系统环境变量进行覆盖，想想这个风险还是挺大的，毕竟安装需要配置换件变量的应用还挺多的，这篇[博文](https://liam.page/texlive/)有说明，接着看到在不少教程中推荐texlive（可谓官方），这是由 TUG (TeX User Group) 维护和发布的tex系统，接着有了第2个选择；

2. 开始调研texlive，看看官网[TexLive](https://tug.org/texlive/ "texlive")，维护还是比较好的，有2019最新版本，有多国镜像，有完整教学文档，感觉比ctex完善很多，果断放弃ctex，尽管这个时候安装文件也下载得差不多了，同时看到texstudio是tex编辑的不错的集成环境，官方的介绍是这样的：

  *TeXstudio is an integrated writing environment for creating LaTeX documents. Our goal is to make writing LaTeX as easy and comfortable as possible. Therefore TeXstudio has numerous features like syntax-highlighting, integrated viewer, reference checking and various assistants.*

  安装提供zip压缩包直接解压使用，很适合我这种不喜欢安装包的人，因为便于迁移，抉择已定，开始下载和安装。


## 下载

> 先提供需要安装的文件（texlive和texstudio）的[网盘链接](https://pan.baidu.com/s/1mRKV0VeNfjxhY6qGvSQdLw "网盘链接")，提取码：uhbe 

官方提供了下载方式：
1. texlive，[官方镜像](https://mirror.bjtu.edu.cn/ctan/systems/texlive/Images/texlive2019.iso)，如果访问不了，可以访问国内镜像，如[中科大镜像](http://mirrors.ustc.edu.cn/CTAN/systems/texlive/)；
2. texstudio，我选择的是zip压缩文件形式，[下载](https://github.com/texstudio-org/texstudio/releases/download/2.12.16/texstudio-2.12.16-win-portable-qt5.zip)；

当然也可以直接下载我网盘分享的镜像和安装包，可以使用官方提供的md5值进行比对验证文件没有被篡改。

## 安装

### TexLive 安装

下载好iso文件之后，由于我是win10系统，可以直接加载iso镜像文件，因此双击打开即可，如果是win7及以前的版本需要先解压iso文件，双击打开install-tl-advanced.bat文件，会出现以下界面：

![安装启动界面](/Blog/images/post-texlive-install-1.webp "安装启动界面")

点击*修改*更换需要安装的文件路径，路径建议不要带有中文和特殊字符；
点击*Advanced*修改安装选项，但默认是所有都选上，所以可以不用修改（因为涉及调用的宏包以及scheme选择，如果不了解还是默认，避免后续麻烦）；
点击*安装*，然后就是漫长的安装过程，安装期间可以做自己的事情，安装完成后显示如下：

![安装完成界面](/Blog/images/post-texlive-install-2.webp "安装完成界面")

做一下安装是否成功的检查：
1. 在开始菜单中搜索*TeX Live command-line*，执行以下命令：
  ``` bash
  xelatex -v
  ```
      
2. 如果正常会显示如下信息，即正常的texlive版本号：
  
  ![测试正常界面](/Blog/images/post-texlive-test-1.webp "测试正常界面")
  
3. 如果显示错误如下，应该是系统环境变量的问题，进入系统环境变量（系统属性->高级系统设置->环境变量），将*Path*环境变量新增texlive进去，即将安装好的texlive文件目录下的bin文件夹所在的路径作为环境变量。
  
  ![测试错误界面](/Blog/images/post-texlive-test-2.webp "测试错误界面")
  
### TexStudio 安装

下载好zip压缩文件之后，直接解压就可以使用，十分方便！

## 配置

主要是texstudio需要进行配置，更适合国内人士使用。

### 语言设置

打开texstudio之后，在主界面中显示的是英文，点击菜单栏的*Options*，点击*Configure TeXstudio*，在*General*选项下将*Language*选择为*zh_CN*，点击确定；

### 编译环境设置

在语言设置一样的窗口，此时显示语言是中文，点击*构建*->*默认编译器*设置为"XeLaTeX"，支持中文LaTeX文档；
将*构建*->*默认文献工具*设置为"Biber"；
在*命令*->*XeLaTeX*设置编译参数，使用 -shell-escape 参数以支持“minted”代码排版宏包；

点击*构建*->*默认编译器*设置为"Latexmk"实现一次性编译；
将*命令*->*Latexmk*的 -pdf 参数修改为 -xelatex 以支持中文；
在*命令*->*Latexmk*设置编译参数，使用 -shell-escape 参数以支持“minted”代码排版宏包；
点击确定

点击菜单栏*帮助*->*检查Latex安装信息*，若正确输出系统报告，说明texlive正常工作。

## 结束
第一篇tex文档参照这篇博客，[Texlive+TeXstudio 入门安装使用](https://blog.csdn.net/yeler082/article/details/80665186)，照着输入，然后点击两个绿色箭头重叠的按钮，可以看到实时生成的文档。


[^1]: [TeX Live & TeXstudio 安装手记](https://www.cnblogs.com/joyeecheung/p/3596255.html)
[^2]: [第一篇tex文档编写](http://www.ctex.org/OnlineDocuments)
