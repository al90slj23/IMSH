#!/bin/bash

# IM.SH - 智能安装脚本
# 版本: 1.0.0
# 作者: Your Name
# 网站: im.sh.cn

set -e  # 遇到错误立即退出

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 日志函数
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 检测操作系统
detect_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        log_info "检测到 Linux 系统"
        
        if [ -f /etc/os-release ]; then
            . /etc/os-release
            OS_NAME=$NAME
            OS_VERSION=$VERSION_ID
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

# 更新系统包
update_system() {
    log_info "开始更新系统包..."
    
    case $PACKAGE_MANAGER in
        "apt")
            $SUDO_CMD apt-get update
            log_success "APT 包列表更新完成"
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
            $SUDO_CMD zypper refresh
            $SUDO_CMD zypper update -y
            log_success "Zypper 系统更新完成"
            ;;
        *)
            log_warning "跳过系统更新（未知包管理器）"
            ;;
    esac
}

# 安装基础工具
install_basic_tools() {
    log_info "开始安装基础工具..."
    
    case $PACKAGE_MANAGER in
        "apt")
            $SUDO_CMD apt-get install -y curl wget git vim htop tree
            ;;
        "yum")
            $SUDO_CMD yum install -y curl wget git vim htop tree
            ;;
        "dnf")
            $SUDO_CMD dnf install -y curl wget git vim htop tree
            ;;
        "pacman")
            $SUDO_CMD pacman -S --noconfirm curl wget git vim htop tree
            ;;
        "zypper")
            $SUDO_CMD zypper install -y curl wget git vim htop tree
            ;;
        *)
            log_warning "跳过基础工具安装（未知包管理器）"
            return
            ;;
    esac
    
    log_success "基础工具安装完成"
}

# 主函数
main() {
    echo "=================================================="
    echo "           欢迎使用 IM.SH 智能安装脚本"
    echo "=================================================="
    echo ""
    
    # 检测系统环境
    detect_os
    check_root
    
    echo ""
    log_info "开始执行安装流程..."
    echo ""
    
    # 更新系统
    update_system
    echo ""
    
    # 安装基础工具
    install_basic_tools
    echo ""
    
    log_success "所有安装任务完成！"
    echo ""
    echo "=================================================="
    echo "           感谢使用 IM.SH 安装脚本"
    echo "           访问 im.sh.cn 获取更多信息"
    echo "=================================================="
}

# 执行主函数
main "$@" 