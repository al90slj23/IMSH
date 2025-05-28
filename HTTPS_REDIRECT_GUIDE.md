# HTTPS重定向问题解决指南

## 问题现象

当您使用 `curl im.sh.cn` 时，可能会遇到以下错误：

```html
<html>
<head><title>301 Moved Permanently</title></head>
<body>
<center><h1>301 Moved Permanently</h1></center>
<hr><center>nginx</center>
</body>
</html>
```

## 原因分析

这是因为现代网站通常启用了HTTPS重定向，当您使用HTTP访问时，服务器会返回301重定向到HTTPS版本。

## 解决方案

### ✅ 方案一：使用-L参数（推荐）

```bash
# 自动跟随重定向
curl -L im.sh.cn

# 一键执行脚本
curl -fsSL im.sh.cn | bash

# 直接跳转到指定功能
curl -fsSL im.sh.cn | bash -s -- 111
```

### ✅ 方案二：直接使用HTTPS

```bash
# 直接使用HTTPS
curl https://im.sh.cn

# 一键执行脚本
curl -fsSL https://im.sh.cn | bash

# 直接跳转到指定功能
curl -fsSL https://im.sh.cn | bash -s -- 111
```

## 参数说明

- `-f`: 失败时不显示错误页面
- `-s`: 静默模式，不显示进度条
- `-S`: 显示错误信息（与-s配合使用）
- `-L`: 自动跟随重定向（重要！）

## 推荐用法

```bash
# 🎯 最佳实践：一键安装
curl -fsSL https://im.sh.cn | bash

# 🔧 直接跳转功能
curl -fsSL https://im.sh.cn | bash -s -- 111  # 测速脚本
curl -fsSL https://im.sh.cn | bash -s -- 121  # Docker安装
curl -fsSL https://im.sh.cn | bash -s -- 131  # 系统清理
```

## 验证方法

### 检查重定向
```bash
curl -I im.sh.cn
# 应该看到：
# HTTP/1.1 301 Moved Permanently
# Location: https://im.sh.cn/
```

### 测试脚本下载
```bash
curl -L im.sh.cn | head -5
# 应该看到脚本内容：
# #!/bin/bash
# # IM.SH - VPS服务器小助手
# # 版本: 2.0.0
```

## 常见问题

### Q: 为什么不直接支持HTTP？
A: 现代网站为了安全性，通常强制使用HTTPS。这是业界标准做法。

### Q: 可以修改服务器配置支持HTTP吗？
A: 可以，但不推荐。HTTPS提供更好的安全性和SEO效果。

### Q: 其他curl工具也有这个问题吗？
A: 是的，任何使用HTTP访问启用了HTTPS重定向的网站都会遇到这个问题。

## 总结

记住这个简单的规则：
- 使用 `curl -fsSL https://domain.com` 或 `curl -L http://domain.com`
- 避免使用 `curl http://domain.com`（没有-L参数）

这样就能完美解决HTTPS重定向问题！ 