# IMSH - 智能检测框架

> **SH就是这么简单！** 一行代码让你的网站实现智能检测：浏览器访问显示正常网站，curl访问下载自定义脚本。

## 🎯 核心理念

IMSH是一个轻量级的智能检测框架，让任何网站都能在不影响正常访问的情况下，为命令行用户提供脚本下载服务。

### ✨ 核心特性

- **🔍 智能检测**: 自动识别浏览器和curl访问
- **🚀 零影响集成**: 浏览器用户完全无感知
- **📦 一行代码**: 最小侵入性，仅需一行代码
- **🌐 框架通用**: 支持10+主流Web框架
- **🛡️ SEO友好**: 搜索引擎正常索引，不影响SEO
- **⚡ 高性能**: 毫秒级检测，无性能损耗

## 🚀 快速开始

### 🎯 超简单使用（推荐）

现在支持多种使用方式，选择最适合您的：

#### 方式一：一键执行（最简单）
```bash
curl im.sh.cn | bash
```

#### 方式二：下载后运行（智能提示）
```bash
# 下载脚本（会显示智能菜单）
curl im.sh.cn > im.sh && chmod +x im.sh && ./im.sh

# 或者分步操作
curl im.sh.cn > im.sh
chmod +x im.sh
./im.sh
```

当您下载脚本后直接运行时，会看到：
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎉 IM.SH VPS小助手脚本下载成功！
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📋 您有以下选择：

1️⃣  立即运行交互式菜单
2️⃣  查看使用说明  
3️⃣  退出

请选择 [1-3]:
```

#### 方式三：直接跳转功能
```bash
curl im.sh.cn | bash -s -- 111  # 测速脚本
curl im.sh.cn | bash -s -- 121  # Docker安装
curl im.sh.cn | bash -s -- 131  # 系统清理
```

### ⚠️ HTTPS重定向处理

如果您的网站启用了HTTPS重定向（HTTP自动跳转到HTTPS），请使用以下命令：

```bash
# 推荐方式：自动跟随重定向
curl -fsSL https://yourdomain.com | bash

# 或者直接使用HTTPS
curl https://yourdomain.com

# 如果使用HTTP会遇到301重定向，需要添加-L参数
curl -L http://yourdomain.com
```

**说明**：
- 大多数现代网站都启用了HTTPS重定向
- `curl -fsSL` 中的 `-L` 参数会自动跟随重定向
- 建议直接使用HTTPS地址以获得最佳体验
- **最佳方案**：关闭强制HTTPS重定向，使用最简单的 `curl domain.com | bash`

### 第一步：下载IMSH框架
```bash
git clone https://github.com/al90slj23/IMSH.git
# 或下载到你的项目目录
```

### 第二步：自定义配置（推荐）
```bash
cd your-project-directory
./IMSH/install.sh
```

**智能配置功能：**
- 🎯 **自定义项目名称**：如 "MyVPS"、"SuperScript" 等
- 📝 **自定义脚本名称**：如 "myvps.sh"、"deploy.sh" 等  
- 🌐 **自定义域名**：自动替换脚本中的域名信息
- 🔧 **框架自动检测**：支持ThinkPHP、Laravel、Express.js等
- 📋 **生成集成指南**：针对您的框架提供具体代码

### 第三步：一行代码集成

#### ThinkPHP 6.x
```php
// route/app.php
Route::any("/", function() { require_once root_path() . 'IMSH/im/im.php'; });
```

#### Laravel 8.x/9.x/10.x/11.x
```php
// routes/web.php
Route::any('/', function() { require_once base_path('IMSH/im/im.php'); });
```

#### Express.js (Node.js)
```javascript
// app.js
app.all('/', (req, res) => {
    const userAgent = req.get('User-Agent') || '';
    if (userAgent.toLowerCase().includes('curl')) {
        res.sendFile(path.join(__dirname, 'IMSH/im.sh'));
    } else {
        // 调用你的原有首页逻辑
        res.render('index');
    }
});
```

#### Django (Python)
```python
# views.py
def index(request):
    user_agent = request.META.get('HTTP_USER_AGENT', '').lower()
    if 'curl' in user_agent:
        with open('IMSH/im.sh', 'r') as f:
            script = f.read()
        return HttpResponse(script, content_type='text/plain')
    else:
        // 调用你的原有首页逻辑
        return render(request, 'index.html')
```

#### Flask (Python)
```python
# app.py
@app.route('/')
def index():
    user_agent = request.headers.get('User-Agent', '').lower()
    if 'curl' in user_agent:
        return send_file('IMSH/im.sh', mimetype='text/plain')
    else:
        // 调用你的原有首页逻辑
        return render_template('index.html')
```

#### Spring Boot (Java)
```java
@Controller
public class IndexController {
    @RequestMapping("/")
    public ResponseEntity<?> index(HttpServletRequest request) {
        String userAgent = request.getHeader("User-Agent");
        if (userAgent != null && userAgent.toLowerCase().contains("curl")) {
            // 返回脚本文件
            Resource resource = new ClassPathResource("IMSH/im.sh");
            return ResponseEntity.ok()
                .contentType(MediaType.TEXT_PLAIN)
                .body(resource);
        } else {
            // 调用你的原有首页逻辑
            return ResponseEntity.ok("index");
        }
    }
}
```

#### ASP.NET Core (C#)
```csharp
[Route("/")]
public IActionResult Index()
{
    var userAgent = Request.Headers["User-Agent"].ToString().ToLower();
    if (userAgent.Contains("curl"))
    {
        var scriptPath = Path.Combine(Directory.GetCurrentDirectory(), "IMSH", "im.sh");
        return PhysicalFile(scriptPath, "text/plain");
    }
    else
    {
        // 调用你的原有首页逻辑
        return View();
    }
}
```

#### 原生PHP
```php
<?php
// index.php
$userAgent = $_SERVER['HTTP_USER_AGENT'] ?? '';
if (stripos($userAgent, 'curl') !== false) {
    header('Content-Type: text/plain');
    readfile('IMSH/im.sh');
    exit;
} else {
    // 你的原有首页逻辑
    include 'your-original-index.php';
}
?>
```

### 第四步：自定义你的脚本

编辑 `IMSH/im.sh` 文件，添加你想要的安装逻辑：

```bash
#!/bin/bash
echo "欢迎使用我的VPS配置脚本！"

# 添加你的安装逻辑
install_my_software() {
    echo "安装我的软件..."
    # 你的安装命令
}

# 调用安装函数
install_my_software
```

## 🎨 实际效果演示

### 浏览器访问
```
用户在浏览器中访问 https://yourdomain.com
↓
显示你的正常网站内容（完全不受影响）
```

### curl访问
```bash
# 简单方式（推荐，需关闭强制HTTPS）
curl yourdomain.com | bash

# 或者使用HTTPS
curl https://yourdomain.com | bash

# 自动跟随重定向
curl -fsSL yourdomain.com | bash
```

## 🌟 成功案例

### im.sh.cn
- **网站功能**: 我的首航书签管理系统
- **浏览器访问**: 完整的Web应用界面
- **curl访问**: 超强VPS配置脚本
- **集成方式**: ThinkPHP 6 + 一行路由代码
- **效果**: 完美运行，零影响

## 📋 完整功能列表

```bash
# 测试脚本
curl im.sh.cn | bash -s -- 111  # 测速脚本
curl im.sh.cn | bash -s -- 112  # 网络测试
curl im.sh.cn | bash -s -- 113  # 硬件测试
curl im.sh.cn | bash -s -- 114  # 系统测试

# 安装脚本
curl im.sh.cn | bash -s -- 121  # Docker安装
curl im.sh.cn | bash -s -- 122  # 环境配置
curl im.sh.cn | bash -s -- 123  # 软件安装
curl im.sh.cn | bash -s -- 124  # 系统优化

# 维护脚本
curl im.sh.cn | bash -s -- 131  # 系统清理
curl im.sh.cn | bash -s -- 132  # 日志管理
curl im.sh.cn | bash -s -- 133  # 备份恢复
curl im.sh.cn | bash -s -- 134  # 安全检查

# 监控脚本
curl im.sh.cn | bash -s -- 141  # 性能监控
curl im.sh.cn | bash -s -- 142  # 资源监控
curl im.sh.cn | bash -s -- 143  # 服务监控
curl im.sh.cn | bash -s -- 144  # 告警设置

# 工具脚本
curl im.sh.cn | bash -s -- 151  # 文件管理
curl im.sh.cn | bash -s -- 152  # 进程管理
curl im.sh.cn | bash -s -- 153  # 网络工具
curl im.sh.cn | bash -s -- 154  # 系统信息
```

## 🔧 工作原理

### 智能检测逻辑
```
1. 用户访问网站首页
2. 检测 User-Agent 头部
3. 如果包含 "curl" → 返回脚本文件
4. 如果是浏览器 → 调用原有首页逻辑
```

### 技术特点
- **毫秒级检测**: User-Agent检测极快
- **零性能影响**: 仅增加一次字符串检查
- **完全透明**: 浏览器用户完全无感知
- **SEO友好**: 搜索引擎爬虫正常访问
- **缓存兼容**: 不影响CDN和缓存策略

## 📁 目录结构

```
IMSH/
├── README.md           # 框架集成说明（本文件）
├── SCRIPT_README.md    # im.sh脚本功能说明
├── install.sh          # 框架安装脚本
├── im.sh               # 你的自定义脚本
└── im/
    ├── im.php          # PHP检测逻辑
    ├── im.js           # Node.js检测逻辑
    └── im.py           # Python检测逻辑
```

## 🛠️ 高级配置

### 智能安装配置工具

使用 `install.sh` 可以快速配置您的专属智能检测脚本：

```bash
./IMSH/install.sh
```

**配置选项：**
- **项目名称**：自定义您的项目品牌（如：MyVPS、SuperDeploy）
- **脚本名称**：自定义脚本文件名（如：myvps.sh、deploy.sh）
- **域名设置**：自动替换脚本中的域名信息
- **框架检测**：自动识别并生成对应的集成代码

**生成文件：**
```
IMSH/
├── your-script.sh          # 您的自定义脚本
├── im.sh                   # 原始脚本备份
├── integration_guide.txt   # 专属集成指南
└── im/
    ├── im.php              # 自动更新脚本路径
    ├── im.js               # 自动更新脚本路径
    └── im.py               # 自动更新脚本路径
```

### 品牌化定制

安装工具会自动替换脚本中的品牌信息：

```bash
# 原始脚本
# IM.SH - 超强大VPS一键配置脚本
# 网站: https://im.sh.cn

# 自定义后
# MyVPS - 超强大VPS一键配置脚本  
# 网站: https://yourdomain.com
```

### 自定义检测逻辑
你可以修改 `im/im.php` 来自定义检测逻辑：

```php
<?php
// 自定义User-Agent检测
function isScriptRequest() {
    $userAgent = $_SERVER['HTTP_USER_AGENT'] ?? '';
    
    // 检测curl、wget等命令行工具
    $cliTools = ['curl', 'wget', 'httpie', 'lynx'];
    
    foreach ($cliTools as $tool) {
        if (stripos($userAgent, $tool) !== false) {
            return true;
        }
    }
    
    return false;
}

if (isScriptRequest()) {
    // 返回脚本
    header('Content-Type: text/plain');
    readfile(__DIR__ . '/../im.sh');
    exit;
} else {
    // 调用原有逻辑
    require_once __DIR__ . '/../../app/controller/Index.php';
    $controller = new \app\controller\Index();
    return $controller->index();
}
?>
```

### 多脚本支持
```php
// 根据不同参数返回不同脚本
$script = $_GET['script'] ?? 'default';

switch ($script) {
    case 'docker':
        readfile(__DIR__ . '/../scripts/docker.sh');
        break;
    case 'nodejs':
        readfile(__DIR__ . '/../scripts/nodejs.sh');
        break;
    default:
        readfile(__DIR__ . '/../im.sh');
        break;
}
```

### 访问统计
```php
// 记录脚本下载统计
if (isScriptRequest()) {
    $logFile = __DIR__ . '/../logs/download.log';
    $logEntry = date('Y-m-d H:i:s') . " - " . $_SERVER['REMOTE_ADDR'] . " - " . $_SERVER['HTTP_USER_AGENT'] . "\n";
    file_put_contents($logFile, $logEntry, FILE_APPEND | LOCK_EX);
}
```

## 🔍 故障排除

### 常见问题

1. **脚本无法下载**
   - 检查文件路径是否正确
   - 确保im.sh文件有读取权限
   - 验证路由配置是否生效

2. **浏览器显示脚本内容**
   - 检查User-Agent检测逻辑
   - 确认原有首页逻辑正确调用
   - 清除浏览器缓存

3. **框架集成问题**
   - 确保路由优先级正确
   - 检查框架版本兼容性
   - 查看错误日志

4. **HTTPS重定向问题**
   - 使用 `curl -L` 或 `curl -fsSL` 参数
   - 或者关闭强制HTTPS重定向（推荐）
   - 直接使用HTTPS地址

### 调试方法
```bash
# 测试curl访问
curl -v https://yourdomain.com

# 测试浏览器User-Agent
curl -H "User-Agent: Mozilla/5.0" https://yourdomain.com

# 查看服务器日志
tail -f /var/log/nginx/access.log

# 检查重定向
curl -I yourdomain.com
```

## 🎯 推广优势

### 关闭HTTPS重定向的优势

**"一行命令，搞定VPS！"**
```bash
curl im.sh.cn | bash
```

- ✅ **超简单**: 比 `curl -fsSL https://im.sh.cn | bash` 简洁50%
- ✅ **易记忆**: 更容易在社交媒体传播
- ✅ **兼容性**: 支持所有curl版本
- ✅ **用户友好**: 降低学习成本

### 其他工具兼容

```bash
# wget也能正常工作
wget -qO- im.sh.cn | bash

# 各种curl版本都兼容
curl im.sh.cn | bash        # 标准版本
curl -s im.sh.cn | bash     # 静默模式
curl -f im.sh.cn | bash     # 失败时退出
```

## 🤝 贡献

欢迎贡献更多框架的集成方案！

1. Fork 项目
2. 添加新框架的集成代码
3. 更新README文档
4. 提交Pull Request

## 📄 许可证

MIT License - 自由使用、修改和分发。

## 📚 相关链接

- **🌐 官网**: https://im.sh.cn
- **📖 GitHub**: https://github.com/al90slj23/IMSH
- **🐛 问题反馈**: https://github.com/al90slj23/IMSH/issues
- **📋 脚本功能说明**: [SCRIPT_README.md](SCRIPT_README.md)

---

**🚀 IMSH - 让任何网站都能智能检测！**

> 一行代码，双重体验。浏览器用户看网站，命令行用户得脚本！ 