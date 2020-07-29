---
layout: post
title: Hexo博客部署PWA
date:
type:
top:
catalog: true
tags: [Hexo, PWA, gulp]
categories: [技术分享, 博客]
related_posts: true
---
渐进式网络应用程序（Progressive Web Apps，PWA）是一种运用现代的 Web API 以及传统的渐进式增强策略创建的跨平台 Web 应用程序。这类应用程序应用广泛、功能丰富，结合现代化浏览器提供的功能和移动设备的体验优势，使其具有与原生应用相同的用户体验优势。[^1]
<!-- more -->

## PWA介绍
当博客网站实现了 PWA 功能后，使用 Google Chrome 浏览器访问时，就会发现浏览器地址栏右侧有一个带圈的 ➕ 符号，并会提醒你安装此网页到桌面。如果你是用手机访问的话，Chrome 就会在页面的底部提醒你安装网站。
PWA的特点[^2]：
- 安装博客到电脑或手机，以原生应用相同的方式浏览博客；
- 博客浏览速度更快；
- 可以离线浏览博客；

1. 对于读者，博客可一触即达，且无浏览器的地址栏、菜单栏等「无关」干扰；对于博客，非常有利于博客的用户留存率，也利于博客的品牌形象;
2. 可以利用 Service Worker 的缓存特点，极大地加速你的博客;
3. 能让你的博客更贴近 APP 的形象。

PWA部署对博客具有不少要求，需要网站支持全站HTTPS、响应式布局等，具体可参见[Checklist](https://developers.google.com/web/progressive-web-apps/checklist)，同时可以在网站[Lighthouse](https://www.webpagetest.org/lighthouse)检查博客网站是否满足PWA的要求。
![Lighthouse检测结果](/Blog/images/pwa-lighthouse.webp "Lighthouse检测结果")

## PWA插件部署
Hexo支持PWA部署的插件有三款，来自网上教程[^2]的分享，三款插件各有利弊，同时另一款插件不局限于Hexo使用，且更具优点。实现PWA的Hexo插件：

|插件名称|安装方法|说明|
|-------|:-----:|--|
|[hexo-sercive-worker](https://github.com/zoumiaojiang/hexo-service-worker)|`npm install hexo-service-worker --save`|[hexo-service-worker配置](#service-worker)|
|[hexo-offline](https://github.com/JLHwung/hexo-offline)|`npm install hexo-offline --save`|[hexo-offline配置](#offline)|
|[hexo-pwa](https://github.com/lavas-project/hexo-pwa)|`npm install hexo-pwa --save`|[hexo-pwa配置](#hexo-pwa)|

### <span id="service-worker">hexo-service-worker配置</span>

在博客站点配置文件`../hexo/_config.yml`中配置`service worker`：
``` yaml
# offline config passed to sw-precache.
service_worker:
  maximumFileSizeToCacheInBytes: 5242880
  staticFileGlobs:
  - public/about/index.html
  - public/favicon.ico
  - public/manifest.json
  stripPrefix: public
  verbose: false
  runtimeCaching:
    - urlPattern: /**/*
      handler: cacheFirst
      options:
        origin: hostname
```
**配置说明**：
1. `staticFileGlobs`是首次加载时主动缓存的文件，根据自身实际修改，建议不设置博客首页即`index.html`，否则要去除首页或更新为`Workbox`时用户需要手动清除浏览器缓存才能更新，但不加上首页可能导致无法离线访问博客。
2. `origin`中`hostname`修改为博客域名。
3. 博客支持全站HTTPS。

**存在问题**
存在`sw.js`无法被浏览器识别的情况，网站无法自动更新，访问者需要手动清楚缓存才能访问最新内容。

### <span id="offline">hexo-offline配置</span>

配置与`hexo-service-worker`基本一致，在博客站点配置文件`../hexo/_config.yml`中配置`offline`：
``` yaml
# offline config passed to sw-precache.
offline:
  maximumFileSizeToCacheInBytes: 5242880
  staticFileGlobs:
  - public/about/index.html
  - public/favicon.ico
  - public/manifest.json
  stripPrefix: public
  verbose: false
  runtimeCaching:
    - urlPattern: /**/*
      handler: cacheFirst
      options:
        origin: hostname
```
配置说明参照`hexo-service-worker配置说明`。

### <span id="hexo-pwa">hexo-pwa配置</span>

此处配置已经包含`manifest.json`的配置即无需额外配置`manifest.json`，当插件运行时会自动生成`manifest.json`，在博客站点配置文件`../hexo/_config.yml`中添加以下内容：
<details>
<summary>点击查看具体代码</summary>
``` yaml
pwa:
  manifest:
    path: /manifest.json
    body:
      name: hexo
      short_name: hexo
      icons:
        - src: /images/android-chrome-192x192.png
          sizes: 192x192
          type: image/png
        - src: /images/android-chrome-512x512.png
          sizes: 512x512
          type: image/png
      start_url: /index.html
      theme_color: '#ffffff'
      background_color: '#ffffff'
      display: standalone
  serviceWorker:
    path: /sw.js
    preload:
      urls:
        - /
      posts: 5
    opts:
      networkTimeoutSeconds: 5
    routes:
      - pattern: !!js/regexp /hm.baidu.com/
        strategy: networkOnly
      - pattern: !!js/regexp /.*\.(js|css|jpg|jpeg|png|gif)$/
        strategy: cacheFirst
      - pattern: !!js/regexp /\//
        strategy: networkFirst
  priority: 5
```
</details>
**配置说明**
1. `manifest`部分即对应`manifest.json`的配置；
2. `serviceWorker`对应缓存信息配置。`preload`中`posts`表示需要缓存的文章数量，`urls`表示需要缓存的页面地址，填写格式即加入缓存页面对应的目录名称，如下：
  ``` yaml
  # 缓存首页
   - /
  # 缓存标签页
   - /tags/
   ```

### <span id="manifest">配置`manifest.json`实现PWA添加到桌面</span>

要实现PWA必须要配置`manifest.json`，因为PWA的启动需要依赖其中的配置，当前各版本浏览器对其支持情况可参照[Browser compatibility for manifest.json](https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/Browser_compatibility_for_manifest.json)。
配置`manifest.json`需要配置应用图标、名称等基本信息，在`../hexo/source`下新建`manifest.json`，基本的配置信息参照如下：
``` json
{
    "short_name": "短名称",
    "name": "这是一个完整名称",
    "icon": [
        {
            "src": "icon.png",
            "type": "image/png",
            "sizes": "512x512"
        }
    ],
    "background_color": "#2196f3",
    "display": "standalone",
    "start_url": "index.html"
}
```
配置信息也可以在[Web App Manifest Generator](https://app-manifest.firebaseapp.com/)进行生成，更多详细配置可参照LAVAS[^3]。
在博客中配置引用`manifest.json`，在博客的`<head>`标签引入，在`../next/_config.yml`主题配置文件中开启自定义文件`head.swig`（自定义主题样式可参照另一篇博客《[博客优化(Hexo博客Next主题自定义设计)](https://linwhitehat.github.io/%E5%8D%9A%E5%AE%A2%E4%BC%98%E5%8C%96.html)》），添加下属引用内容：
``` swig
<link rel="manifest" href="/manifest.json">
```
博客部署完成后，可在chrome浏览的开发者模式窗口（按`F12`）查看`Application`，即可看到配置的信息以及网站缓存信息。
![查看部署结果](/Blog/images/pwa-manifest.webp "查看部署结果")

### Workbox部署

当前博客实现PWA使用的方式，部署步骤如下：
1. 配置`manifest.json`，具体参照[配置manifest.json](#manifest)。
2. 安装[Node.js](https://nodejs.org/zh-cn/download/)（Hexo博客基于Node.js，因此跳过此步）。
3. 安装插件
  
  ``` bash
  npm install workbox-build gulp gulp-uglify readable-stream uglify-es --save-dev
  ```
4. 安装`gulp`插件
  安装`gulp`记得需要在全局环境下进行安装，不要只在博客根目录下的环境进行安装，否则会导致`gulp`无法正常执行。
  
  ``` bash
  npm install gulp --save  #安装gulp
  ```
5. 在博客站点根目录新建配置文件`../hexo/gulpfile.js`，添加内容如下：
  <details>
  <summary>点击查看具体代码</summary>
  ``` javascript
  const gulp = require("gulp");
  const workbox = require("workbox-build");
  const uglifyes = require('uglify-es');
  const composer = require('gulp-uglify/composer');
  const uglify = composer(uglifyes, console);
  const pipeline = require('readable-stream').pipeline;
  
  gulp.task('generate-service-worker', () => {
      return workbox.injectManifest({
          swSrc: './sw-template.js',
          swDest: './public/sw.js',
          globDirectory: './public',
          globPatterns: [
              "**/*.{html,css,js,json,woff2}"
          ],
          modifyURLPrefix: {
              "": "./"
          }
      });
  });
  
  gulp.task("uglify", function () {
      return pipeline(
          gulp.src("./public/sw.js"),
          uglify(),
          gulp.dest("./public")
    );
  });
  
  gulp.task("build", gulp.series("generate-service-worker", "uglify"));
  ```
  </details>
  **配置说明**
  1）`globPatterns`表示需要缓存的文件匹配模式，这里将`html`、`css`、`js`、`json`和`woff2`类型文件进行缓存，当博客首次加载时会自动缓存这些文件；
  2）若是博客使用`gulp`压缩了源码，以上配置内容与之前配置信息重复的部分可忽略。
6. 在博客站点根目录新建配置文件`../hexo/sw-template.js`，添加内容如下：
  <details>
  <summary>点击查看具体代码</summary>
  ``` javascript
  const workboxVersion = '5.0.0';
  
  importScripts(`https://storage.googleapis.com/workbox-cdn/releases/${workboxVersion}/workbox-sw.js`);
  
  workbox.core.setCacheNameDetails({
      prefix: "Blog_name"
  });
  
  workbox.core.skipWaiting();
  
  workbox.core.clientsClaim();
  
  workbox.precaching.precacheAndRoute(self.__WB_MANIFEST);
  
  workbox.precaching.cleanupOutdatedCaches();
  
  // Images
  workbox.routing.registerRoute(
      /\.(?:png|jpg|jpeg|gif|bmp|webp|svg|ico)$/,
      new workbox.strategies.CacheFirst({
          cacheName: "images",
          plugins: [
              new workbox.expiration.ExpirationPlugin({
                  maxEntries: 1000,
                  maxAgeSeconds: 60 * 60 * 24 * 30
              }),
              new workbox.cacheableResponse.CacheableResponsePlugin({
                  statuses: [0, 200]
              })
          ]
      })
  );
  
  // Fonts
  workbox.routing.registerRoute(
      /\.(?:eot|ttf|woff|woff2)$/,
      new workbox.strategies.CacheFirst({
          cacheName: "fonts",
          plugins: [
              new workbox.expiration.ExpirationPlugin({
                  maxEntries: 1000,
                  maxAgeSeconds: 60 * 60 * 24 * 30
              }),
              new workbox.cacheableResponse.CacheableResponsePlugin({
                  statuses: [0, 200]
              })
          ]
      })
  );
  
  // Google Fonts
  workbox.routing.registerRoute(
      /^https:\/\/fonts\.googleapis\.com/,
      new workbox.strategies.StaleWhileRevalidate({
          cacheName: "google-fonts-stylesheets"
      })
  );
  workbox.routing.registerRoute(
      /^https:\/\/fonts\.gstatic\.com/,
      new workbox.strategies.CacheFirst({
          cacheName: 'google-fonts-webfonts',
          plugins: [
              new workbox.expiration.ExpirationPlugin({
                  maxEntries: 1000,
                  maxAgeSeconds: 60 * 60 * 24 * 30
              }),
              new workbox.cacheableResponse.CacheableResponsePlugin({
                  statuses: [0, 200]
              })
          ]
      })
  );
  
  // Static Libraries
  workbox.routing.registerRoute(
      /^https:\/\/cdn\.jsdelivr\.net/,
      new workbox.strategies.CacheFirst({
          cacheName: "static-libs",
          plugins: [
              new workbox.expiration.ExpirationPlugin({
                  maxEntries: 1000,
                  maxAgeSeconds: 60 * 60 * 24 * 30
              }),
               new workbox.cacheableResponse.CacheableResponsePlugin({
                 statuses: [0, 200]
             })
         ]
     })
  );
  
  // External Images
  workbox.routing.registerRoute(
      /^https:\/\/raw\.githubusercontent\.com\/reuixiy\/hugo-theme-meme\/master\/static\/icons\/.*/,
      new workbox.strategies.CacheFirst({
          cacheName: "external-images",
          plugins: [
              new workbox.expiration.ExpirationPlugin({
                  maxEntries: 1000,
                  maxAgeSeconds: 60 * 60 * 24 * 30
              }),
              new workbox.cacheableResponse.CacheableResponsePlugin({
                  statuses: [0, 200]
              })
          ]
      })
  );
  
  workbox.googleAnalytics.initialize();
  ```
  </details>
  **配置说明**
  1）`prefix`参数内容`Blog_name`修改为博客名称，具体参照[Workbox_v5.0.0](https://github.com/GoogleChrome/workbox/releases)；
  2）将参数`workboxVersion`修改为最新发布版，其他内容可根据自身情况修改；
  3）其他缓存策略参考[相关文档](https://developers.google.com/web/tools/workbox/modules/workbox-strategies)，不建议缓存视频和图片。
7. 注册`Service Worker`
  
  在博客HTML页面加入`Service Worker`注册信息及页面更新提醒，在`../next/layout/_layout.swig`中找到`<body></body>`标签对，在标签内加入以下内容：
  ``` JavaScript
  <div class="app-refresh" id="app-refresh">
      <div class="app-refresh-wrap" onclick="location.reload()">
          <label>已更新最新版本</label>
          <span>点击刷新</span>
      </div>
  </div>
  
  <script>
      if ('serviceWorker' in navigator) {
          if (navigator.serviceWorker.controller) {
              navigator.serviceWorker.addEventListener('controllerchange', function() {
                  showNotification();
              });
          }
  
          window.addEventListener('load', function() {
              navigator.serviceWorker.register('/sw.js');
          });
      }
  
      function showNotification() {
          document.querySelector('meta[name=theme-color]').content = '#000';
          document.getElementById('app-refresh').className += ' app-refresh-show';
      }
  </script>
  ```
8. 添加CSS样式
  
  在自定义样式文件`../hexo/source/_data/styles.styl`中修改，添加以下内容：
  ``` css
  .app-refresh {
      background: #000;
      height: 0;
      line-height: 3em;
      overflow: hidden;
      position: fixed;
      top: 0;
      left: 0;
      right: 0;
      z-index: 42;
      padding: 0 1em;
      transition: all .3s ease;
  }
  .app-refresh-wrap {
      display: flex;
      color: #fff;
  }
  .app-refresh-wrap label {
      flex: 1;
  }
  .app-refresh-show {
      height: 3em;
  }
  ```
9. 避免`manifest.json`在部署时被修改
  
  在博客配置文件`../hexo/_config.yml`找到`skip_render`，做出以下修改：
  ``` yaml
  + skip_render: [README.md,manifest.json]
  ```
10. 部署
  
  运行以下命令：
  ``` bash
  hexo clean
  hexo g
  gulp build
  hexo d
  ```

## 结束
这篇博客是Hexo博客优化系列的补充，为博客部署PWA，使博客在多平台能快捷访问且支持离线访问，同时在部署过程中将遇到的问题及解决方式进行分享，同时感谢博主`Guan Qirui`在博客优化中给予的帮助。


[^1]: [渐进式 Web 应用（PWA）|MDN web docs](https://developer.mozilla.org/zh-CN/docs/Web/Progressive_web_apps)
[^2]: [博客实现PWA](https://guanqr.com/study/blog/realize-pwa/)
[^3]: [manifest.json 简介](https://lavas.baidu.com/pwa/engage-retain-users/add-to-home-screen/introduction)