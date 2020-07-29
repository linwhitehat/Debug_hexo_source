---
layout: draft
title: 逆向分析APK（一）
catalog: true
tags: [逆向分析, APK, 技术应用]
categories: [技术分享, Android]
related_posts: true
---
最近开始做一些Android APP的分析，由于之前没有移动端逆向的基础，所以将自学和摸索的过程做下记录，但是并不是完整的逆向分析技术博客，只是针对具体的APK逆向分析中的技术记录和经验分享。
<!-- more -->

## 逆向工具和环境

### Android Studio
Android Studio（AS）是一款谷歌推出的移动端应用开发的IDE，而在安装APP逆向分析中主要将其作为源码分析和调试的工具，同时使用AS自带的模拟器也比较方便。

### apk反编译

### apk重签名

### dex转jar

### java源码反编译查看

## 模拟器

### AS自带模拟器

### 雷电模拟器

## 逆向问题

### debug端口无法连接
1.在使用AS进行逆向动态调试过程，打开monitor查看adb device存在之后，设置AS项目下remote的调试端口，默认是8700，但是monitor中无法显示调试应用，一般原因从经验上是应用在上次调试中强制中断或长时间未运行完导致崩溃，也可能是adb设置单应用调试切断应用进程。
解决方法：重启AS项目，模拟器和monitor可以视情况重启。
2.如果上述情况下出现8700端口显示被占用，则可能是因为多次调试导致之前的调试端口未释放而被占用。
解决：将AS的remote端口修改为monitor下应用的另一个端口。
