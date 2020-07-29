<!DOCTYPE html>
<html lang="{{ config.language }}">
<head>
  {{ partial('_partials/head/head.swig', {}, {cache: theme.cache.enable}) }}
  {% include '_partials/head/head-unique.swig' %}
  {{- next_inject('head') }}
  <title>{% block title %}{% endblock %}</title>
  {{ partial('_third-party/analytics/index.swig', {}, {cache: theme.cache.enable}) }}
  {{ partial('_scripts/noscript.swig', {}, {cache: theme.cache.enable}) }}
  <link rel="stylesheet" href="/Blog/dist/css/share.min.css">
</head>

<body itemscope itemtype="http://schema.org/WebPage">
  <div class="container{%- if theme.motion.enable %} use-motion{%- endif %}">
    <div class="headband"></div>

    <header class="header" itemscope itemtype="http://schema.org/WPHeader">
      <div class="header-inner">{% include '_partials/header/index.swig' %}</div>
    </header>

    {{ partial('_partials/widgets.swig', {}, {cache: theme.cache.enable}) }}

    <main class="main">
      <div class="main-inner">
        <div class="content-wrap">
          {% include '_partials/header/sub-menu.swig' %}
          <div class="content">
            {% block content %}{% endblock %}
          </div>
          {% include '_partials/comments.swig' %}
        </div>
        {%- if theme.sidebar.display !== 'remove' %}
          {% block sidebar %}{% endblock %}
        {%- endif %}
      </div>
    </main>

    <footer class="footer">
      <div class="footer-inner">
        {{ partial('_partials/footer.swig', {}, {cache: theme.cache.enable}) }}
        {{ partial('_third-party/statistics/index.swig', {}, {cache: theme.cache.enable}) }}
      </div>
    </footer>
  </div>

  {{ partial('_scripts/index.swig', {}, {cache: theme.cache.enable}) }}
  {{ partial('_third-party/index.swig', {}, {cache: theme.cache.enable}) }}

  {%- if theme.pjax %}
    <div id="pjax">
  {%- endif %}
  {% include '_third-party/math/index.swig' %}
  {% include '_third-party/quicklink.swig' %}

  {{- next_inject('bodyEnd') }}
  {%- if theme.pjax %}
    </div>
  {%- endif %}
  
  {% if theme.leancloud_visitors.enable %}
  {% include '_third-party/statistics/lean-analytics.swig' %}
  {% endif %}
  
  <!-- 鼠标点击效果 -->
  {% if theme.cursor_effect.enable %}
    {% if theme.cursor_effect.type == "fireworks" %}
      <script type="text/javascript" src="/Blog/js/cursor/fireworks.js"></script>
    {% elseif theme.cursor_effect.type == "explosion" %}
      <canvas class="fireworks" style="position: fixed;left: 0;top: 0;z-index: 1; pointer-events: none;" ></canvas> 
      <script type="text/javascript" src="//cdn.bootcss.com/animejs/2.2.0/anime.min.js"></script> 
      <script type="text/javascript" src="/Blog/js/cursor/explosion.min.js"></script>
    {% elseif theme.cursor_effect.type == "love" %}
      <script type="text/javascript" src="/Blog/js/cursor/love.min.js"></script>
    {% elseif theme.cursor_effect.type == "text" %}
      <script type="text/javascript" src="/Blog/js/cursor/text.js"></script>
    {% endif %}
  {% endif %}
  
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
            navigator.serviceWorker.register('/Blog/sw.js');
        });
    }

    function showNotification() {
        document.querySelector('meta[name=theme-color]').content = '#000';
        document.getElementById('app-refresh').className += ' app-refresh-show';
    }
</script>

<!-- 分享 -->
<script type="text/javascript" src="/Blog/dist/js/social-share.min.js"></script>
</body>
</html>
