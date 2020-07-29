---
layout:     post
title:      Git专栏系列
subtitle:
date:       2020-02-17 18:26:17
author:     XinJ. L
type:
top:
catalog: true
tags: [Github, Gitlab, Git]
categories: [技术分享, Code]
related_posts: true
---
随着对 GitHub 和 Gitlab 使用频次增加，对版本管理和使用需求逐渐增加，学会基本的 Git 技能对于工科生已经是必备技巧了，但是还是要不断学会更加灵巧的使用，同时分布式管理版本需要有意识的做好版本信息说明，且分支、权限等设置对于 Gitlab 使用十分重要，一起学习Git吧。
<!-- more -->

## 基础

### 存储
Git 和其它版本控制系统（包括 Subversion 和近似工具）的主要差别在于 Git 对待数据的方法。 概念上来区分，其它大部分系统以文件变更列表的方式存储信息。 这类系统（CVS、Subversion、Perforce、Bazaar 等等）将它们保存的信息看作是一组基本文件和每个文件随时间逐步累积的差异。Git 不按照前述方式对待或保存数据。 反之，Git 更像是把数据看作是对小型文件系统的一组快照。 每次你提交更新，或在 Git 中保存项目状态时，它主要对当时的全部文件制作一个快照并保存这个快照的索引。 为了高效，如果文件没有修改，Git 不再重新存储该文件，而是只保留一个链接指向之前存储的文件。 Git 对待数据更像是一个 **快照流**。
![Git 数据存储处理方式](/Blog/images/git-1.png "Git 数据存储处理方式")

### 本地处理
Git 中的绝大多数操作都只需要访问本地文件和资源，一般不需要来自网络上其它计算机的信息。如果要浏览项目的历史，Git 不需外连到服务器去获取历史，然后再显示出来——它只需直接从本地数据库中读取便能立即看到项目历史。 如果想查看当前版本与一个月前的版本之间引入的修改，Git 会查找到一个月前的文件做一次本地的差异计算，而不是由远程服务器处理或从远程服务器拉回旧版本文件再来本地处理。

### 状态
Git 有三种状态，所有文件文件可能处于其中之一，包括：已提交（committed）、已修改（modified）和已暂存（staged）。

|status|committed|modified|staged|
|------|:-------:|:------:|------|
|说明|已提交表示数据已经安全的保存在本地数据库中|已修改表示修改了文件，但还没保存到数据库中|已暂存表示对一个已修改文件的当前版本做了标记，使之包含在下次提交的快照中|

由此引入 Git 项目的三个工作区域的概念：Git 仓库、工作目录以及暂存区域。
![工作目录、暂存区域以及 Git 仓库](/Blog/images/git-2.webp "工作目录、暂存区域以及 Git 仓库")

|工作区域|Git 仓库目录|工作目录|暂存区域|
|-------|:---------:|:-----:|-------|
|说明|是 Git 用来保存项目的元数据和对象数据库的地方。这是 Git 中最重要的部分，从其它计算机克隆仓库时，拷贝的就是这里的数据。|是对项目的某个版本独立提取出来的内容。这些从 Git 仓库的压缩数据库中提取出来的文件，放在磁盘上供你使用或修改。|是一个文件，保存了下次将提交的文件列表信息，一般在 Git 仓库目录中。有时候也被称作“索引”，不过一般说法还是叫暂存区域。|

### Git工作流程
依据状态而言，主要是三个步骤：
1. 在工作目录中修改文件；
2. 暂存文件，将文件的快照放入暂存区域；
3. 提交更新，找到暂存区域的文件，将快照永久性存储到 Git 仓库目录。

### Git使用
Git的使用可以基于两种方式，一种是命令行，一种是GUI。其中GUI模式可以下载使用`Github Desktop`、`Sourcetree`、`tortoiseGit`等，当前已经存在很多良好设计的GUI软件，可参照此处[^12]。本文后续使用都将基于命令行方式，因为GUI方式基本较易掌握。

### Git安装与配置
由于更多使用是在Windows平台，因此相关博文内容也是基于Windows。

#### 安装
访问[Downloading Git](https://git-scm.com/download/win)进行下载，这是 Git for Windows 项目，也叫 msysGit。

#### 配置
这里不对 Git 的配置做过多叙述，只说明用户配置，因为这个是必须配置。使用下述语句进行配置用户名和邮箱：
``` bash
git config --global user.name "Your Name"
git config --global user.email youremail@example.com
```
需要说明的是，如果使用了 `--global` 选项，那么该命令只需要运行一次，因为之后无论在此系统上做任何事情， Git 都会使用那些信息。 当针对特定项目使用不同的用户名称与邮件地址时，可以在那个项目目录下运行没有 `--global` 选项的命令来配置。

### 基本使用

当使用 Git 需要对相应命令进行查询时可以使用下述命令之一在使用手册中进行查询：
``` bash
git help <verb>
git <verb> --help
man git-<verb>
```

#### 获取 Git 仓库
一般是对 GitHub 或 Gitlab 仓库进行获取，对于刚创建的仓库，一般内容是空的或只存在`README`文件，若是空仓库，GitHub 或 Gitlab 会提示用户需要执行的操作对仓库进行初始化。此处叙述两种场景：
1. 在本地已存在的m目录中初始化仓库
在本地目录中打开`git bash`，输入`git init`，该命令将创建一个名为 `.git` 的子目录，这个子目录含有初始化的 Git 仓库中所有的必须文件，这些文件是 Git 仓库的核心。当本地目录已经存在项目内容，可以之间输入以下命令进行追踪：
``` bash
git add .
git commit -m 'initial project version'
```
2. 克隆现有的远程仓库
使用下述命令进行仓库克隆到本地：
``` bash
git clone [url]
git clone [url] localname #自定义克隆到本地的仓库名localname
```
克隆支持多种传输协议，包括`https://`、`git://`和SSH传输协议如`user@server:path/to/repo.git`，常见是使用`https://`。

#### 提交到仓库
一般提交仓库是添加内容、删除内容、添加说明、查看状态以及推送与拉取数据，其他更多详细内容可参照[^11]。

1. 检查当前文件状态，`git status`；
2. 跟踪即添加文件，`git add filename`；
3. 提交文件说明，`git commit -m "description"`；
4. 删除本地仓库内容，`git rm file`或`git rm -r folder`；
5. 推送数据到远程，`git push`；
6. 拉取数据到本地，`git pull`。

上述教程及图片来源[^11]。使用 Git 部署 Gitlab 的流程可参照[^1]或查看下述[章节内容](#Git-Connect)。

## <span id="Git-Connect">Git连接GitHub</span>

### SSH
使用 SSH 协议可以连接远程服务器和服务并向它们验证。 利用 SSH 密钥可以连接 GitHub，而无需在每次访问时提供用户名或密码。[^8]

### 检查SSH密钥
本文以 Windows 为例，在生成SSH密钥前先检查本地是否已经存在密钥，避免覆盖而影响前述配置。步骤如下：
1. 打开`git bash`；
2. 输入`ls -al ~/.ssh`查看是否存在SSH密钥，如果有则会在终端中显示存在的密钥；
3. 检查目录列表以查看是否已经有 SSH 公钥。 默认情况下，公钥的文件名是以下之一：
  - id_rsa.pub
  - id_ecdsa.pub
  - id_ed25519.pub

### 生成SSH密钥
若当前不存在SSH密钥则需要生成。生成新 SSH 密钥以用于身份验证，然后将其添加到 ssh-agent。步骤如下:
1. 打开`git bash`；
2. 输入以下内容创建以所提供的电子邮件地址为标签的新 SSH 密钥：
  ``` bash
  ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
  ```
  之后终端会显示：
  ``` bash
  > Generating public/private rsa key pair.
  ```
3. 提示“Enter a file in which to save the key（输入要保存密钥的文件）”时如下所示，按 Enter 键。 这将接受默认文件位置。
  ``` bash
  > Enter a file in which to save the key (/c/Users/you/.ssh/id_rsa):[Press enter]
  ```
4. 在提示时输入安全密码，若不输入则密码为空，但是不影响生成密钥。
  ``` bash
  > Enter passphrase (empty for no passphrase): [Type a passphrase]
  > Enter same passphrase again: [Type passphrase again]
  ```

### 将SSH密钥添加到ssh-agent
如果已安装 [GitHub Desktop](https://desktop.github.com/)，可使用它克隆仓库，而无需处理 SSH 密钥。 它还附带 `Git Bash` 工具，这是在 Windows 上运行 `git` 命令的首选方法。
添加步骤如下：
1. 确保 ssh-agent 正在运行：
  - 如果使用随 GitHub Desktop 一起安装的 Git Shell，则 ssh-agent 应该正在运行；
  - 如果使用的是其他终端提示符，例如 Git for Windows，可以根据“[使用 SSH 密钥密码](https://help.github.com/cn/github/authenticating-to-github/working-with-ssh-key-passphrases)”中的“自动启动 ssh-agent”说明进行操作，或者手动启动：
  ``` bash
  # 在后台启动 ssh-agent
  eval $(ssh-agent -s)
  > Agent pid 59566
  ```
2. 将 SSH 私钥添加到 ssh-agent。 如果创建了不同名称的密钥，或者要添加不同名称的现有密钥，请将命令中的 id_rsa 替换为对应私钥文件的名称：
  ``` bash
  ssh-add ~/.ssh/id_rsa
  ```

### 添加 SSH密钥到GitHub账号

在新增 SSH 密钥到 GitHub 帐户后，便能使用 SSH 重新配置任何本地仓库。步骤如下：
1. 复制 SSH密钥
  ``` bash
  clip < ~/.ssh/id_rsa.pub
  ```
2. 进入GitHub账号的Setting；
3. 在用户设置侧边栏中，单击 SSH and GPG keys（SSH 和 GPG 密钥）；
4. 单击 New SSH key（新 SSH 密钥）或 Add SSH key（添加 SSH 密钥）；
5. 在 "Title"（标题）字段中，为新密钥添加描述性标签；
6. 将密钥粘贴到 "Key"（密钥）字段，点击 Add SSH Key（添加SSH密钥）。

### 本地SSH测试

测试连接时，需要使用密码（即之前创建的 SSH 密钥密码）验证此操作。测试步骤如下:
1. 打开`git bash`；
2. 输入以下内容：
  ``` bash
  ssh -T git@github.com
  ```
  终端返回以下内容：
  ``` bash
  > The authenticity of host 'github.com (IP ADDRESS)' can't be established.
  > RSA key fingerprint is 16:27:ac:a5:76:28:2d:36:63:1b:56:4d:eb:df:a6:48.
  > Are you sure you want to continue connecting (yes/no)?
  ```
  或以下内容：
  ``` bash
  > The authenticity of host 'github.com (IP ADDRESS)' can't be established.
  > RSA key fingerprint is SHA256:nThbg6kXUpJWGl7E1IGOCspRomTxdCARLviKw6E5SY8.
  > Are you sure you want to continue connecting (yes/no)?
  ```
3. 验证看到的消息中的指纹匹配步骤 2 中的消息之一，然后输入 `yes`，测试成功则会看到下述内容：
  ``` bash
  > Hi username! You've successfully authenticated, but GitHub does not
  > provide shell access.
  ```
4. 验证生成的消息包含用户名；
5. 若出现权限被拒绝等错误，请参照此处[^7]。

## 特殊文件说明

### .gitkeep

这个文件之前我也没遇到过，直到最近准备在组织给建立的 Gitlab 项目上传内容时，准备将空项目`pull`下来时，发现本地目录出现了`.gitkeep`文件，由此产生好奇，进而查阅资料后发现它的作用是为了使一个空文件夹能够被正常同步，即当文件夹中没有任何内容时加入`.gitkeep`使得文件夹能够被同步。

### .gitignore

这个文件可以自行在本地 Git 根目录下创建，用于设置需要忽略的文件，使得 Git 不会处理这部分文件。配置可参照[^9]，需要忽略的文件，设置原则如下：
1. 忽略操作系统自动生成的文件，比如缩略图等；
2. 忽略编译生成的中间文件、可执行文件等，也就是如果一个文件是通过另一个文件自动生成的，那自动生成的文件就没必要放进版本库，比如Java编译产生的`.class`文件；
3. 忽略你自己的带有敏感信息的配置文件，比如存放口令的配置文件，一般是博客配置涉及的源码内容。

## 常见问题&解决

### Gitlab使用`git clone@git.xxx`被拒绝

在第一次对 Gitlab 上面的项目进行`clone`时发现服务器拒绝访问，且`22`端口无法连接通信，意味着使用`ssh`连接项目仓库时无法正常连接，发生这种情况可检查以下情况是否存在:
1. Gitlab 账号是否导入`SSH KEY`
2. 咨询所在 Gitlab 项目的组织管理员是否将`22`端口关闭，以及确认权限分配情况

这种情况下，可以使用`https`的访问方式进行项目管理，访问方式变化如下：
``` diff
- git clone git@git.123.com:abc/test.git
+ git clone https://git.123.com/abc/test.git
```

### 多个 SSH KEY 管理

当同时使用 Github 和 Gitlab 时，一般是私人和办公的情况，此时使用的邮箱账号是不同的，而要使用 Git 进行项目管理就需要配置 SSH KEY，为了避免第二次生成 SSH KEY 时将原先的 SSH KEY 覆盖，在此记录一下解决方法。

#### 已存在 Github 再配置 Gitlab

一般个人会先拥有 Github，我也是先使用了 Github，因此经过了一次配置 SSH KEY，此时在`git bash`查看本地`~/.ssh`，如果存在`id_rsa`则说明已经存在公钥，则按照下述步骤进行配置：
1. 第二个 SSH KEY生成（我是 Gitlab）
  打开`git bash`，执行以下命令，其中`email`填写自己的邮箱地址：
  ``` bash
  ssh-keygen -t rsa -C "email"
  ```
  出现以下信息时，将公钥名称做修改如下：
  ``` bash
  Generating public/private rsa key pair.
  Enter file in which to save the key (/c/Users/Yourname/.ssh/id_rsa): /c/Users/Yourname/.ssh/id_rsa_gitlab
  ```
  其中`Yourname`即Windows下用户名，输入的内容即将默认信息中的`id_rsa`进行命名修改，之后可以默认回车，也可以根据自身情况设置。
  配置完成之后，查看`~/.ssh`可以看到多出两个文件，且命名包括`id_rsa_gitlab`即完成公钥生成。
2. 由于是在微软下使用的`msysgit`，在`git bash`中输入以下内容：
  ``` bash
  eval $(ssh-agent -s)
  ```
  如果使用的是 Github 官方的bash工具，则输入`ssh-agent -s`。
  上述操作用于打开ssh-agent，否则会在添加私钥信息时报错`Could not open a connection to your authentication agent`。
3. 添加私钥
  在`git bash`中输入以下内容：
  ``` bash
  ssh-add ~/.ssh/id_rsa
  ssh-add ~/.ssh/id_rsa_gitlab
  ```
  其中`id_rsa`是我用于 Github 的密钥文件，若提示文件或目录不存在，则使用绝对地址。
4. 配置`config`
  在`~/.ssh`下创建`config`文件，添加下述内容：
  ``` diff
  + # gitlab
  +   Host git.iboxpay.com      //这里填公司的git网址
  +   HostName git.iboxpay.com  //这里填公司的git网址
  +   PreferredAuthentications publickey
  +   IdentityFile ~/.ssh/id_rsa_gitlab
  +   User zhangjun
      
  + # github
  +   Host github.com
  +   HostName github.com
  +   PreferredAuthentications publickey
  +   IdentityFile ~/.ssh/id_rsa_github
  +   User ZJsnowman
  ```
5. 在 Gitlab 添加公钥
  配置完密钥管理，在 Gitlab 的设置中添加之前生成的 SSH KEY即可。

#### 配置完Gitlab后Github不能正常管理项目

当配置了双 SSH KEY后，对原先的Github项目进行版本管理，发现在`push`的时候无法使用原先的认证信息进行远程连接，而在设置了 Gitlab 的用户信息之后（即配置`git username / git email`）发现GitHub项目管理显示项目需要用户认证，此时我存在的情况是我将全局的用户信息配置进行重置，并单独为Gitlab项目建立局部的用户信息，可能将原先的配置用户信息删除，因此重新配置全局用户信息即可正常对GitHub项目管理控制，同时可修改`config`内容如下：
``` diff
+ # github
+ # Host github.com
+ # HostName github.com
+ # PreferredAuthentications publickey
+ # IdentityFile ~/.ssh/id_rsa_github
+ # User ZJsnowman
+ Host *
+ PreferredAuthentications publickey,password
+ IdentityFile ~/.ssh/id_rsa
```

## 结束
本文是对 Git 的使用及本身遇到的一些问题及解决方法进行记录，希望能对遇到相似问题的朋友提供有用的内容。


[^1]: [Gitlab创建新项目](https://www.jianshu.com/p/c91ea165eaa4)
[^2]: [管理git生成多个SSH KEY](https://www.jianshu.com/p/f7f4142a1556)
[^3]: [git配置多个SSH KEY](https://www.awaimai.com/2200.html)
[^4]: [gitlab/github 多账户下设置 ssh keys](https://segmentfault.com/a/1190000002994742)
[^5]: [GitLab配置ssh key](https://www.cnblogs.com/hafiz/p/8146324.html)
[^6]: [同步本地文件/文件目录到gitlab](https://blog.csdn.net/hdn_kb/article/details/99413390)
[^7]: [错误：权限被拒绝（公钥）](https://help.github.com/cn/github/authenticating-to-github/error-permission-denied-publickey)
[^8]: [使用 SSH 连接到 GitHub](https://help.github.com/cn/github/authenticating-to-github/connecting-to-github-with-ssh)
[^9]: [gitignore](https://github.com/github/gitignore)
[^10]: [忽略特殊文件](https://www.liaoxuefeng.com/wiki/896043488029600/900004590234208)
[^11]: [git教程](https://git-scm.com/book/zh/v2/%E8%B5%B7%E6%AD%A5-%E5%85%B3%E4%BA%8E%E7%89%88%E6%9C%AC%E6%8E%A7%E5%88%B6)
[^12]: [Git 有哪些好用的图形化客户端](https://www.zhihu.com/question/22932048)