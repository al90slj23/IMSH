# IMSH - 智能检测安装脚本

> **IM就是这么简单！** 一行代码实现智能检测：浏览器访问显示网站，curl访问下载脚本。

## 🚀 功能特性

- **智能检测**: 自动识别User-Agent，区分浏览器和curl请求
- **完全透明**: 浏览器访问时显示原网站内容，无任何影响
- **一键安装**: `curl -fsSL yourdomain.com | bash` 即可执行安装
- **框架通用**: 支持ThinkPHP、Laravel、Express.js等主流框架
- **最小侵入**: 仅需修改一行路由代码即可集成

## 📦 项目结构

```
IMSH/
├── im.sh              # 主安装脚本（185行）
├── im/
│   ├── im.php         # PHP通用处理器（218行）
│   ├── im.js          # Node.js处理器
│   └── im.py          # Python处理器
├── install.sh         # 自动安装工具
└── README.md          # 说明文档
```

## 🎯 工作原理

1. **检测请求类型**：
   - User-Agent包含'curl' → 返回shell脚本
   - 其他请求 → 调用原网站逻辑

2. **完全透明集成**：
   - 浏览器用户看到的仍是原网站
   - curl用户获得安装脚本
   - 对SEO和用户体验零影响

## 🛠️ 快速集成

### ThinkPHP 6.x

修改 `route/app.php`：

```php
<?php
use think\facade\Route;

// IMSH 超级一行代码集成方案 - IM就是这么简单！
Route::any("/", function() { require_once root_path() . 'IMSH/im/im.php'; });

// ... 其他路由保持不变
```

### Laravel 8.x/9.x/10.x

修改 `routes/web.php`：

```php
<?php
use Illuminate\Support\Facades\Route;

// IMSH 集成
Route::any('/', function() { require_once base_path('IMSH/im/im.php'); });

// ... 其他路由
```

### Express.js (Node.js)

修改主应用文件：

```javascript
const express = require('express');
const app = express();

// IMSH 集成
app.all('/', (req, res) => {
    if (req.get('User-Agent').includes('curl')) {
        res.sendFile(path.join(__dirname, 'IMSH/im.sh'));
    } else {
        // 调用原有首页逻辑
        res.render('index');
    }
});
```

### Django (Python)

修改 `urls.py`：

```python
from django.urls import path
from . import views

urlpatterns = [
    path('', views.imsh_handler, name='home'),
    # ... 其他URL
]
```

在 `views.py` 中：

```python
from django.http import HttpResponse
from django.shortcuts import render

def imsh_handler(request):
    user_agent = request.META.get('HTTP_USER_AGENT', '')
    if 'curl' in user_agent.lower():
        with open('IMSH/im.sh', 'r') as f:
            script = f.read()
        return HttpResponse(script, content_type='text/plain')
    else:
        return render(request, 'index.html')
```

## 📋 安装脚本功能

`im.sh` 脚本包含以下功能：

- ✅ 自动检测Linux发行版（Ubuntu/Debian/CentOS/Fedora/Arch等）
- ✅ 识别包管理器（APT/YUM/DNF/Pacman/Zypper）
- ✅ 检查root权限和sudo可用性
- ✅ 彩色日志输出
- ✅ 更新系统包
- ✅ 安装基础工具（curl/wget/git/vim/htop/tree）
- ✅ 完整错误处理

## 🔧 自定义安装脚本

您可以根据需要修改 `IMSH/im.sh` 文件，添加自己的安装逻辑：

```bash
#!/bin/bash
# 在这里添加您的自定义安装逻辑

# 安装Docker
install_docker() {
    log_info "正在安装Docker..."
    curl -fsSL https://get.docker.com | bash
    log_success "Docker安装完成"
}

# 安装Node.js
install_nodejs() {
    log_info "正在安装Node.js..."
    curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
    $SUDO_CMD apt-get install -y nodejs
    log_success "Node.js安装完成"
}

# 在main函数中调用
main() {
    # ... 现有逻辑
    install_docker
    install_nodejs
    # ... 
}
```

## 🌟 使用示例

### 用户使用方式

```bash
# 一键安装
curl -fsSL yourdomain.com | bash

# 下载后执行
curl -fsSL yourdomain.com -o install.sh
chmod +x install.sh
./install.sh
```

### 浏览器访问

用户通过浏览器访问 `yourdomain.com` 时，看到的是完整的原网站内容，完全不受影响。

## 🎨 成功案例

- **im.sh.cn**: 我的首航书签网站 + Linux工具安装
- 浏览器访问：显示书签管理界面
- curl访问：下载Linux环境配置脚本

## 📚 更多框架支持

### CodeIgniter 4.x

```php
// app/Config/Routes.php
$routes->add('/', function() {
    require_once ROOTPATH . 'IMSH/im/im.php';
});
```

### Symfony 5.x/6.x

```php
// config/routes.yaml
imsh:
    path: /
    controller: App\Controller\ImshController::index
```

### Yii2

```php
// config/web.php
'urlManager' => [
    'rules' => [
        '' => 'site/imsh',
    ],
],
```

### Flask (Python)

```python
from flask import Flask, request, send_file

app = Flask(__name__)

@app.route('/')
def imsh_handler():
    user_agent = request.headers.get('User-Agent', '')
    if 'curl' in user_agent.lower():
        return send_file('IMSH/im.sh', mimetype='text/plain')
    else:
        return render_template('index.html')
```

### Spring Boot (Java)

```java
@RestController
public class ImshController {
    
    @RequestMapping("/")
    public ResponseEntity<?> handleRoot(HttpServletRequest request) {
        String userAgent = request.getHeader("User-Agent");
        if (userAgent != null && userAgent.toLowerCase().contains("curl")) {
            // 返回脚本文件
            return ResponseEntity.ok()
                .contentType(MediaType.TEXT_PLAIN)
                .body(readScriptFile());
        } else {
            // 返回正常页面
            return ResponseEntity.ok("index");
        }
    }
}
```

### ASP.NET Core (C#)

```csharp
[Route("/")]
public IActionResult Index()
{
    var userAgent = Request.Headers["User-Agent"].ToString();
    if (userAgent.ToLower().Contains("curl"))
    {
        var script = System.IO.File.ReadAllText("IMSH/im.sh");
        return Content(script, "text/plain");
    }
    else
    {
        return View();
    }
}
```

## 🔍 故障排除

### 常见问题

1. **404错误**: 检查nginx/Apache配置，确保支持PHP
2. **权限错误**: 确保IMSH目录有读取权限
3. **脚本无法执行**: 检查im.sh文件权限和格式

### 调试模式

在 `im.php` 中启用调试：

```php
// 在文件开头添加
error_reporting(E_ALL);
ini_set('display_errors', 1);
```

## 📄 许可证

MIT License - 自由使用、修改和分发。

## 🤝 贡献

欢迎提交Issue和Pull Request！

---

**IMSH - 让安装脚本分发变得简单优雅** 🚀 