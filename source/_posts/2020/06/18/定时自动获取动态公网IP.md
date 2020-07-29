---
layout: post
title: 定时自动获取动态公网IP
catalog: true
date:
tags: [动态IP, 树莓派, raspberry, dynamic IP, Python3, SMTP, WAN]
categories: [技术分享, Code, 工具库]
related_posts: true
---
这篇博文主要是为了解决远程连接（Windows[^1]和Linux[^2]的使用手册均有记录）目标的公网IP是动态变化带来的一些麻烦，但是又不希望花费过多的时间去备案域名做DDNS，尽管也有不需要备案域名的，但是基于只需要知道当前公网IP的简单需求，我还是动手写个小工具AODI，用于定时发送邮件告知自己远程机器的公网IP地址。
<!-- more -->

## GitHub项目

目前[AODI](https://github.com/linwhitehat/AODI)已上传GitHub仓库，点击[AODI](https://github.com/linwhitehat/AODI)即可获取源码及使用说明。
GitHub地址：[https://github.com/linwhitehat/AODI](https://github.com/linwhitehat/AODI)

## 思路分析

### 获取准确的公网IP

从需求可以很明确目标就是当前远程机器的公网IP，自然最重要的就是获取到准备的公网IP，出于保险考虑，从以下两部分来源进行获取：
1. 开放的IP地址查询网站
  目前互联网上开放不少支持IP查询的网站，但是质量参差不齐，我测试过后选择了三个网站作为候选，在获取公网IP时对候选网站逐个轮询直到成功获取当前公网IP，经过调研和测试，这三个网站相对可靠和稳定。
  
  > 候选测试IP网站 
  > - http://ipv4.icanhazip.com 
  > - https://ip.cn
  > - https://httpbin.org/ip
  
  由于这类网站相对信息简单，只需要简单进行`GET`请求即可获取到IP信息，因此不再赘述python部分内容。

2. 路由器网关配置
  除了上述网站进行IP查询之外，用户可自行添加测试IP网站，但是为了避免获取到不准确的公网IP，基于路由器网关配置的WAN口地址查询可以作为后备方法。通过访问路由器后台管理页面，通过身份验证后，查询对应的网络信息，由此即可获取到准确的公网IP，可以作为上述方法的备选方案也可以作为校验方法，甚至可以只使用这种方法直接获取公网IP。获取步骤如下：
  1. 获取远程机器所在路由器的后台管理地址，一些路由器并非只使用网关地址作为后台管理地址，因此需要自己进行确认后配置完整地址；
  2. 身份验证，设置登录的账户名和密码作为`POST`请求的数据内容进行模拟登录，并使用`session`方法记录当前登录状态；
  3. 获取网关信息，模拟登录之后通常不会显示在网关信息页面，定位到网关信息所在的页面，使用`GET`方法获取WAN口对应的IP信息。

**注意**
网关信息页面不一定就是浏览器地址栏显示的地址，最好是使用浏览器开发者工具，观察页面变化信息，找到对应请求时的完整地址信息（如下图），确保顺利获取到WAN口地址。
![获取网关页面地址](/Blog/images/AODI_1.png "获取网关页面地址")

### 邮件通知

在远程机器获取到公网IP地址之后，便需要通知用户本人，便于其进行远程连接使用，自然想到邮件通知了。由于现在邮件系统五花八门，基于不同邮件系统存在些许差异，但是整体思路还是不变的，即开启邮件的SMTP服务并由客户端发送邮件。步骤说明如下：
1. 邮件系统开通SMTP，无论是QQ邮箱、网易邮箱或其他邮箱，默认应该都没有开启SMTP，因此需要申请开通；
  ![开通SMTP](/Blog/images/AODI_2.webp "开通SMTP")
2. 开通SMTP之后，需要确认对应的邮件系统是否使用默认SMTP端口，有特殊的话一般会说明，可自行查看确认；
3. 编写邮件，需要完整填写发件人邮箱地址，密码或授权码，收件人邮箱地址，SMTP服务器地址，邮件内容，信息无误便可发送邮件。

## 定时

尽管python本身可定制定时功能，但此处还是将其移至系统层面处理，分别叙述Linux和Windows下的定时方法。

### Linux

1. crontab
  用于Linux系统下定期执行任务的命令[^9]，详细使用参照[Linux使用手册<定时任务 crontab>](https://linwhitehat.github.io/Blog/2020/06/16/Linux%E4%BD%BF%E7%94%A8%E6%89%8B%E5%86%8C.html#%E5%AE%9A%E6%97%B6%E4%BB%BB%E5%8A%A1-crontab)，简单使用方法如下：
  ![crontab使用方法](/Blog/images/AODI_3.png "crontab使用方法")
  **基本格式 :**
  ``` shell
    *　　*　　*　　*　　*　　command
    # m　  h　 d　  M　  W　  命令
  ```

  第1列表示分钟1～59 每分钟用*或者 */1表示
  第2列表示小时1～23（0表示午夜0点）
  第3列表示日期1～31
  第4列表示月份1～12
  第5列标识号星期0～6（0表示星期天）
  第6列要运行的命令

2. atd
  用于Linux下只执行**一次**计划任务，在默认情况下，Linux系统是开启了atd这个服务的。如果不确认你的Linux是否开启了atd服务，请使用下面这个命令查看，若未开启可自行开启：
  ``` shell
  /etc/init.d/atd status # 查看是否开启
  /etc/init.d/atd start # 开启服务
  ```

### Windows

1. at
  根据官方文档[^10]说明，此命令适用于Windows server，使用语法如下：
  ``` shell
  at [[\\ComputerName] Hours:Minutes [/interactive] [{/every:Date[,...] | /next:Date[,...]}] Command]
  ```
2. schtasks
  此命令可定时运行指定任务，使用参数`/sc`指定定时单位如分钟，使用参数`/mo`指定时长间隔，使用参数`/tn`指定任务名称且必须唯一，使用参数`/tr`指定程序任务，使用举例如下：
  ``` shell
  # 间隔10分钟启动 notepad
  schtasks /create /sc minute /mo 10 /tn "Security Script" /tr  C:\Windows\System32\notepad.exe
  ```

## 结束
本文旨在分享小工具用于日常需求，应用场景可能不局限于此文所述，也可以将AODI封装于其他工具作为小功能。

[^1]: [微软系统使用手册](https://linwhitehat.github.io/Blog/2020/01/28/%E5%BE%AE%E8%BD%AF%E7%B3%BB%E7%BB%9F%E4%BD%BF%E7%94%A8%E6%89%8B%E5%86%8C.html)
[^2]: [Linux使用手册](https://linwhitehat.github.io/Blog/2020/06/16/Linux%E4%BD%BF%E7%94%A8%E6%89%8B%E5%86%8C.html)
[^3]: [使用Python登录QQ邮箱发送QQ邮件](https://zhuanlan.zhihu.com/p/25565454)
[^4]: [SMTP发送邮件](https://www.kancloud.cn/smilesb101/python3_x/298894#_44)
[^5]: [Python 爬虫模拟登录方法汇总](https://juejin.im/post/5bd6acdbf265da0aba710136)
[^6]: [python：利用smtplib模块发送邮件详解](https://www.cnblogs.com/insane-Mr-Li/p/9121619.html)
[^7]: [python3实例库教程 14.2. smtplib — SMTP 协议客户端](https://learnku.com/docs/pymotw/smtplib-simple-mail-transfer-protocol-client/3444)
[^8]: [linux crontab 计划任务 atd和windows下的计划任务](https://www.cnblogs.com/youxin/p/3584145.html)
[^9]: [Cron](https://zh.wikipedia.org/zh-hans/Cron)
[^10]: [Creating and managing scheduled tasks from the Command Line](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2003/cc738335(v=ws.10)?redirectedfrom=MSDN)
[^11]: [树莓派通过邮件上报实时IP，随时随地远程登录树莓派](https://www.kawabangga.com/posts/1398)