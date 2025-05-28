#!/bin/bash

# IMSH 自动安装脚本
# 版本: 1.0.0
# 用途: 帮助用户快速集成IMSH到现有项目

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

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

# 检测项目框架
detect_framework() {
    log_info "正在检测项目框架..."
    
    if [ -f "composer.json" ] && grep -q "topthink/framework" composer.json; then
        FRAMEWORK="thinkphp"
        log_success "检测到 ThinkPHP 框架"
    elif [ -f "composer.json" ] && grep -q "laravel/framework" composer.json; then
        FRAMEWORK="laravel"
        log_success "检测到 Laravel 框架"
    elif [ -f "composer.json" ] && grep -q "codeigniter4/framework" composer.json; then
        FRAMEWORK="codeigniter"
        log_success "检测到 CodeIgniter 框架"
    elif [ -f "package.json" ] && grep -q "express" package.json; then
        FRAMEWORK="express"
        log_success "检测到 Express.js 框架"
    elif [ -f "requirements.txt" ] && grep -q "Django" requirements.txt; then
        FRAMEWORK="django"
        log_success "检测到 Django 框架"
    elif [ -f "requirements.txt" ] && grep -q "Flask" requirements.txt; then
        FRAMEWORK="flask"
        log_success "检测到 Flask 框架"
    else
        FRAMEWORK="unknown"
        log_warning "未能自动检测框架类型，将提供通用集成方案"
    fi
}

# 复制IMSH文件
copy_imsh_files() {
    log_info "正在复制IMSH文件..."
    
    # 创建IMSH目录
    mkdir -p IMSH/im
    
    # 复制核心文件
    if [ -f "IMSH/im.sh" ]; then
        log_info "IMSH文件已存在，跳过复制"
    else
        # 这里应该从远程下载或从当前目录复制
        log_warning "请手动将IMSH目录复制到项目根目录"
        return 1
    fi
    
    log_success "IMSH文件复制完成"
}

# 显示集成指南
show_integration_guide() {
    echo ""
    echo "=================================================="
    echo "           IMSH 集成指南"
    echo "=================================================="
    echo ""
    
    case $FRAMEWORK in
        "thinkphp")
            echo "ThinkPHP 集成方法："
            echo ""
            echo "1. 修改 route/app.php 文件："
            echo "   在文件开头添加："
            echo "   Route::any(\"/\", function() { require_once root_path() . 'IMSH/im/im.php'; });"
            echo ""
            echo "2. 确保原有路由在IMSH路由之后"
            echo ""
            ;;
        "laravel")
            echo "Laravel 集成方法："
            echo ""
            echo "1. 修改 routes/web.php 文件："
            echo "   在文件开头添加："
            echo "   Route::any('/', function() { require_once base_path('IMSH/im/im.php'); });"
            echo ""
            ;;
        "express")
            echo "Express.js 集成方法："
            echo ""
            echo "1. 在主应用文件中添加："
            echo "   app.all('/', (req, res) => {"
            echo "     if (req.get('User-Agent').includes('curl')) {"
            echo "       res.sendFile(path.join(__dirname, 'IMSH/im.sh'));"
            echo "     } else {"
            echo "       // 调用原有路由处理"
            echo "     }"
            echo "   });"
            echo ""
            ;;
        *)
            echo "通用集成方法："
            echo ""
            echo "1. 在您的主路由文件中添加根路径处理"
            echo "2. 检测User-Agent是否包含'curl'"
            echo "3. 是：返回IMSH/im.sh文件内容"
            echo "4. 否：调用原有首页逻辑"
            echo ""
            echo "详细文档请查看 IMSH/README.md"
            ;;
    esac
    
    echo "=================================================="
    echo "使用方法："
    echo "curl -fsSL yourdomain.com | bash"
    echo "=================================================="
}

# 主函数
main() {
    echo "=================================================="
    echo "           IMSH 自动安装工具"
    echo "           一行代码，智能检测"
    echo "=================================================="
    echo ""
    
    # 检测框架
    detect_framework
    echo ""
    
    # 复制文件
    copy_imsh_files
    echo ""
    
    # 显示集成指南
    show_integration_guide
    
    echo ""
    log_success "安装完成！请按照上述指南完成集成。"
    echo ""
}

# 执行主函数
main "$@" 