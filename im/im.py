"""
IMSH 超级通用处理器 - Python版本
一行代码适配所有Python框架
"""

import os

def handle(request):
    """
    通用处理函数，适用于Django、Flask、FastAPI等
    """
    # 获取User-Agent
    if hasattr(request, 'META'):
        # Django
        user_agent = request.META.get('HTTP_USER_AGENT', '')
    elif hasattr(request, 'headers'):
        # Flask/FastAPI
        user_agent = request.headers.get('User-Agent', '')
    else:
        user_agent = ''
    
    # 检测是否为curl请求
    is_curl = 'curl' in user_agent.lower()
    
    if is_curl:
        # 返回shell脚本
        script_path = os.path.join(os.path.dirname(__file__), 'im.sh')
        
        if os.path.exists(script_path):
            with open(script_path, 'r', encoding='utf-8') as f:
                script = f.read()
        else:
            # 默认脚本
            script = '''#!/bin/bash
echo "欢迎使用 IM.SH 智能安装脚本"
echo "请在 IMSH/im.sh 中添加您的安装逻辑"
'''
        
        # 根据框架类型返回响应
        if hasattr(request, 'META'):
            # Django
            from django.http import HttpResponse
            response = HttpResponse(script, content_type='text/plain; charset=utf-8')
            response['Content-Disposition'] = 'inline; filename="im.sh"'
            response['Cache-Control'] = 'no-cache, no-store, must-revalidate'
            response['Pragma'] = 'no-cache'
            response['Expires'] = '0'
            return response
        else:
            # Flask/FastAPI
            try:
                from flask import Response
                response = Response(script, mimetype='text/plain')
                response.headers['Content-Disposition'] = 'inline; filename="im.sh"'
                response.headers['Cache-Control'] = 'no-cache, no-store, must-revalidate'
                response.headers['Pragma'] = 'no-cache'
                response.headers['Expires'] = '0'
                return response
            except ImportError:
                # FastAPI
                from fastapi.responses import PlainTextResponse
                return PlainTextResponse(
                    script,
                    headers={
                        'Content-Disposition': 'inline; filename="im.sh"',
                        'Cache-Control': 'no-cache, no-store, must-revalidate',
                        'Pragma': 'no-cache',
                        'Expires': '0'
                    }
                )
    else:
        # 非curl请求，返回默认HTML
        default_html = '''<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>网站正常运行</title>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; padding: 50px; }
        .container { max-width: 600px; margin: 0 auto; }
        .success { color: #28a745; }
        .code { background: #f8f9fa; padding: 10px; border-radius: 5px; margin: 20px 0; }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="success">✅ 网站正常运行</h1>
        <p>IMSH已成功集成到您的网站</p>
        <div class="code">
            <strong>一键安装命令：</strong><br>
            <code>curl -fsSL your-domain.com | bash</code>
        </div>
        <p>浏览器访问显示此页面，curl访问返回安装脚本</p>
    </div>
</body>
</html>'''
        
        # 根据框架类型返回响应
        if hasattr(request, 'META'):
            # Django
            from django.http import HttpResponse
            return HttpResponse(default_html, content_type='text/html; charset=utf-8')
        else:
            # Flask/FastAPI
            try:
                from flask import Response
                return Response(default_html, mimetype='text/html')
            except ImportError:
                # FastAPI
                from fastapi.responses import HTMLResponse
                return HTMLResponse(default_html) 