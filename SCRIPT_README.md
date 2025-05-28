# IM.SH v2.0.0 - VPS服务器小助手脚本

> **一行命令，全面测试！** 集成多个知名脚本，提供VPS性能测试、网络测速、系统管理等功能。

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Version](https://img.shields.io/badge/version-2.0.0-green.svg)](https://github.com/al90slj23/IMSH)
[![Shell](https://img.shields.io/badge/shell-bash-orange.svg)](https://www.gnu.org/software/bash/)

## 🚀 快速使用

### 🎯 一键运行（推荐）
```bash
curl im.sh.cn | bash
```

### 🔧 快速跳转功能
```bash
curl im.sh.cn | bash -s -- 111   # Bench.sh综合测试
curl im.sh.cn | bash -s -- 1131  # SpeedTestCN国内三网测速
curl im.sh.cn | bash -s -- 1141  # mtr_trace回程路由测试
curl im.sh.cn | bash -s -- 1142  # besttrace一键回程测试
curl im.sh.cn | bash -s -- 1143  # RegionRestrictionCheck流媒体测试
```

### 🔄 下载后运行
```bash
curl im.sh.cn > im.sh && chmod +x im.sh && ./im.sh
```

### ⚠️ HTTPS重定向处理

如果遇到301重定向错误，请使用以下正确命令：

```bash
# ✅ 推荐方式：自动跟随重定向
curl -fsSL https://im.sh.cn | bash

# ✅ 或者直接使用HTTPS
curl https://im.sh.cn | bash

# 🔧 如果必须使用HTTP，添加-L参数
curl -L http://im.sh.cn | bash
```

## ✨ 核心特性

- **🎮 智能导航**: 支持快速跳转、回车默认选择、帮助系统
- **🧪 丰富测试**: 集成Bench.sh、UnixBench、GeekBench等知名脚本
- **🌐 网络测试**: 国内外测速、回程路由测试
- **📋 模块化架构**: 主脚本+导航+菜单+功能模块
- **🔧 终端兼容**: 所有符号使用文本格式，确保兼容性
- **⚡ 高性能**: 智能检测，毫秒级响应

## 🎛️ 交互式菜单

运行脚本后，您将看到精美的交互界面：

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    IM.SH - VPS服务器小助手 v2.0.0
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[*] 主菜单

1. 前辈脚本
2. 老几脚本

[*] 导航提示: 
- 直接回车选择第一个选项
- 输入数字串快速跳转 (如: 111, 1131)
- 输入 help 查看帮助
- 输入 menu 返回主菜单

请选择 [1-2]:
```

## 📋 完整功能菜单

### 🧪 测试脚本

#### 综合测试
- **111** - **Bench.sh** - 秋水大佬的综合性能测试
  - 系统信息检测
  - CPU性能测试
  - 内存性能测试
  - 磁盘I/O测试
  - 网络测速（全球节点）

#### 硬件测试
- **112** - **UnixBench** - 综合性能基准测试
  - CPU整数运算
  - CPU浮点运算
  - 系统调用性能
  - 文件系统性能
  - 多线程性能
- **1121** - **GeekBench** - 跨平台处理器基准测试
  - 单核性能测试
  - 多核性能测试
  - 内存性能测试
  - 与全球设备对比

#### 测速脚本
- **1131** - **SpeedTestCN（国内三网测速） by BlueSkyXN**
  - 电信网络测速
  - 联通网络测速
  - 移动网络测速
  - 多节点对比
- **1132** - **bench.monster（国外测速）**
  - 全球节点测速
  - 延迟测试
  - 带宽测试
  - 网络质量评估
- **1133** - **本地测速** - 本地网络性能测试
  - 本地回环测试
  - 内网速度测试

#### 网络测试
- **1141** - **mtr_trace（回程国内三网路由） by zhucaidan**
  - 电信回程路由
  - 联通回程路由
  - 移动回程路由
  - 路由跳数分析
- **1142** - **besttrace（一键回程测试脚本） by zq**
  - 8个测试节点
  - 详细路由信息
  - 延迟分析
  - 网络质量评估
- **1143** - **RegionRestrictionCheck（流媒体测试） by lmc999**
  - Netflix 解锁检测
  - Disney+ 解锁检测
  - YouTube Premium 解锁检测
  - Amazon Prime Video 解锁检测
  - HBO Max 解锁检测
  - Spotify 解锁检测
  - TikTok 解锁检测
  - 支持IPv4/IPv6双栈检测
  - 支持多语言界面
- **1144** - **网络连通性测试**
  - DNS解析测试
  - 端口连通性测试
  - 网络延迟测试

### 🔧 安装脚本
- **121** - **Docker安装** - Docker环境一键安装
- **122** - **环境配置** - 开发环境配置
- **123** - **软件安装** - 常用软件安装
- **124** - **系统优化** - 系统性能优化

### 🧹 维护脚本
- **131** - **系统清理** - 清理系统垃圾文件
- **132** - **日志管理** - 系统日志管理
- **133** - **备份恢复** - 数据备份和恢复
- **134** - **安全检查** - 系统安全检查

### 📊 监控脚本
- **141** - **性能监控** - 系统性能实时监控
- **142** - **资源监控** - 系统资源使用监控
- **143** - **服务监控** - 服务状态监控
- **144** - **告警设置** - 监控告警配置

### 🛠️ 工具脚本
- **151** - **文件管理** - 文件操作工具
- **152** - **进程管理** - 进程管理工具
- **153** - **网络工具** - 网络诊断工具
- **154** - **系统信息** - 系统信息查看

## 🎮 智能导航系统

### 基本导航
- **回车键** - 选择第一个选项（快速选择）
- **数字** - 选择对应选项（如: 1, 2, 3）
- **0** - 返回上一层菜单
- **00** - 退出程序（需要输入yes确认）

### 特殊命令
- **help** - 显示详细帮助信息
- **menu** - 直接返回主菜单
- **exit/bye** - 直接退出程序

### 快速跳转
使用数字串可以直接跳转到对应功能，例如：
- `111` - 直接跳转到Bench.sh综合测试
- `1131` - 直接跳转到SpeedTestCN国内三网测速
- `1141` - 直接跳转到mtr_trace回程路由测试
- `1142` - 直接跳转到besttrace一键回程测试

### 导航示例
```bash
# 启动脚本
curl im.sh.cn | bash

# 直接跳转到功能
curl im.sh.cn | bash -s -- 111

# 在菜单中使用
请选择 [1-2]: 1      # 进入前辈脚本
请选择 [1-5]: 1      # 进入测试脚本
请选择 [1-4]: 1      # 进入综合测试
请选择 [1]: 1        # 执行Bench.sh

# 或者直接输入快速跳转
请选择 [1-2]: 111    # 直接跳转到Bench.sh
```

## 🏗️ 模块化架构

### 文件结构
```
imsh/
├── im.sh                    # 主脚本 (300行)
├── sh/                      # 模块目录
│   ├── im.sh.nav           # 导航模块 (213行)
│   ├── im.sh.menu          # 菜单模块 (672行)
│   └── im.sh.functions     # 功能模块 (600+行)
├── im/                      # 智能检测
│   └── im.php              # PHP智能检测脚本
├── install.sh              # 安装脚本
├── README.md               # 框架集成说明
└── SCRIPT_README.md        # 脚本功能说明（本文件）
```

### 模块功能
- **主脚本**: 启动入口、参数处理、模块加载
- **导航模块**: 智能导航、快速跳转、帮助系统
- **菜单模块**: 所有菜单界面、用户交互
- **功能模块**: 具体功能实现、第三方脚本集成

## 🔧 集成的第三方脚本

### 性能测试脚本
- **Bench.sh** - 秋水大佬开发的综合性能测试脚本
  - 项目地址: https://github.com/teddysun/across
  - 功能: 系统信息、CPU、内存、磁盘、网络全面测试
- **UnixBench** - 经典的Unix系统性能基准测试
  - 集成秋水大佬的优化版本
  - 功能: CPU、内存、文件系统、系统调用性能测试
- **GeekBench** - 通过YABS脚本集成的跨平台处理器测试
  - 项目地址: https://github.com/masonr/yet-another-bench-script
  - 功能: 单核、多核、内存性能测试

### 网络测速脚本
- **SpeedTestCN** - BlueSkyXN开发的国内三网测速脚本
  - 项目地址: https://github.com/BlueSkyXN/SpeedTestCN
  - 功能: 电信、联通、移动三网测速
- **bench.monster** - 国外节点网络测速脚本
  - 项目地址: https://bench.monster/
  - 功能: 全球节点测速、网络质量评估

### 路由测试脚本
- **mtr_trace** - zhucaidan开发的回程国内三网路由测试
  - 项目地址: https://github.com/zhucaidan/mtr_trace-CN
  - 功能: 三网回程路由、延迟分析
- **besttrace** - zq开发的一键回程测试脚本
  - 项目地址: https://github.com/zq/besttrace
  - 功能: 8个节点回程测试、详细路由信息

### 流媒体测试脚本
- **RegionRestrictionCheck** - lmc999开发的流媒体解锁检测脚本
  - 项目地址: https://github.com/lmc999/RegionRestrictionCheck
  - 功能: Netflix、Disney+、YouTube Premium等主流流媒体平台解锁检测
  - 特点: 支持IPv4/IPv6双栈、多语言界面、免ROOT执行

## 📊 测试结果示例

### Bench.sh测试结果
```
----------------------------------------------------------------------
 CPU Model          : Intel(R) Xeon(R) CPU E5-2680 v4 @ 2.40GHz
 CPU Cores          : 2 @ 2399.996 MHz
 CPU Cache          : 35840 KB
 AES-NI             : Enabled
 VM-x/AMD-V         : Enabled
 Total Disk         : 39.2 GB (2.8 GB Used)
 Total Mem          : 3.9 GB (85.7 MB Used)
 Total Swap         : 2.0 GB (0 Used)
 System uptime      : 0 days, 0 hour 5 min
 Load average       : 0.00, 0.01, 0.05
 OS                 : Ubuntu 20.04.3 LTS
 Arch               : x86_64 (64 Bit)
 Kernel             : 5.4.0-89-generic
 TCP CC             : bbr
 Virtualization     : KVM
 Organization       : AS13335 Cloudflare, Inc.
 Location           : San Francisco / US
 Region             : California
----------------------------------------------------------------------
```

### SpeedTestCN测试结果
```
----------------------------------------------------------------------
 测速类型    上传/Mbps   下载/Mbps   延迟/ms    丢包率/%
----------------------------------------------------------------------
 电信上海    245.67      892.34      28.5       0.0
 联通上海    198.23      756.89      31.2       0.0
 移动上海    167.45      634.12      35.8       0.0
----------------------------------------------------------------------
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
- 网络环境和代理设置

## 🛠️ 高级用法

### 环境变量配置
```bash
# 设置代理
export http_proxy=http://proxy.example.com:8080
export https_proxy=http://proxy.example.com:8080

# 跳过某些测试
export SKIP_GEEKBENCH=1      # 跳过GeekBench测试
export SKIP_SPEEDTEST=1      # 跳过测速测试

curl im.sh.cn | bash
```

### 批量部署
```bash
#!/bin/bash
# 批量VPS测试脚本

servers=(
    "192.168.1.10"
    "192.168.1.11"
    "192.168.1.12"
)

for server in "${servers[@]}"; do
    echo "测试服务器: $server"
    ssh root@$server "curl im.sh.cn | bash -s -- 111"
done
```

### 自动化测试
```bash
# 自动运行综合测试并保存结果
curl im.sh.cn | bash -s -- 111 > bench_result_$(date +%Y%m%d_%H%M%S).txt

# 定时测试网络质量
echo "0 */6 * * * curl im.sh.cn | bash -s -- 1131 >> /var/log/speedtest.log" | crontab -
```

## 🔍 故障排除

### 常见问题

1. **脚本下载失败**
   ```bash
   # 检查网络连接
   ping im.sh.cn
   
   # 使用代理
   curl --proxy http://proxy:8080 im.sh.cn | bash
   
   # 使用IPv4
   curl -4 im.sh.cn | bash
   ```

2. **权限不足**
   ```bash
   # 使用sudo运行
   curl im.sh.cn | sudo bash
   
   # 或者切换到root用户
   sudo su -
   curl im.sh.cn | bash
   ```

3. **测试中断**
   ```bash
   # 使用screen保持会话
   screen -S imsh
   curl im.sh.cn | bash
   # Ctrl+A+D 分离会话
   
   # 重新连接
   screen -r imsh
   ```

4. **网络超时**
   ```bash
   # 增加超时时间
   curl --connect-timeout 30 --max-time 300 im.sh.cn | bash
   
   # 使用国内镜像（如果有）
   curl mirror.im.sh.cn | bash
   ```

### 调试模式
```bash
# 启用调试模式
curl im.sh.cn | bash -x

# 查看详细输出
curl im.sh.cn | bash -v

# 保存调试日志
curl im.sh.cn | bash -x 2>&1 | tee debug.log
```

## 🎨 自定义配置

### 修改默认选项
编辑下载的脚本文件，可以自定义默认行为：

```bash
# 下载脚本
curl im.sh.cn > im.sh

# 编辑脚本
vim im.sh

# 找到配置部分并修改
DEFAULT_CHOICE="111"        # 默认选择Bench.sh
SKIP_CONFIRMATION="true"    # 跳过确认提示
AUTO_CLEANUP="true"         # 自动清理临时文件
```

### 添加自定义功能
```bash
# 在功能模块中添加自定义函数
execute_my_custom_test() {
    log_step "执行自定义测试..."
    echo "这里是我的自定义测试逻辑"
    # 你的自定义命令
}
```

## 📈 性能优化建议

### 测试前准备
1. **关闭不必要的服务**
   ```bash
   systemctl stop apache2 nginx mysql
   ```

2. **清理系统缓存**
   ```bash
   sync && echo 3 > /proc/sys/vm/drop_caches
   ```

3. **确保足够的磁盘空间**
   ```bash
   df -h  # 至少保留1GB空间
   ```

### 测试环境建议
- **CPU测试**: 确保CPU使用率低于10%
- **内存测试**: 确保可用内存大于50%
- **磁盘测试**: 确保磁盘使用率低于80%
- **网络测试**: 避免高峰时段，选择凌晨测试

## 🤝 贡献

欢迎提交Issue和Pull Request来改进这个项目！

### 贡献指南
1. Fork 本仓库
2. 创建功能分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 打开 Pull Request

### 贡献方向
- 添加新的测试脚本
- 优化现有功能
- 改进用户界面
- 增加系统支持
- 完善文档说明

## 📄 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情

## 🙏 致谢

感谢以下开发者的优秀脚本：
- **秋水大佬** - Bench.sh综合性能测试、UnixBench优化版本
- **BlueSkyXN** - SpeedTestCN国内三网测速
- **zhucaidan** - mtr_trace回程路由测试
- **zq** - besttrace一键回程测试脚本
- **lmc999** - RegionRestrictionCheck流媒体解锁检测
- **YABS团队** - GeekBench集成支持
- **bench.monster** - 国外测速服务

## 📚 相关链接

- **🌐 官网**: https://im.sh.cn
- **📖 GitHub**: https://github.com/al90slj23/IMSH
- **🐛 问题反馈**: https://github.com/al90slj23/IMSH/issues
- **📋 框架集成说明**: [README.md](README.md)
- **📊 测试结果分享**: https://im.sh.cn/results

---

**🚀 IM.SH - 让VPS测试变得简单！**

> 一行命令，全面测试。性能、网络、系统，一个脚本搞定！ 

### 🚀 快速跳转编号
- `111` - Bench.sh综合测试
- `112` - UnixBench性能测试
- `1121` - GeekBench处理器测试
- `1131` - SpeedTestCN国内三网测速
- `1132` - bench.monster国外测速
- `1133` - 本地测速
- `1141` - mtr_trace回程路由测试
- `1142` - besttrace一键回程测试
- `1143` - RegionRestrictionCheck流媒体测试
- `1144` - 网络连通性测试 