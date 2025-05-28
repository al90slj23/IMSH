#!/bin/bash

# IM.SH - VPS服务器小助手
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
CURRENT_PATH=""
DIRECT_COMMAND=""

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
    echo "        网站: https://im.sh.cn"
    echo "=================================================="
    echo ""
    
    if [ -n "$CURRENT_PATH" ]; then
        echo -e "${BLUE}当前位置: $CURRENT_PATH${NC}"
        echo ""
    fi
}

# 显示导航提示
show_navigation_tips() {
    echo -e "${YELLOW}导航提示:${NC}"
    echo "  0  - 返回上一层"
    echo "  00 - 退出程序"
    echo "  直接输入数字串可快速跳转 (如: 111)"
    echo "  输入 exit 或 bye 直接退出"
    echo ""
}

# 处理用户输入
handle_input() {
    local input="$1"
    local current_level="$2"
    
    # 处理特殊命令
    case "$input" in
        "exit"|"bye")
            log_info "再见！感谢使用 IM.SH VPS小助手"
            exit 0
            ;;
        "00")
            echo ""
            read -p "确定要退出吗？输入 yes 确认: " confirm
            if [[ "$confirm" == "yes" ]]; then
                log_info "再见！感谢使用 IM.SH VPS小助手"
                exit 0
            else
                return 1
            fi
            ;;
        "0")
            return 0  # 返回上一层
            ;;
        "")
            return 1  # 空输入，重新显示菜单
            ;;
    esac
    
    # 处理数字输入
    if [[ "$input" =~ ^[0-9]+$ ]]; then
        # 检查是否为直接跳转
        if [ ${#input} -gt 1 ]; then
            execute_direct_command "$input"
            return 1
        fi
        
        # 单个数字，在当前层级处理
        return 2
    fi
    
    log_warning "无效输入: $input"
    return 1
}

# 执行直接命令
execute_direct_command() {
    local command="$1"
    log_info "执行直接命令: $command"
    
    case "$command" in
        "111")
            execute_speed_test
            ;;
        "112")
            execute_network_test
            ;;
        "113")
            execute_hardware_test
            ;;
        "114")
            execute_system_test
            ;;
        "121")
            execute_docker_install
            ;;
        "122")
            execute_env_config
            ;;
        "123")
            execute_software_install
            ;;
        "124")
            execute_system_optimize
            ;;
        "131")
            execute_system_clean
            ;;
        "132")
            execute_log_manage
            ;;
        "133")
            execute_backup_restore
            ;;
        "134")
            execute_security_check
            ;;
        "141")
            execute_performance_monitor
            ;;
        "142")
            execute_resource_monitor
            ;;
        "143")
            execute_service_monitor
            ;;
        "144")
            execute_alert_config
            ;;
        "151")
            execute_file_manage
            ;;
        "152")
            execute_process_manage
            ;;
        "153")
            execute_network_tools
            ;;
        "154")
            execute_system_info
            ;;
        *)
            log_error "未知命令: $command"
            ;;
    esac
    
    echo ""
    read -p "按回车键继续..."
}

# 主菜单
show_main_menu() {
    CURRENT_PATH="主菜单"
    
    while true; do
        show_banner
        show_navigation_tips
        
        echo -e "${GREEN}=== VPS服务器小助手 ===${NC}"
        echo ""
        echo "1. 前辈脚本 - 经典实用脚本集合"
        echo "2. 老几脚本 - 待补充功能"
        echo ""
        
        read -p "请选择功能 [1-2]: " choice
        
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
        esac
    done
}

# 前辈脚本菜单
show_veteran_scripts_menu() {
    CURRENT_PATH="主菜单 > 前辈脚本"
    
    while true; do
        show_banner
        show_navigation_tips
        
        echo -e "${GREEN}=== 前辈脚本 ===${NC}"
        echo ""
        echo "11. 测试脚本 - 系统性能和网络测试"
        echo "12. 安装脚本 - 软件和环境安装"
        echo "13. 维护脚本 - 系统维护和清理"
        echo "14. 监控脚本 - 系统监控和告警"
        echo "15. 工具脚本 - 实用工具集合"
        echo ""
        
        read -p "请选择功能 [11-15]: " choice
        
        handle_input "$choice" "veteran"
        local result=$?
        
        case $result in
            0) # 返回上一层
                return
                ;;
            1) # 重新显示菜单
                continue
                ;;
            2) # 处理选择
                case "$choice" in
                    "11")
                        show_test_scripts_menu
                        ;;
                    "12")
                        show_install_scripts_menu
                        ;;
                    "13")
                        show_maintenance_scripts_menu
                        ;;
                    "14")
                        show_monitor_scripts_menu
                        ;;
                    "15")
                        show_tool_scripts_menu
                        ;;
                    *)
                        log_warning "无效选择: $choice"
                        echo ""
                        read -p "按回车键继续..."
                        ;;
                esac
                ;;
        esac
    done
}

# 测试脚本菜单
show_test_scripts_menu() {
    CURRENT_PATH="主菜单 > 前辈脚本 > 测试脚本"
    
    while true; do
        show_banner
        show_navigation_tips
        
        echo -e "${GREEN}=== 测试脚本 ===${NC}"
        echo ""
        echo "111. 测速脚本 - 网络速度测试"
        echo "112. 网络测试 - 网络连通性测试"
        echo "113. 硬件测试 - 硬件性能测试"
        echo "114. 系统测试 - 系统综合测试"
        echo ""
        
        read -p "请选择功能 [111-114]: " choice
        
        handle_input "$choice" "test"
        local result=$?
        
        case $result in
            0) # 返回上一层
                return
                ;;
            1) # 重新显示菜单
                continue
                ;;
            2) # 处理选择
                case "$choice" in
                    "111")
                        execute_speed_test
                        ;;
                    "112")
                        execute_network_test
                        ;;
                    "113")
                        execute_hardware_test
                        ;;
                    "114")
                        execute_system_test
                        ;;
                    *)
                        log_warning "无效选择: $choice"
                        ;;
                esac
                echo ""
                read -p "按回车键继续..."
                ;;
        esac
    done
}

# 安装脚本菜单
show_install_scripts_menu() {
    CURRENT_PATH="主菜单 > 前辈脚本 > 安装脚本"
    
    while true; do
        show_banner
        show_navigation_tips
        
        echo -e "${GREEN}=== 安装脚本 ===${NC}"
        echo ""
        echo "121. Docker安装 - Docker环境一键安装"
        echo "122. 环境配置 - 开发环境配置"
        echo "123. 软件安装 - 常用软件安装"
        echo "124. 系统优化 - 系统性能优化"
        echo ""
        
        read -p "请选择功能 [121-124]: " choice
        
        handle_input "$choice" "install"
        local result=$?
        
        case $result in
            0) # 返回上一层
                return
                ;;
            1) # 重新显示菜单
                continue
                ;;
            2) # 处理选择
                case "$choice" in
                    "121")
                        execute_docker_install
                        ;;
                    "122")
                        execute_env_config
                        ;;
                    "123")
                        execute_software_install
                        ;;
                    "124")
                        execute_system_optimize
                        ;;
                    *)
                        log_warning "无效选择: $choice"
                        ;;
                esac
                echo ""
                read -p "按回车键继续..."
                ;;
        esac
    done
}

# 维护脚本菜单
show_maintenance_scripts_menu() {
    CURRENT_PATH="主菜单 > 前辈脚本 > 维护脚本"
    
    while true; do
        show_banner
        show_navigation_tips
        
        echo -e "${GREEN}=== 维护脚本 ===${NC}"
        echo ""
        echo "131. 系统清理 - 清理系统垃圾文件"
        echo "132. 日志管理 - 系统日志管理"
        echo "133. 备份恢复 - 数据备份和恢复"
        echo "134. 安全检查 - 系统安全检查"
        echo ""
        
        read -p "请选择功能 [131-134]: " choice
        
        handle_input "$choice" "maintenance"
        local result=$?
        
        case $result in
            0) # 返回上一层
                return
                ;;
            1) # 重新显示菜单
                continue
                ;;
            2) # 处理选择
                case "$choice" in
                    "131")
                        execute_system_clean
                        ;;
                    "132")
                        execute_log_manage
                        ;;
                    "133")
                        execute_backup_restore
                        ;;
                    "134")
                        execute_security_check
                        ;;
                    *)
                        log_warning "无效选择: $choice"
                        ;;
                esac
                echo ""
                read -p "按回车键继续..."
                ;;
        esac
    done
}

# 监控脚本菜单
show_monitor_scripts_menu() {
    CURRENT_PATH="主菜单 > 前辈脚本 > 监控脚本"
    
    while true; do
        show_banner
        show_navigation_tips
        
        echo -e "${GREEN}=== 监控脚本 ===${NC}"
        echo ""
        echo "141. 性能监控 - 系统性能实时监控"
        echo "142. 资源监控 - 系统资源使用监控"
        echo "143. 服务监控 - 服务状态监控"
        echo "144. 告警设置 - 监控告警配置"
        echo ""
        
        read -p "请选择功能 [141-144]: " choice
        
        handle_input "$choice" "monitor"
        local result=$?
        
        case $result in
            0) # 返回上一层
                return
                ;;
            1) # 重新显示菜单
                continue
                ;;
            2) # 处理选择
                case "$choice" in
                    "141")
                        execute_performance_monitor
                        ;;
                    "142")
                        execute_resource_monitor
                        ;;
                    "143")
                        execute_service_monitor
                        ;;
                    "144")
                        execute_alert_config
                        ;;
                    *)
                        log_warning "无效选择: $choice"
                        ;;
                esac
                echo ""
                read -p "按回车键继续..."
                ;;
        esac
    done
}

# 工具脚本菜单
show_tool_scripts_menu() {
    CURRENT_PATH="主菜单 > 前辈脚本 > 工具脚本"
    
    while true; do
        show_banner
        show_navigation_tips
        
        echo -e "${GREEN}=== 工具脚本 ===${NC}"
        echo ""
        echo "151. 文件管理 - 文件操作工具"
        echo "152. 进程管理 - 进程管理工具"
        echo "153. 网络工具 - 网络诊断工具"
        echo "154. 系统信息 - 系统信息查看"
        echo ""
        
        read -p "请选择功能 [151-154]: " choice
        
        handle_input "$choice" "tools"
        local result=$?
        
        case $result in
            0) # 返回上一层
                return
                ;;
            1) # 重新显示菜单
                continue
                ;;
            2) # 处理选择
                case "$choice" in
                    "151")
                        execute_file_manage
                        ;;
                    "152")
                        execute_process_manage
                        ;;
                    "153")
                        execute_network_tools
                        ;;
                    "154")
                        execute_system_info
                        ;;
                    *)
                        log_warning "无效选择: $choice"
                        ;;
                esac
                echo ""
                read -p "按回车键继续..."
                ;;
        esac
    done
}

# 老几脚本菜单 (待补充)
show_old_scripts_menu() {
    CURRENT_PATH="主菜单 > 老几脚本"
    
    while true; do
        show_banner
        show_navigation_tips
        
        echo -e "${GREEN}=== 老几脚本 ===${NC}"
        echo ""
        echo -e "${YELLOW}此功能正在开发中，敬请期待...${NC}"
        echo ""
        
        read -p "按回车键返回上一层..."
        return
    done
}

# 功能执行函数 (占位符，待实现具体功能)
execute_speed_test() {
    log_step "执行测速脚本..."
    echo "正在进行网络速度测试..."
    echo "此功能将集成知名测速脚本"
}

execute_network_test() {
    log_step "执行网络测试..."
    echo "正在进行网络连通性测试..."
    echo "此功能将集成网络诊断工具"
}

execute_hardware_test() {
    log_step "执行硬件测试..."
    echo "正在进行硬件性能测试..."
    echo "此功能将集成硬件测试工具"
}

execute_system_test() {
    log_step "执行系统测试..."
    echo "正在进行系统综合测试..."
    echo "此功能将集成系统测试工具"
}

execute_docker_install() {
    log_step "执行Docker安装..."
    echo "正在安装Docker环境..."
    echo "此功能将集成Docker安装脚本"
}

execute_env_config() {
    log_step "执行环境配置..."
    echo "正在配置开发环境..."
    echo "此功能将集成环境配置脚本"
}

execute_software_install() {
    log_step "执行软件安装..."
    echo "正在安装常用软件..."
    echo "此功能将集成软件安装脚本"
}

execute_system_optimize() {
    log_step "执行系统优化..."
    echo "正在优化系统性能..."
    echo "此功能将集成系统优化脚本"
}

execute_system_clean() {
    log_step "执行系统清理..."
    echo "正在清理系统垃圾文件..."
    echo "此功能将集成系统清理脚本"
}

execute_log_manage() {
    log_step "执行日志管理..."
    echo "正在管理系统日志..."
    echo "此功能将集成日志管理脚本"
}

execute_backup_restore() {
    log_step "执行备份恢复..."
    echo "正在进行数据备份..."
    echo "此功能将集成备份恢复脚本"
}

execute_security_check() {
    log_step "执行安全检查..."
    echo "正在进行安全检查..."
    echo "此功能将集成安全检查脚本"
}

execute_performance_monitor() {
    log_step "执行性能监控..."
    echo "正在启动性能监控..."
    echo "此功能将集成性能监控工具"
}

execute_resource_monitor() {
    log_step "执行资源监控..."
    echo "正在启动资源监控..."
    echo "此功能将集成资源监控工具"
}

execute_service_monitor() {
    log_step "执行服务监控..."
    echo "正在启动服务监控..."
    echo "此功能将集成服务监控工具"
}

execute_alert_config() {
    log_step "执行告警设置..."
    echo "正在配置监控告警..."
    echo "此功能将集成告警配置工具"
}

execute_file_manage() {
    log_step "执行文件管理..."
    echo "正在启动文件管理工具..."
    echo "此功能将集成文件管理工具"
}

execute_process_manage() {
    log_step "执行进程管理..."
    echo "正在启动进程管理工具..."
    echo "此功能将集成进程管理工具"
}

execute_network_tools() {
    log_step "执行网络工具..."
    echo "正在启动网络诊断工具..."
    echo "此功能将集成网络诊断工具"
}

execute_system_info() {
    log_step "执行系统信息查看..."
    echo "正在查看系统信息..."
    echo "此功能将集成系统信息工具"
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