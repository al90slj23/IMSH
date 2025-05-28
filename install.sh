#!/bin/bash

# IMSH 智能安装配置工具
# 版本: 2.0.0
# 用途: 帮助用户快速集成IMSH并自定义脚本

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# 全局变量
SCRIPT_NAME="im.sh"
DOMAIN_NAME=""
FRAMEWORK=""
PROJECT_NAME=""

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

log_step() {
    echo -e "${PURPLE}[STEP]${NC} $1"
}

# 显示横幅
show_banner() {
    clear
    echo -e "${CYAN}"
    echo "██╗███╗   ███╗███████╗██╗  ██╗"
    echo "██║████╗ ████║██╔════╝██║  ██║"
    echo "██║██╔████╔██║███████╗███████║"
    echo "██║██║╚██╔╝██║╚════██║██╔══██║"
    echo "██║██║ ╚═╝ ██║███████║██║  ██║"
    echo "╚═╝╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝"
    echo -e "${NC}"
    echo "=================================================="
    echo "        IMSH 智能安装配置工具 v2.0.0"
    echo "        让任何网站都能智能检测！"
    echo "=================================================="
    echo ""
}

# 收集用户配置
collect_user_config() {
    log_step "配置您的智能检测脚本"
    echo ""
    
    # 项目名称
    read -p "请输入您的项目名称 (如: MyVPS): " PROJECT_NAME
    if [ -z "$PROJECT_NAME" ]; then
        PROJECT_NAME="MyVPS"
    fi
    
    # 脚本名称
    echo ""
    echo "脚本名称建议："
    echo "  - 使用项目名.sh (如: myvps.sh)"
    echo "  - 使用域名.sh (如: example.sh)" 
    echo "  - 保持默认 im.sh"
    echo ""
    read -p "请输入脚本名称 (默认: im.sh): " SCRIPT_NAME
    if [ -z "$SCRIPT_NAME" ]; then
        SCRIPT_NAME="im.sh"
    fi
    
    # 确保以.sh结尾
    if [[ ! "$SCRIPT_NAME" =~ \.sh$ ]]; then
        SCRIPT_NAME="${SCRIPT_NAME}.sh"
    fi
    
    # 域名
    echo ""
    read -p "请输入您的域名 (如: example.com): " DOMAIN_NAME
    if [ -z "$DOMAIN_NAME" ]; then
        DOMAIN_NAME="yourdomain.com"
    fi
    
    echo ""
    log_info "配置信息："
    echo "  项目名称: $PROJECT_NAME"
    echo "  脚本名称: $SCRIPT_NAME"
    echo "  域名: $DOMAIN_NAME"
    echo ""
    
    read -p "确认配置？(y/N): " confirm
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        log_info "重新配置..."
        collect_user_config
    fi
}

# 检测项目框架
detect_framework() {
    log_step "检测项目框架..."
    
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
    elif [ -f "pom.xml" ]; then
        FRAMEWORK="spring"
        log_success "检测到 Spring Boot 框架"
    elif [ -f "*.csproj" ]; then
        FRAMEWORK="aspnet"
        log_success "检测到 ASP.NET Core 框架"
    else
        FRAMEWORK="unknown"
        log_warning "未能自动检测框架类型，将提供通用集成方案"
    fi
}

# 下载和配置IMSH文件
setup_imsh_files() {
    log_step "设置IMSH文件..."
    
    # 创建IMSH目录
    mkdir -p IMSH/im
    
    # 获取脚本所在目录
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    
    # 复制核心文件
    if [ ! -f "IMSH/im.sh" ]; then
        log_info "复制IMSH核心文件..."
        if [ -f "$SCRIPT_DIR/im.sh" ]; then
            cp "$SCRIPT_DIR/im.sh" IMSH/im.sh
            cp "$SCRIPT_DIR/im/im.php" IMSH/im/im.php
            cp "$SCRIPT_DIR/im/im.js" IMSH/im/im.js
            cp "$SCRIPT_DIR/im/im.py" IMSH/im/im.py
        else
            log_info "尝试从GitHub下载IMSH文件..."
            if command -v curl &> /dev/null; then
                curl -fsSL https://raw.githubusercontent.com/al90slj23/IMSH/main/im.sh -o IMSH/im.sh
                curl -fsSL https://raw.githubusercontent.com/al90slj23/IMSH/main/im/im.php -o IMSH/im/im.php
                curl -fsSL https://raw.githubusercontent.com/al90slj23/IMSH/main/im/im.js -o IMSH/im/im.js
                curl -fsSL https://raw.githubusercontent.com/al90slj23/IMSH/main/im/im.py -o IMSH/im/im.py
            else
                log_error "无法找到IMSH文件，请确保install.sh在IMSH目录中运行"
                return 1
            fi
        fi
    fi
    
    # 如果脚本名称不是im.sh，则重命名
    if [ "$SCRIPT_NAME" != "im.sh" ]; then
        log_info "创建自定义脚本: $SCRIPT_NAME"
        cp IMSH/im.sh "IMSH/$SCRIPT_NAME"
    fi
    
    # 自定义脚本内容
    customize_script
    
    log_success "IMSH文件设置完成"
}

# 自定义脚本内容
customize_script() {
    log_info "自定义脚本内容..."
    
    local script_file="IMSH/$SCRIPT_NAME"
    
    # 替换脚本中的项目信息
    sed -i "s/# IM.SH - 超强大VPS一键配置脚本/# $PROJECT_NAME - 超强大VPS一键配置脚本/" "$script_file"
    sed -i "s/# 网站: https:\/\/im.sh.cn/# 网站: https:\/\/$DOMAIN_NAME/" "$script_file"
    sed -i "s/IM.SH - 超强大VPS一键配置脚本/$PROJECT_NAME - 超强大VPS一键配置脚本/g" "$script_file"
    sed -i "s/网站: https:\/\/im.sh.cn/网站: https:\/\/$DOMAIN_NAME/g" "$script_file"
    
    # 更新检测文件中的脚本路径
    if [ "$SCRIPT_NAME" != "im.sh" ]; then
        sed -i "s/im\.sh/$SCRIPT_NAME/g" IMSH/im/im.php
        sed -i "s/im\.sh/$SCRIPT_NAME/g" IMSH/im/im.js
        sed -i "s/im\.sh/$SCRIPT_NAME/g" IMSH/im/im.py
    fi
    
    log_success "脚本内容自定义完成"
}

# 生成集成代码
generate_integration_code() {
    log_step "生成集成代码..."
    
    local integration_file="IMSH/integration_guide.txt"
    
    cat > "$integration_file" << EOF
================================================
$PROJECT_NAME 智能检测集成指南
================================================

您的配置：
- 项目名称: $PROJECT_NAME
- 脚本名称: $SCRIPT_NAME
- 域名: $DOMAIN_NAME

使用方法：
curl -fsSL $DOMAIN_NAME | bash

================================================
框架集成代码：
================================================

EOF

    case $FRAMEWORK in
        "thinkphp")
            cat >> "$integration_file" << EOF
ThinkPHP 集成方法：

1. 修改 route/app.php 文件，在开头添加：
   Route::any("/", function() { require_once root_path() . 'IMSH/im/im.php'; });

2. 确保此路由在其他路由之前

EOF
            ;;
        "laravel")
            cat >> "$integration_file" << EOF
Laravel 集成方法：

1. 修改 routes/web.php 文件，在开头添加：
   Route::any('/', function() { require_once base_path('IMSH/im/im.php'); });

EOF
            ;;
        "express")
            cat >> "$integration_file" << EOF
Express.js 集成方法：

1. 在主应用文件中添加：
   app.all('/', (req, res) => {
     const userAgent = req.get('User-Agent') || '';
     if (userAgent.toLowerCase().includes('curl')) {
       res.sendFile(path.join(__dirname, 'IMSH/$SCRIPT_NAME'));
     } else {
       // 调用原有首页逻辑
       res.render('index');
     }
   });

EOF
            ;;
        "django")
            cat >> "$integration_file" << EOF
Django 集成方法：

1. 在 views.py 中添加：
   def index(request):
       user_agent = request.META.get('HTTP_USER_AGENT', '').lower()
       if 'curl' in user_agent:
           with open('IMSH/$SCRIPT_NAME', 'r') as f:
               script = f.read()
           return HttpResponse(script, content_type='text/plain')
       else:
           return render(request, 'index.html')

2. 在 urls.py 中配置路由：
   path('', views.index, name='index'),

EOF
            ;;
        "flask")
            cat >> "$integration_file" << EOF
Flask 集成方法：

1. 在主应用文件中添加：
   @app.route('/')
   def index():
       user_agent = request.headers.get('User-Agent', '').lower()
       if 'curl' in user_agent:
           return send_file('IMSH/$SCRIPT_NAME', mimetype='text/plain')
       else:
           return render_template('index.html')

EOF
            ;;
        *)
            cat >> "$integration_file" << EOF
通用集成方法：

1. 在您的主路由处理器中：
   - 检测 User-Agent 是否包含 'curl'
   - 是：返回 IMSH/$SCRIPT_NAME 文件内容
   - 否：调用原有首页逻辑

2. 参考文档：IMSH/README.md

EOF
            ;;
    esac
    
    cat >> "$integration_file" << EOF
================================================
测试方法：
================================================

1. 浏览器访问: http://$DOMAIN_NAME
   应该显示您的正常网站

2. curl访问: curl $DOMAIN_NAME
   应该返回脚本内容

3. 一键执行: curl -fsSL $DOMAIN_NAME | bash
   应该执行您的VPS配置脚本

================================================
自定义脚本：
================================================

编辑 IMSH/$SCRIPT_NAME 文件来自定义您的安装逻辑：

1. 修改横幅和项目信息
2. 添加您的软件安装逻辑
3. 自定义安装选项和菜单
4. 添加您的配置和优化

================================================
更多帮助：
================================================

- 框架集成文档: IMSH/README.md
- 脚本功能文档: IMSH/SCRIPT_README.md
- GitHub项目: https://github.com/al90slj23/IMSH

EOF

    log_success "集成指南已生成: $integration_file"
}

# 显示完成信息
show_completion() {
    echo ""
    echo "=================================================="
    echo "           🎉 IMSH 配置完成！"
    echo "=================================================="
    echo ""
    log_success "您的智能检测脚本已配置完成："
    echo ""
    echo "📁 文件结构："
    echo "  IMSH/"
    echo "  ├── $SCRIPT_NAME          # 您的自定义脚本"
    echo "  ├── im.sh                 # 原始脚本备份"
    echo "  ├── integration_guide.txt # 集成指南"
    echo "  └── im/"
    echo "      ├── im.php            # PHP检测逻辑"
    echo "      ├── im.js             # Node.js检测逻辑"
    echo "      └── im.py             # Python检测逻辑"
    echo ""
    echo "🚀 下一步："
    echo "  1. 查看集成指南: cat IMSH/integration_guide.txt"
    echo "  2. 按照指南修改您的路由配置"
    echo "  3. 自定义脚本内容: nano IMSH/$SCRIPT_NAME"
    echo "  4. 测试功能: curl $DOMAIN_NAME"
    echo ""
    echo "🎯 使用方法："
    echo "  curl -fsSL $DOMAIN_NAME | bash"
    echo ""
    echo "=================================================="
    echo "           感谢使用 IMSH 智能检测框架！"
    echo "=================================================="
}

# 主函数
main() {
    # 显示横幅
    show_banner
    
    # 收集用户配置
    collect_user_config
    
    # 检测框架
    detect_framework
    echo ""
    
    # 设置IMSH文件
    setup_imsh_files
    echo ""
    
    # 生成集成代码
    generate_integration_code
    echo ""
    
    # 显示完成信息
    show_completion
}

# 执行主函数
main "$@" 