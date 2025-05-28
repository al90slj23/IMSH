# IMSH 使用演示

## 🎯 快速演示：创建您的专属VPS配置脚本

### 场景：为"超级云"公司创建定制脚本

假设您是"超级云"公司的运维工程师，需要为公司创建一个专属的VPS配置脚本。

### 第一步：运行智能配置工具

```bash
cd your-project-directory
./IMSH/install.sh
```

### 第二步：交互式配置

```
██╗███╗   ███╗███████╗██╗  ██╗
██║████╗ ████║██╔════╝██║  ██║
██║██╔████╔██║███████╗███████║
██║██║╚██╔╝██║╚════██║██╔══██║
██║██║ ╚═╝ ██║███████║██║  ██║
╚═╝╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝

==================================================
        IMSH 智能安装配置工具 v2.0.0
        让任何网站都能智能检测！
==================================================

[STEP] 配置您的智能检测脚本

请输入您的项目名称 (如: MyVPS): 超级云VPS
脚本名称建议：
  - 使用项目名.sh (如: myvps.sh)
  - 使用域名.sh (如: example.sh)
  - 保持默认 im.sh

请输入脚本名称 (默认: im.sh): supercloud.sh
请输入您的域名 (如: example.com): supercloud.com

[INFO] 配置信息：
  项目名称: 超级云VPS
  脚本名称: supercloud.sh
  域名: supercloud.com

确认配置？(y/N): y
```

### 第三步：自动检测和配置

```
[STEP] 检测项目框架...
[SUCCESS] 检测到 Laravel 框架

[STEP] 设置IMSH文件...
[INFO] 复制IMSH核心文件...
[INFO] 创建自定义脚本: supercloud.sh
[INFO] 自定义脚本内容...
[SUCCESS] 脚本内容自定义完成
[SUCCESS] IMSH文件设置完成

[STEP] 生成集成代码...
[SUCCESS] 集成指南已生成: IMSH/integration_guide.txt
```

### 第四步：查看生成结果

```
==================================================
           🎉 IMSH 配置完成！
==================================================

📁 文件结构：
  IMSH/
  ├── supercloud.sh          # 您的自定义脚本
  ├── im.sh                  # 原始脚本备份
  ├── integration_guide.txt  # 集成指南
  └── im/
      ├── im.php             # PHP检测逻辑
      ├── im.js              # Node.js检测逻辑
      └── im.py              # Python检测逻辑

🚀 下一步：
  1. 查看集成指南: cat IMSH/integration_guide.txt
  2. 按照指南修改您的路由配置
  3. 自定义脚本内容: nano IMSH/supercloud.sh
  4. 测试功能: curl supercloud.com

🎯 使用方法：
  curl -fsSL supercloud.com | bash
```

## 📋 生成的集成指南示例

```
================================================
超级云VPS 智能检测集成指南
================================================

您的配置：
- 项目名称: 超级云VPS
- 脚本名称: supercloud.sh
- 域名: supercloud.com

使用方法：
curl -fsSL supercloud.com | bash

================================================
框架集成代码：
================================================

Laravel 集成方法：

1. 修改 routes/web.php 文件，在开头添加：
   Route::any('/', function() { require_once base_path('IMSH/im/im.php'); });

================================================
测试方法：
================================================

1. 浏览器访问: http://supercloud.com
   应该显示您的正常网站

2. curl访问: curl supercloud.com
   应该返回脚本内容

3. 一键执行: curl -fsSL supercloud.com | bash
   应该执行您的VPS配置脚本
```

## 🎨 自定义脚本内容

生成的 `supercloud.sh` 脚本已自动替换品牌信息：

```bash
#!/bin/bash

# 超级云VPS - 超强大VPS一键配置脚本
# 版本: 2.0.0
# 作者: IM.SH.CN
# 网站: https://supercloud.com
# GitHub: https://github.com/al90slj23/IMSH

# ... 脚本内容
echo "        超级云VPS - 超强大VPS一键配置脚本"
echo "        网站: https://supercloud.com"
# ...
```

## 🔧 支持的框架示例

### ThinkPHP 项目
```bash
# 检测到 composer.json 中的 "topthink/framework"
[SUCCESS] 检测到 ThinkPHP 框架

# 生成的集成代码：
Route::any("/", function() { require_once root_path() . 'IMSH/im/im.php'; });
```

### Express.js 项目
```bash
# 检测到 package.json 中的 "express"
[SUCCESS] 检测到 Express.js 框架

# 生成的集成代码：
app.all('/', (req, res) => {
  const userAgent = req.get('User-Agent') || '';
  if (userAgent.toLowerCase().includes('curl')) {
    res.sendFile(path.join(__dirname, 'IMSH/supercloud.sh'));
  } else {
    res.render('index');
  }
});
```

### Django 项目
```bash
# 检测到 requirements.txt 中的 "Django"
[SUCCESS] 检测到 Django 框架

# 生成的集成代码：
def index(request):
    user_agent = request.META.get('HTTP_USER_AGENT', '').lower()
    if 'curl' in user_agent:
        with open('IMSH/supercloud.sh', 'r') as f:
            script = f.read()
        return HttpResponse(script, content_type='text/plain')
    else:
        return render(request, 'index.html')
```

## 🚀 实际效果

配置完成后：

1. **浏览器访问 supercloud.com**
   - 显示正常的网站内容
   - 用户完全无感知

2. **curl访问 supercloud.com**
   - 返回超级云VPS配置脚本
   - 包含定制的品牌信息

3. **一键执行**
   ```bash
   curl -fsSL supercloud.com | bash
   ```
   - 执行超级云VPS配置脚本
   - 显示定制的横幅和项目信息

## 💡 使用技巧

### 1. 脚本名称建议
- **公司品牌**：`companyname.sh`
- **项目名称**：`projectname.sh`
- **功能描述**：`deploy.sh`, `setup.sh`
- **域名相关**：`example.sh`

### 2. 项目名称建议
- 简洁明了：`MyVPS`, `SuperDeploy`
- 包含品牌：`阿里云助手`, `腾讯云工具`
- 功能导向：`快速部署`, `环境配置`

### 3. 后续自定义
- 编辑脚本添加专属软件安装
- 修改横幅和欢迎信息
- 添加公司特定的配置选项
- 集成内部工具和服务

## 🎯 应用场景

1. **企业内部工具**：为公司创建统一的服务器配置脚本
2. **开源项目**：为项目提供一键部署解决方案
3. **个人品牌**：创建个人技术品牌的配置工具
4. **教学演示**：为课程或培训创建专属脚本
5. **客户服务**：为客户提供定制化的部署工具

---

**🎉 现在您就拥有了一个完全定制的智能检测脚本！** 