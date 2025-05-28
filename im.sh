#!/bin/bash

# IM.SH - VPS服务器小助手
# 版本: 2.0.0
# 作者: IM.SH.CN
# 网站: https://im.sh.cn
# GitHub: https://github.com/al90slj23/IMSH

# 获取脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 加载导航模块
if [ -f "$SCRIPT_DIR/sh/im.sh.nav" ]; then
    source "$SCRIPT_DIR/sh/im.sh.nav"
else
    echo "错误: 找不到导航模块文件 sh/im.sh.nav"
    exit 1
fi

# 加载菜单模块
if [ -f "$SCRIPT_DIR/sh/im.sh.menu" ]; then
    source "$SCRIPT_DIR/sh/im.sh.menu"
else
    echo "错误: 找不到菜单模块文件 sh/im.sh.menu"
    exit 1
fi

# 加载功能模块
if [ -f "$SCRIPT_DIR/sh/im.sh.functions" ]; then
    source "$SCRIPT_DIR/sh/im.sh.functions"
else
    echo "错误: 找不到功能模块文件 sh/im.sh.functions"
    exit 1
fi

# 🎯 智能执行检测
# 如果用户直接curl下载脚本，显示使用提示
if [ "${BASH_SOURCE[0]}" = "${0}" ] && [ -t 1 ]; then
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "[*] IM.SH VPS小助手脚本下载成功！"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "[*] 您有以下选择："
    echo ""
    echo "1. 立即运行交互式菜单"
    echo "2. 查看使用说明"
    echo "3. 退出"
    echo ""
    
    while true; do
        read -p "请选择 [1-3]: " choice
        case $choice in
            1)
                echo ""
                echo "[*] 正在启动 IM.SH VPS小助手..."
                sleep 1
                break
                ;;
            2)
                echo ""
                echo "[*] 使用说明："
                echo ""
                echo "[*] 推荐用法："
                echo "curl im.sh.cn | bash                    # 一键运行"
                echo ""
                echo "[*] 直接跳转："
                echo "curl im.sh.cn | bash -s -- 111         # 测速脚本"
                echo "curl im.sh.cn | bash -s -- 121         # Docker安装"
                echo "curl im.sh.cn | bash -s -- 131         # 系统清理"
                echo ""
                echo "[*] 下载后运行："
                echo "curl im.sh.cn > im.sh && chmod +x im.sh && ./im.sh"
                echo ""
                read -p "按回车键返回菜单..."
                echo ""
                continue
                ;;
            3)
                echo ""
                echo "[*] 感谢使用 IM.SH！"
                echo "[*] 下次可以直接使用: curl im.sh.cn | bash"
                exit 0
                ;;
            *)
                echo "❌ 无效选择，请输入 1、2 或 3"
                ;;
        esac
    done
fi

# 注释掉set -e，避免影响交互式菜单
# set -e  # 遇到错误立即退出

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
CURRENT_PATH=""
DIRECT_COMMAND=""

# 修复管道执行时的输入问题
fix_stdin() {
    if [ ! -t 0 ]; then
        exec < /dev/tty
    fi
}

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
    echo "        IM.SH - VPS服务器小助手 v$SCRIPT_VERSION"
    echo "        网站: im.sh.cn"
    echo "=================================================="
    echo ""
    
    if [ -n "$CURRENT_PATH" ]; then
        echo -e "${BLUE}当前位置: $CURRENT_PATH${NC}"
        echo ""
    fi
}

# 安全的读取用户输入
safe_read() {
    local prompt="$1"
    local var_name="$2"
    
    # 确保能从终端读取输入
    if [ ! -t 0 ]; then
        exec < /dev/tty
    fi
    
    read -p "$prompt" "$var_name"
}

# 主菜单
show_main_menu() {
    CURRENT_PATH="主菜单"
    
    while true; do
        show_banner
        
        echo -e "${GREEN}=== VPS服务器小助手 ===${NC}"
        echo ""
        echo "1. 前辈脚本 - 经典实用脚本集合"
        echo "2. 老几脚本 - 待补充功能"
        echo ""
        
        read -p "请选择功能 [1-2]: " choice
        
        # 处理空输入，默认选择第一个选项
        if [[ -z "$choice" ]]; then
            choice="1"
            echo -e "${BLUE}[INFO]${NC} 默认选择: $choice"
        fi
        
        handle_input "$choice" "main"
        local result=$?
        
        case $result in
            0) # 返回上一层 (主菜单没有上一层，显示退出提示)
                echo ""
                echo -e "${YELLOW}已在主菜单，输入 00 退出程序${NC}"
                echo ""
                read -p "按回车键继续..."
                ;;
            1) # 重新显示菜单
                continue
                ;;
            2) # 处理选择
                case "$choice" in
                    "1")
                        show_veteran_scripts_menu
                        ;;
                    "2")
                        show_old_scripts_menu
                        ;;
                    *)
                        log_warning "无效选择: $choice"
                        echo ""
                        read -p "按回车键继续..."
                        ;;
                esac
                ;;
            3) # 返回主菜单（在主菜单中相当于重新显示）
                continue
                ;;
        esac
    done
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

# 主函数
main() {
    # 修复管道执行时的输入问题
    if [ ! -t 0 ]; then
        exec < /dev/tty
    fi
    
    # 检查是否有直接命令参数
    if [ $# -gt 0 ]; then
        DIRECT_COMMAND="$1"
        execute_direct_command "$DIRECT_COMMAND"
        exit 0
    fi
    
    # 检测系统环境
    detect_os
    check_root
    setup_logging
    
    # 显示主菜单
    show_main_menu
}

# 执行主函数
main "$@" 