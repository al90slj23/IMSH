/**
 * IMSH 超级通用处理器 - Node.js版本
 * 一行代码适配所有Node.js框架
 * 使用方法：require('./IMSH/universal.js')(req, res);
 */

const fs = require('fs');
const path = require('path');

module.exports = function(req, res) {
    // 获取User-Agent
    const userAgent = req.headers['user-agent'] || '';
    const isCurl = userAgent.toLowerCase().includes('curl');
    
    if (isCurl) {
        // 返回shell脚本
        const scriptPath = path.join(__dirname, 'im.sh');
        
        let script;
        if (fs.existsSync(scriptPath)) {
            script = fs.readFileSync(scriptPath, 'utf8');
        } else {
            script = `#!/bin/bash
echo "欢迎使用 IM.SH 智能安装脚本"
echo "请在 IMSH/im.sh 中添加您的安装逻辑"`;
        }
        
        // 设置响应头
        res.setHeader('Content-Type', 'text/plain; charset=utf-8');
        res.setHeader('Content-Disposition', 'inline; filename="im.sh"');
        res.setHeader('Cache-Control', 'no-cache, no-store, must-revalidate');
        res.setHeader('Pragma', 'no-cache');
        res.setHeader('Expires', '0');
        
        res.send(script);
        return;
    }
    
    // 非curl请求，返回默认HTML
    const defaultHTML = `<!DOCTYPE html>
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
            <code>curl -fsSL ${req.headers.host} | bash</code>
        </div>
        <p>浏览器访问显示此页面，curl访问返回安装脚本</p>
    </div>
</body>
</html>`;
    
    res.setHeader('Content-Type', 'text/html; charset=utf-8');
    res.send(defaultHTML);
}; 