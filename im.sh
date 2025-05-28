#!/bin/bash

# IM.SH - 超强大VPS一键配置脚本
# 版本: 2.0.0
# 作者: IM.SH.CN
# 网站: https://im.sh.cn
# GitHub: https://github.com/al90slj23/IMSH

set -e  # 遇到错误立即退出

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 全局变量
SCRIPT_VERSION="2.0.0"
INSTALL_LOG="/var/log/imsh-install.log"

# 日志函数
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1" | tee -a "$INSTALL_LOG"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1" | tee -a "$INSTALL_LOG"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1" | tee -a "$INSTALL_LOG"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1" | tee -a "$INSTALL_LOG"
}

log_step() {
    echo -e "${PURPLE}[STEP]${NC} $1" | tee -a "$INSTALL_LOG"
}

# 显示横幅
show_banner() {
    clear
    echo -e "${CYAN}"
    echo "██╗███╗   ███╗   ███████╗██╗  ██╗"
    echo "██║████╗ ████║   ██╔════╝██║  ██║"
    echo "██║██╔████╔██║   ███████╗███████║"
    echo "██║██║╚██╔╝██║   ╚════██║██╔══██║"
    echo "██║██║ ╚═╝ ██║██╗███████║██║  ██║"
    echo "╚═╝╚═╝     ╚═╝╚═╝╚══════╝╚═╝  ╚═╝"
    echo -e "${NC}"
    echo "=================================================="
    echo "        IM.SH - 超强大VPS一键配置脚本"
    echo "        版本: $SCRIPT_VERSION"
    echo "        网站: https://im.sh.cn"
    echo "=================================================="
    echo ""
}

# 检测操作系统
detect_os() {
    log_step "检测系统环境..."
    
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        log_info "检测到 Linux 系统"
        
        if [ -f /etc/os-release ]; then
            . /etc/os-release
            OS_NAME=$NAME
            OS_VERSION=$VERSION_ID
            OS_ID=$ID
            log_info "系统: $OS_NAME $OS_VERSION"
            
            # 检测包管理器
            if command -v apt-get &> /dev/null; then
                PACKAGE_MANAGER="apt"
                log_info "包管理器: APT (Debian/Ubuntu)"
            elif command -v yum &> /dev/null; then
                PACKAGE_MANAGER="yum"
                log_info "包管理器: YUM (CentOS/RHEL)"
            elif command -v dnf &> /dev/null; then
                PACKAGE_MANAGER="dnf"
                log_info "包管理器: DNF (Fedora)"
            elif command -v pacman &> /dev/null; then
                PACKAGE_MANAGER="pacman"
                log_info "包管理器: Pacman (Arch Linux)"
            elif command -v zypper &> /dev/null; then
                PACKAGE_MANAGER="zypper"
                log_info "包管理器: Zypper (openSUSE)"
            else
                log_warning "未检测到支持的包管理器"
                PACKAGE_MANAGER="unknown"
            fi
        else
            log_warning "无法读取 /etc/os-release 文件"
        fi
    else
        log_error "此脚本仅支持 Linux 系统"
        log_error "当前系统: $OSTYPE"
        exit 1
    fi
}

# 检查是否为root用户
check_root() {
    if [[ $EUID -eq 0 ]]; then
        log_warning "检测到以root用户运行"
        SUDO_CMD=""
    else
        log_info "检测到普通用户，将使用sudo"
        SUDO_CMD="sudo"
        
        # 检查sudo是否可用
        if ! command -v sudo &> /dev/null; then
            log_error "sudo命令不可用，请以root用户运行此脚本"
            exit 1
        fi
    fi
}

# 创建日志目录
setup_logging() {
    $SUDO_CMD mkdir -p /var/log
    $SUDO_CMD touch "$INSTALL_LOG"
    log_info "日志文件: $INSTALL_LOG"
}

# 更新系统包
update_system() {
    log_step "更新系统包..."
    
    case $PACKAGE_MANAGER in
        "apt")
            $SUDO_CMD apt-get update && $SUDO_CMD apt-get upgrade -y
            log_success "APT 系统更新完成"
            ;;
        "yum")
            $SUDO_CMD yum update -y
            log_success "YUM 系统更新完成"
            ;;
        "dnf")
            $SUDO_CMD dnf update -y
            log_success "DNF 系统更新完成"
            ;;
        "pacman")
            $SUDO_CMD pacman -Syu --noconfirm
            log_success "Pacman 系统更新完成"
            ;;
        "zypper")
            $SUDO_CMD zypper refresh && $SUDO_CMD zypper update -y
            log_success "Zypper 系统更新完成"
            ;;
        *)
            log_warning "跳过系统更新（未知包管理器）"
            ;;
    esac
}

# 安装基础工具
install_basic_tools() {
    log_step "安装基础工具..."
    
    local tools="curl wget git vim nano htop tree unzip zip screen tmux"
    
    case $PACKAGE_MANAGER in
        "apt")
            $SUDO_CMD apt-get install -y $tools build-essential software-properties-common
            ;;
        "yum")
            $SUDO_CMD yum install -y $tools gcc gcc-c++ make
            ;;
        "dnf")
            $SUDO_CMD dnf install -y $tools gcc gcc-c++ make
            ;;
        "pacman")
            $SUDO_CMD pacman -S --noconfirm $tools base-devel
            ;;
        "zypper")
            $SUDO_CMD zypper install -y $tools gcc gcc-c++ make
            ;;
        *)
            log_warning "跳过基础工具安装（未知包管理器）"
            return
            ;;
    esac
    
    log_success "基础工具安装完成"
}

# 安装Docker
install_docker() {
    log_step "安装Docker..."
    
    if command -v docker &> /dev/null; then
        log_info "Docker已安装，跳过"
        return
    fi
    
    # 官方安装脚本
    curl -fsSL https://get.docker.com | bash
    
    # 启动Docker服务
    $SUDO_CMD systemctl enable docker
    $SUDO_CMD systemctl start docker
    
    # 添加当前用户到docker组（如果不是root）
    if [[ $EUID -ne 0 ]]; then
        $SUDO_CMD usermod -aG docker $USER
        log_info "已将用户 $USER 添加到docker组，请重新登录生效"
    fi
    
    # 安装Docker Compose
    $SUDO_CMD curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    $SUDO_CMD chmod +x /usr/local/bin/docker-compose
    
    log_success "Docker和Docker Compose安装完成"
}

# 安装Node.js
install_nodejs() {
    log_step "安装Node.js..."
    
    if command -v node &> /dev/null; then
        log_info "Node.js已安装，版本: $(node --version)"
        return
    fi
    
    # 使用NodeSource仓库安装最新LTS版本
    curl -fsSL https://deb.nodesource.com/setup_lts.x | $SUDO_CMD -E bash -
    
    case $PACKAGE_MANAGER in
        "apt")
            $SUDO_CMD apt-get install -y nodejs
            ;;
        "yum"|"dnf")
            $SUDO_CMD yum install -y nodejs npm
            ;;
        *)
            log_warning "使用二进制安装Node.js"
            # 下载并安装Node.js二进制文件
            NODE_VERSION=$(curl -s https://nodejs.org/dist/index.json | grep -o '"version":"[^"]*' | head -1 | cut -d'"' -f4)
            wget https://nodejs.org/dist/$NODE_VERSION/node-$NODE_VERSION-linux-x64.tar.xz
            $SUDO_CMD tar -xf node-$NODE_VERSION-linux-x64.tar.xz -C /usr/local --strip-components=1
            rm node-$NODE_VERSION-linux-x64.tar.xz
            ;;
    esac
    
    # 安装常用全局包
    $SUDO_CMD npm install -g pm2 yarn pnpm
    
    log_success "Node.js安装完成，版本: $(node --version)"
}

# 安装Python环境
install_python() {
    log_step "安装Python环境..."
    
    case $PACKAGE_MANAGER in
        "apt")
            $SUDO_CMD apt-get install -y python3 python3-pip python3-venv
            ;;
        "yum"|"dnf")
            $SUDO_CMD $PACKAGE_MANAGER install -y python3 python3-pip
            ;;
        "pacman")
            $SUDO_CMD pacman -S --noconfirm python python-pip
            ;;
        "zypper")
            $SUDO_CMD zypper install -y python3 python3-pip
            ;;
    esac
    
    # 升级pip
    python3 -m pip install --upgrade pip
    
    # 安装常用Python包
    pip3 install virtualenv pipenv poetry requests beautifulsoup4 flask django
    
    log_success "Python环境安装完成"
}

# 安装Nginx
install_nginx() {
    log_step "安装Nginx..."
    
    if command -v nginx &> /dev/null; then
        log_info "Nginx已安装，跳过"
        return
    fi
    
    case $PACKAGE_MANAGER in
        "apt")
            $SUDO_CMD apt-get install -y nginx
            ;;
        "yum"|"dnf")
            $SUDO_CMD $PACKAGE_MANAGER install -y nginx
            ;;
        "pacman")
            $SUDO_CMD pacman -S --noconfirm nginx
            ;;
        "zypper")
            $SUDO_CMD zypper install -y nginx
            ;;
    esac
    
    # 启动并启用Nginx
    $SUDO_CMD systemctl enable nginx
    $SUDO_CMD systemctl start nginx
    
    log_success "Nginx安装完成"
}

# 配置防火墙
setup_firewall() {
    log_step "配置防火墙..."
    
    if command -v ufw &> /dev/null; then
        # Ubuntu/Debian UFW
        $SUDO_CMD ufw --force enable
        $SUDO_CMD ufw default deny incoming
        $SUDO_CMD ufw default allow outgoing
        $SUDO_CMD ufw allow ssh
        $SUDO_CMD ufw allow 80/tcp
        $SUDO_CMD ufw allow 443/tcp
        log_success "UFW防火墙配置完成"
    elif command -v firewall-cmd &> /dev/null; then
        # CentOS/RHEL/Fedora firewalld
        $SUDO_CMD systemctl enable firewalld
        $SUDO_CMD systemctl start firewalld
        $SUDO_CMD firewall-cmd --permanent --add-service=ssh
        $SUDO_CMD firewall-cmd --permanent --add-service=http
        $SUDO_CMD firewall-cmd --permanent --add-service=https
        $SUDO_CMD firewall-cmd --reload
        log_success "Firewalld防火墙配置完成"
    else
        log_warning "未检测到支持的防火墙，请手动配置"
    fi
}

# SSH安全加固
secure_ssh() {
    log_step "SSH安全加固..."
    
    # 备份原配置
    $SUDO_CMD cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup
    
    # 修改SSH配置
    $SUDO_CMD sed -i 's/#PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
    $SUDO_CMD sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
    $SUDO_CMD sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config
    
    # 重启SSH服务
    $SUDO_CMD systemctl restart sshd
    
    log_success "SSH安全配置完成"
    log_warning "建议设置SSH密钥认证并禁用密码登录"
}

# 系统性能优化
optimize_system() {
    log_step "系统性能优化..."
    
    # 优化内核参数
    cat << EOF | $SUDO_CMD tee /etc/sysctl.d/99-imsh-optimization.conf
# IM.SH 系统优化配置
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.ipv4.tcp_rmem = 4096 87380 16777216
net.ipv4.tcp_wmem = 4096 65536 16777216
net.ipv4.tcp_congestion_control = bbr
net.core.default_qdisc = fq
vm.swappiness = 10
fs.file-max = 65535
EOF
    
    # 应用内核参数
    $SUDO_CMD sysctl -p /etc/sysctl.d/99-imsh-optimization.conf
    
    # 优化文件描述符限制
    cat << EOF | $SUDO_CMD tee /etc/security/limits.d/99-imsh.conf
* soft nofile 65535
* hard nofile 65535
root soft nofile 65535
root hard nofile 65535
EOF
    
    log_success "系统性能优化完成"
}

# 安装监控工具
install_monitoring() {
    log_step "安装监控工具..."
    
    case $PACKAGE_MANAGER in
        "apt")
            $SUDO_CMD apt-get install -y htop iotop nethogs ncdu
            ;;
        "yum"|"dnf")
            $SUDO_CMD $PACKAGE_MANAGER install -y htop iotop nethogs ncdu
            ;;
        "pacman")
            $SUDO_CMD pacman -S --noconfirm htop iotop nethogs ncdu
            ;;
        "zypper")
            $SUDO_CMD zypper install -y htop iotop nethogs ncdu
            ;;
    esac
    
    log_success "监控工具安装完成"
}

# 创建有用的别名和函数
setup_aliases() {
    log_step "设置有用的别名..."
    
    cat << 'EOF' | $SUDO_CMD tee /etc/profile.d/imsh-aliases.sh
# IM.SH 有用的别名和函数
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# 系统信息
alias sysinfo='uname -a && cat /etc/os-release'
alias meminfo='free -h'
alias diskinfo='df -h'
alias cpuinfo='lscpu'

# 网络
alias ports='netstat -tuln'
alias myip='curl -s ipinfo.io/ip'

# Docker快捷命令
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias dstop='docker stop $(docker ps -q)'
alias drm='docker rm $(docker ps -aq)'

# 系统维护
alias update='sudo apt update && sudo apt upgrade'
alias install='sudo apt install'
alias search='apt search'

# 快速编辑
alias bashrc='nano ~/.bashrc'
alias vimrc='nano ~/.vimrc'

# 进程管理
alias psg='ps aux | grep'
alias topcpu='ps aux --sort=-%cpu | head'
alias topmem='ps aux --sort=-%mem | head'
EOF
    
    log_success "别名设置完成"
}

# 显示安装总结
show_summary() {
    echo ""
    echo "=================================================="
    echo "           🎉 IM.SH 安装完成！"
    echo "=================================================="
    echo ""
    log_success "安装的组件："
    echo "  ✅ 基础工具 (curl, wget, git, vim, htop, tree等)"
    echo "  ✅ Docker & Docker Compose"
    echo "  ✅ Node.js & NPM (PM2, Yarn, PNPM)"
    echo "  ✅ Python3 & Pip"
    echo "  ✅ Nginx Web服务器"
    echo "  ✅ 防火墙配置"
    echo "  ✅ SSH安全加固"
    echo "  ✅ 系统性能优化"
    echo "  ✅ 监控工具"
    echo "  ✅ 有用的别名和函数"
    echo ""
    log_info "日志文件: $INSTALL_LOG"
    echo ""
    echo "🔧 常用命令："
    echo "  docker --version    # 查看Docker版本"
    echo "  node --version      # 查看Node.js版本"
    echo "  python3 --version   # 查看Python版本"
    echo "  nginx -v            # 查看Nginx版本"
    echo "  htop                # 系统监控"
    echo "  myip                # 查看公网IP"
    echo ""
    echo "📚 更多信息: https://im.sh.cn"
    echo "🐛 问题反馈: https://github.com/al90slj23/IMSH"
    echo ""
    echo "=================================================="
    echo "           感谢使用 IM.SH 超强VPS配置脚本！"
    echo "=================================================="
}

# 交互式菜单
show_menu() {
    echo ""
    echo "请选择安装模式："
    echo "1) 🚀 完整安装 (推荐) - 安装所有组件"
    echo "2) 🔧 自定义安装 - 选择要安装的组件"
    echo "3) 📦 仅基础工具 - 只安装基础工具"
    echo "4) 🐳 Docker环境 - 安装Docker相关"
    echo "5) 🌐 Web环境 - 安装Nginx + Node.js + Python"
    echo "6) 🛡️  安全加固 - 防火墙 + SSH安全"
    echo "7) ⚡ 性能优化 - 系统调优"
    echo "0) 退出"
    echo ""
    read -p "请输入选择 [1-7]: " choice
    
    case $choice in
        1) full_install ;;
        2) custom_install ;;
        3) basic_install ;;
        4) docker_install ;;
        5) web_install ;;
        6) security_install ;;
        7) performance_install ;;
        0) exit 0 ;;
        *) log_error "无效选择，请重新运行脚本"; exit 1 ;;
    esac
}

# 完整安装
full_install() {
    log_info "开始完整安装..."
    update_system
    install_basic_tools
    install_docker
    install_nodejs
    install_python
    install_nginx
    setup_firewall
    secure_ssh
    optimize_system
    install_monitoring
    setup_aliases
    show_summary
}

# 自定义安装
custom_install() {
    echo "自定义安装选项："
    echo "请输入要安装的组件编号，用空格分隔 (如: 1 3 5)"
    echo "1) 基础工具  2) Docker  3) Node.js  4) Python"
    echo "5) Nginx     6) 防火墙  7) SSH安全  8) 性能优化"
    echo "9) 监控工具  10) 别名设置"
    read -p "请输入选择: " selections
    
    update_system
    
    for selection in $selections; do
        case $selection in
            1) install_basic_tools ;;
            2) install_docker ;;
            3) install_nodejs ;;
            4) install_python ;;
            5) install_nginx ;;
            6) setup_firewall ;;
            7) secure_ssh ;;
            8) optimize_system ;;
            9) install_monitoring ;;
            10) setup_aliases ;;
            *) log_warning "跳过无效选择: $selection" ;;
        esac
    done
    
    show_summary
}

# 基础安装
basic_install() {
    update_system
    install_basic_tools
    setup_aliases
    log_success "基础工具安装完成！"
}

# Docker安装
docker_install() {
    update_system
    install_basic_tools
    install_docker
    log_success "Docker环境安装完成！"
}

# Web环境安装
web_install() {
    update_system
    install_basic_tools
    install_nginx
    install_nodejs
    install_python
    setup_firewall
    log_success "Web环境安装完成！"
}

# 安全加固
security_install() {
    setup_firewall
    secure_ssh
    log_success "安全加固完成！"
}

# 性能优化
performance_install() {
    optimize_system
    install_monitoring
    log_success "性能优化完成！"
}

# 主函数
main() {
    # 显示横幅
    show_banner
    
    # 检测系统环境
    detect_os
    check_root
    setup_logging
    
    # 检查参数
    if [[ $# -eq 0 ]]; then
        # 无参数，显示交互菜单
        show_menu
    else
        # 有参数，直接执行
        case $1 in
            --full|--all|-a)
                full_install
                ;;
            --basic|-b)
                basic_install
                ;;
            --docker|-d)
                docker_install
                ;;
            --web|-w)
                web_install
                ;;
            --security|-s)
                security_install
                ;;
            --performance|-p)
                performance_install
                ;;
            --help|-h)
                echo "IM.SH 超强VPS配置脚本 v$SCRIPT_VERSION"
                echo ""
                echo "用法: $0 [选项]"
                echo ""
                echo "选项:"
                echo "  --full, -a        完整安装所有组件"
                echo "  --basic, -b       仅安装基础工具"
                echo "  --docker, -d      安装Docker环境"
                echo "  --web, -w         安装Web环境"
                echo "  --security, -s    安全加固"
                echo "  --performance, -p 性能优化"
                echo "  --help, -h        显示帮助信息"
                echo ""
                echo "示例:"
                echo "  curl -fsSL https://im.sh.cn | bash           # 交互式安装"
                echo "  curl -fsSL https://im.sh.cn | bash -s -- -a # 完整安装"
                echo "  curl -fsSL https://im.sh.cn | bash -s -- -d # 仅Docker"
                ;;
            *)
                log_error "未知参数: $1"
                log_info "使用 --help 查看帮助信息"
                exit 1
                ;;
        esac
    fi
}

# 执行主函数
main "$@" 