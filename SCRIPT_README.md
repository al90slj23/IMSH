# IM.SH v2.0.0 - 超强大VPS配置脚本

> **一行命令，完整环境！** 从此告别繁琐的VPS配置，让服务器部署变得简单强大。

## 🚀 快速使用

### 🎯 一键安装（推荐）
```bash
curl -fsSL https://im.sh.cn | bash
```

### 🔧 命令行模式
```bash
# 完整安装所有组件
curl -fsSL https://im.sh.cn | bash -s -- --full

# 仅安装Docker环境
curl -fsSL https://im.sh.cn | bash -s -- --docker

# 安装Web开发环境
curl -fsSL https://im.sh.cn | bash -s -- --web

# 系统安全加固
curl -fsSL https://im.sh.cn | bash -s -- --security

# 性能优化
curl -fsSL https://im.sh.cn | bash -s -- --performance

# 查看帮助
curl -fsSL https://im.sh.cn | bash -s -- --help
```

## ✨ 全新功能特性

- **🎨 精美界面**: ASCII艺术横幅 + 彩色交互界面
- **🔧 智能安装**: 7种安装模式，满足不同需求
- **🐳 容器化**: Docker + Docker Compose 一键部署
- **🌐 全栈环境**: Node.js + Python + Nginx 完整Web栈
- **🛡️ 安全加固**: 防火墙 + SSH安全 + 系统加固
- **⚡ 性能优化**: BBR加速 + 内核调优 + 监控工具
- **🎯 实用工具**: 50+别名命令 + 系统监控 + 快捷操作

## 🎛️ 交互式安装菜单

运行脚本后，您将看到精美的交互界面：

```
██╗███╗   ███╗   ███████╗██╗  ██╗
██║████╗ ████║   ██╔════╝██║  ██║
██║██╔████╔██║   ███████╗███████║
██║██║╚██╔╝██║   ╚════██║██╔══██║
██║██║ ╚═╝ ██║██╗███████║██║  ██║
╚═╝╚═╝     ╚═╝╚═╝╚══════╝╚═╝  ╚═╝

==================================================
        IM.SH - 超强大VPS一键配置脚本
        版本: 2.0.0
        网站: https://im.sh.cn
==================================================

请选择安装模式：
1) 🚀 完整安装 (推荐) - 安装所有组件
2) 🔧 自定义安装 - 选择要安装的组件  
3) 📦 仅基础工具 - 只安装基础工具
4) 🐳 Docker环境 - 安装Docker相关
5) 🌐 Web环境 - 安装Nginx + Node.js + Python
6) 🛡️ 安全加固 - 防火墙 + SSH安全
7) ⚡ 性能优化 - 系统调优
0) 退出
```

## 📦 安装组件详情

### 🔧 基础工具包
- **系统工具**: curl, wget, git, vim, nano, htop, tree
- **压缩工具**: unzip, zip, tar
- **终端工具**: screen, tmux
- **编译工具**: build-essential, gcc, make

### 🐳 Docker环境
- **Docker Engine**: 最新稳定版
- **Docker Compose**: 容器编排工具
- **用户权限**: 自动配置docker组权限
- **服务管理**: 自动启动和开机自启

### 🌐 Node.js环境
- **Node.js**: 最新LTS版本
- **包管理器**: npm, yarn, pnpm
- **进程管理**: PM2 (生产环境进程管理)
- **全局工具**: 常用开发工具包

### 🐍 Python环境
- **Python3**: 最新版本 + pip
- **虚拟环境**: virtualenv, pipenv, poetry
- **常用库**: requests, beautifulsoup4, flask, django
- **开发工具**: 完整Python开发栈

### 🌍 Nginx Web服务器
- **Nginx**: 高性能Web服务器
- **自动配置**: 开机自启 + 基础配置
- **防火墙**: 自动开放80/443端口
- **SSL就绪**: 支持HTTPS配置

### 🛡️ 安全加固
- **防火墙**: UFW(Ubuntu) / Firewalld(CentOS)
- **SSH安全**: 禁用root登录 + 密钥认证
- **端口管理**: 仅开放必要端口(22/80/443)
- **配置备份**: 自动备份原始配置

### ⚡ 性能优化
- **网络优化**: BBR拥塞控制算法
- **内核参数**: TCP缓冲区优化
- **文件系统**: 文件描述符限制优化
- **内存管理**: Swap使用策略调优

### 📊 监控工具
- **系统监控**: htop (进程监控)
- **IO监控**: iotop (磁盘IO监控)
- **网络监控**: nethogs (网络流量监控)
- **磁盘分析**: ncdu (磁盘使用分析)

### 🎯 实用别名
安装完成后，您将获得50+实用别名：

```bash
# 系统信息
sysinfo     # 系统详细信息
meminfo     # 内存使用情况
diskinfo    # 磁盘使用情况
cpuinfo     # CPU信息
myip        # 公网IP地址

# Docker快捷命令
dps         # docker ps
dpsa        # docker ps -a
di          # docker images
dstop       # 停止所有容器
drm         # 删除所有容器

# 进程管理
psg <name>  # 搜索进程
topcpu      # CPU使用率最高的进程
topmem      # 内存使用率最高的进程

# 系统维护
update      # 系统更新
install     # 软件安装
ports       # 查看端口占用
```

## 📋 系统支持

### ✅ 支持的Linux发行版
- **Ubuntu** 18.04+ (APT)
- **Debian** 9+ (APT)  
- **CentOS** 7+ (YUM)
- **RHEL** 7+ (YUM)
- **Fedora** 30+ (DNF)
- **Arch Linux** (Pacman)
- **openSUSE** (Zypper)

### 🔍 智能检测
脚本会自动检测：
- 操作系统类型和版本
- 包管理器类型
- 用户权限（root/sudo）
- 已安装的软件包

## 🔍 安装日志

所有安装过程都会记录到 `/var/log/imsh-install.log`，方便问题排查：

```bash
# 查看安装日志
tail -f /var/log/imsh-install.log

# 搜索错误信息
grep ERROR /var/log/imsh-install.log

# 查看成功安装的组件
grep SUCCESS /var/log/imsh-install.log
```

## 🎨 安装完成效果

安装完成后，您将看到详细的总结信息：

```
==================================================
           🎉 IM.SH 安装完成！
==================================================

✅ 安装的组件：
  ✅ 基础工具 (curl, wget, git, vim, htop, tree等)
  ✅ Docker & Docker Compose
  ✅ Node.js & NPM (PM2, Yarn, PNPM)
  ✅ Python3 & Pip
  ✅ Nginx Web服务器
  ✅ 防火墙配置
  ✅ SSH安全加固
  ✅ 系统性能优化
  ✅ 监控工具
  ✅ 有用的别名和函数

🔧 常用命令：
  docker --version    # 查看Docker版本
  node --version      # 查看Node.js版本
  python3 --version   # 查看Python版本
  nginx -v            # 查看Nginx版本
  htop                # 系统监控
  myip                # 查看公网IP

📚 更多信息: https://im.sh.cn
🐛 问题反馈: https://github.com/al90slj23/IMSH
```

## 🛠️ 高级用法

### 环境变量配置
```bash
# 设置安装选项
export IMSH_SKIP_DOCKER=1      # 跳过Docker安装
export IMSH_SKIP_NODEJS=1      # 跳过Node.js安装
export IMSH_CUSTOM_NGINX=1     # 使用自定义Nginx配置

curl -fsSL https://im.sh.cn | bash
```

### 批量部署
```bash
# 创建批量部署脚本
#!/bin/bash
servers=("server1.com" "server2.com" "server3.com")

for server in "${servers[@]}"; do
    echo "部署到 $server..."
    ssh root@$server "curl -fsSL https://im.sh.cn | bash -s -- --full"
done
```

### 自定义脚本
您可以基于im.sh创建自己的定制版本：

```bash
#!/bin/bash
# 下载原始脚本
curl -fsSL https://im.sh.cn > my-custom-script.sh

# 添加自定义函数
cat >> my-custom-script.sh << 'EOF'

# 自定义安装函数
install_my_software() {
    log_step "安装我的自定义软件..."
    
    # 安装您的软件
    $SUDO_CMD apt-get install -y your-software
    
    # 配置您的服务
    $SUDO_CMD systemctl enable your-service
    $SUDO_CMD systemctl start your-service
    
    log_success "自定义软件安装完成"
}

# 在完整安装中调用
full_install() {
    # ... 原有逻辑
    install_my_software
    # ...
}
EOF

# 运行自定义脚本
bash my-custom-script.sh
```

## 🔧 故障排除

### 常见问题

1. **权限错误**
   ```bash
   # 确保有sudo权限或使用root用户
   sudo curl -fsSL https://im.sh.cn | bash
   ```

2. **网络问题**
   ```bash
   # 使用代理
   export https_proxy=http://proxy:port
   curl -fsSL https://im.sh.cn | bash
   ```

3. **包管理器问题**
   ```bash
   # 手动更新包管理器
   sudo apt update  # Ubuntu/Debian
   sudo yum update  # CentOS/RHEL
   ```

4. **Docker权限问题**
   ```bash
   # 重新登录以应用docker组权限
   su - $USER
   # 或者重启系统
   ```

### 调试模式
```bash
# 启用详细输出
curl -fsSL https://im.sh.cn | bash -x

# 查看安装日志
tail -f /var/log/imsh-install.log

# 检查特定组件
docker --version
node --version
python3 --version
nginx -v
```

## 🌟 使用案例

### 开发环境快速搭建
```bash
# 新VPS快速配置开发环境
curl -fsSL https://im.sh.cn | bash -s -- --web
```

### 生产服务器部署
```bash
# 生产环境安全配置
curl -fsSL https://im.sh.cn | bash -s -- --full
```

### Docker容器化部署
```bash
# 仅安装Docker环境
curl -fsSL https://im.sh.cn | bash -s -- --docker
```

### 系统性能调优
```bash
# 仅进行性能优化
curl -fsSL https://im.sh.cn | bash -s -- --performance
```

## 📊 性能优化详情

### 网络优化
- **BBR拥塞控制**: 提升网络传输效率
- **TCP缓冲区**: 优化网络吞吐量
- **连接数限制**: 提高并发处理能力

### 系统优化
- **文件描述符**: 提升文件处理能力
- **内存管理**: 优化Swap使用策略
- **内核参数**: 针对服务器场景调优

### 监控配置
- **实时监控**: htop, iotop, nethogs
- **磁盘分析**: ncdu磁盘使用分析
- **进程管理**: 快速查找和管理进程

## 🚀 未来规划

### v2.1.0 计划功能
- **更多语言支持**: Go, Rust, Java环境
- **数据库支持**: MySQL, PostgreSQL, Redis
- **监控面板**: Grafana + Prometheus
- **自动备份**: 系统配置自动备份

### v2.2.0 计划功能
- **集群支持**: Kubernetes环境配置
- **CI/CD集成**: Jenkins, GitLab CI
- **安全扫描**: 自动安全漏洞检测
- **性能测试**: 自动化性能基准测试

## 📚 更多资源

- **🌐 官网**: https://im.sh.cn
- **📖 GitHub**: https://github.com/al90slj23/IMSH
- **🐛 问题反馈**: https://github.com/al90slj23/IMSH/issues
- **💬 讨论**: https://github.com/al90slj23/IMSH/discussions
- **📋 框架集成**: [README.md](README.md)

## 🤝 贡献

欢迎贡献代码、报告问题、提出建议！

1. Fork 项目
2. 创建特性分支
3. 提交更改
4. 发起 Pull Request

## 📄 许可证

MIT License - 自由使用、修改和分发。

---

**🚀 IM.SH - 让VPS配置变得简单强大！**

> 一行命令，完整环境。从此告别繁琐的服务器配置！ 