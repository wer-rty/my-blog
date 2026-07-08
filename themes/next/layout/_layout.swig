<!DOCTYPE html>
<html lang="{{ config.language }}">
<head>
  {{ partial('_partials/head/head.swig', {}, {cache: theme.cache.enable}) }}
  {% include '_partials/head/head-unique.swig' %}
  {{- next_inject('head') }}
  <title>{% block title %}{% endblock %}</title>
  {{ partial('_third-party/analytics/index.swig', {}, {cache: theme.cache.enable}) }}
  {{ partial('_scripts/noscript.swig', {}, {cache: theme.cache.enable}) }}
  <script src="https://cdn.jsdelivr.net/npm/jquery/dist/jquery.min.js"></script>
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
          <div class="content {% block class %}{% endblock %}">
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
        {% include '_partials/languages.swig' %}
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

 <!-- 添加烟花特效 -->
  {% if theme.fireworks %}
    <canvas class="fireworks" style="position: fixed; left: 0; top: 0; z-index: 1; pointer-events: none;"></canvas>
    <script type="text/javascript" src="//cdn.bootcss.com/animejs/2.2.0/anime.min.js"></script>
    <script type="text/javascript" src="/js/fireworks.js"></script>
  {% endif %}
 
<!-- 花瓣飘落特效 -->
<link rel="stylesheet" href="/js/sakura.min.css">
<script src="/js/sakura.min.js"></script>
<script>
  // 确保 DOM 加载完成后初始化
  document.addEventListener('DOMContentLoaded', function() {
    var sakura = new Sakura('body', {
      fallSpeed: 1.5,           // 下落速度（数值越大越慢）
      maxSize: 18,               // 花瓣最大尺寸
      minSize: 10,               // 花瓣最小尺寸
      delay: 200,                // 生成花瓣的间隔时间（毫秒）
      colors: [
        {
          gradientColorStart: 'rgba(255, 183, 197, 0.9)',  // 淡粉色
          gradientColorEnd: 'rgba(255, 197, 208, 0.9)',
          gradientColorDegree: 120
        },
        {
          gradientColorStart: 'rgba(212, 152, 163, 0.9)',  // 粉紫色
          gradientColorEnd: 'rgba(242, 185, 196, 0.9)',
          gradientColorDegree: 120
        }
      ]
    });
  });
</script>
 
</body>
</html>
