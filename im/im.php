<?php
/**
 * IMSH 超级通用处理器
 * 一行代码适配所有PHP框架
 * 使用方法：require_once 'IMSH/universal.php';
 */

// 获取User-Agent
$userAgent = isset($_SERVER['HTTP_USER_AGENT']) ? $_SERVER['HTTP_USER_AGENT'] : '';
$isCurl = stripos($userAgent, 'curl') !== false;

if ($isCurl) {
    // 返回合并后的完整shell脚本
    $scriptDir = dirname(__DIR__);
    $mainScript = $scriptDir . '/im.sh';
    $navModule = $scriptDir . '/sh/im.sh.nav';
    $menuModule = $scriptDir . '/sh/im.sh.menu';
    
    if (file_exists($mainScript) && file_exists($navModule) && file_exists($menuModule)) {
        // 读取主脚本
        $script = file_get_contents($mainScript);
        
        // 读取模块文件
        $navContent = file_get_contents($navModule);
        $menuContent = file_get_contents($menuModule);
        
        // 移除模块文件的shebang行
        $navContent = preg_replace('/^#!/', '# ', $navContent);
        $menuContent = preg_replace('/^#!/', '# ', $menuContent);
        
        // 移除主脚本中的模块加载部分
        $script = preg_replace('/# 加载导航模块.*?fi\n/s', '', $script);
        $script = preg_replace('/# 加载菜单模块.*?fi\n/s', '', $script);
        
        // 在主脚本的适当位置插入模块内容
        $insertPoint = strpos($script, '# 🎯 智能执行检测');
        if ($insertPoint !== false) {
            $beforeInsert = substr($script, 0, $insertPoint);
            $afterInsert = substr($script, $insertPoint);
            
            $script = $beforeInsert . 
                     "# ===== 导航模块 =====\n" . $navContent . "\n\n" .
                     "# ===== 菜单模块 =====\n" . $menuContent . "\n\n" .
                     $afterInsert;
        }
    } else {
        $script = <<<'SCRIPT'
#!/bin/bash
echo "欢迎使用 IM.SH 智能安装脚本"
echo "脚本文件不完整，请检查服务器配置"
SCRIPT;
    }
    
    // 设置响应头
    header('Content-Type: text/plain; charset=utf-8');
    header('Content-Disposition: inline; filename="im.sh"');
    header('Cache-Control: no-cache, no-store, must-revalidate');
    header('Pragma: no-cache');
    header('Expires: 0');
    
    echo $script;
    exit;
}

// 非curl请求，自动检测框架并调用原控制器
function detectFrameworkAndHandle() {
    // 对于ThinkPHP框架，直接调用原Index控制器
    return handleThinkPHP();
}

function handleThinkPHP() {
    try {
        // ThinkPHP 6.x - 调用原本的Index控制器
        if (function_exists('app')) {
            // 获取App实例并传递给控制器
            $app = app();
            $controller = new \app\controller\Index($app);
            $request = request();
            return $controller->index($request);
        }
        
        // ThinkPHP 5.x 兼容
        if (class_exists('think\Controller')) {
            $controller = new \app\controller\Index();
            return $controller->index();
        }
        
    } catch (Exception $e) {
        // 如果控制器调用失败，记录错误并返回错误页面
        error_log("IMSH ThinkPHP Error: " . $e->getMessage());
        return getErrorHTML($e->getMessage());
    } catch (Error $e) {
        // 捕获Fatal Error
        error_log("IMSH ThinkPHP Fatal Error: " . $e->getMessage());
        return getErrorHTML($e->getMessage());
    }
    
    return getErrorHTML("无法找到原控制器");
}

function handleLaravel() {
    try {
        // 尝试调用Laravel的首页
        if (function_exists('view')) {
            return view('welcome');
        }
    } catch (Exception $e) {
        // 控制器不存在时的处理
    }
    
    return getDefaultHTML();
}

function handleCodeIgniter() {
    try {
        // CodeIgniter 4.x
        if (class_exists('CodeIgniter\CodeIgniter')) {
            $controller = new \App\Controllers\Home();
            return $controller->index();
        }
    } catch (Exception $e) {
        // 控制器不存在时的处理
    }
    
    return getDefaultHTML();
}

function handleYii() {
    try {
        if (class_exists('Yii')) {
            $controller = new \app\controllers\SiteController('site', Yii::$app);
            return $controller->actionIndex();
        }
    } catch (Exception $e) {
        // 控制器不存在时的处理
    }
    
    return getDefaultHTML();
}

function handleSymfony() {
    try {
        // Symfony处理逻辑
        if (class_exists('App\Controller\DefaultController')) {
            $controller = new \App\Controller\DefaultController();
            return $controller->index();
        }
    } catch (Exception $e) {
        // 控制器不存在时的处理
    }
    
    return getDefaultHTML();
}

function handleNativePHP() {
    // 尝试包含原来的index.php逻辑
    $indexFile = dirname(__DIR__) . '/index.php';
    if (file_exists($indexFile)) {
        // 防止重复包含
        ob_start();
        include $indexFile;
        $content = ob_get_clean();
        if (!empty($content)) {
            return $content;
        }
    }
    
    return getDefaultHTML();
}

function getDefaultHTML() {
    return <<<'HTML'
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>网站正常运行</title>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; padding: 50px; }
        .container { max-width: 600px; margin: 0 auto; }
        .success { color: #28a745; }
        .code { background: #f8f9fa; padding: 10px; border-radius: 5px; margin: 20px 0; }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="success">✅ 网站正常运行</h1>
        <p>IMSH已成功集成到您的网站</p>
        <div class="code">
            <strong>一键安装命令：</strong><br>
            <code>curl -fsSL <?php echo $_SERVER['HTTP_HOST']; ?> | bash</code>
        </div>
        <p>浏览器访问显示此页面，curl访问返回安装脚本</p>
    </div>
</body>
</html>
HTML;
}

function getErrorHTML($message) {
    return <<<HTML
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>网站错误</title>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; padding: 50px; }
        .container { max-width: 600px; margin: 0 auto; }
        .error { color: #dc3545; }
        .code { background: #f8f9fa; padding: 10px; border-radius: 5px; margin: 20px 0; }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="error">❌ 网站错误</h1>
        <p>IMSH无法找到原控制器，请检查您的PHP环境。</p>
        <div class="code">
            <strong>错误信息：</strong><br>
            <code>{$message}</code>
        </div>
        <p>请检查您的PHP环境，或者联系网站管理员。</p>
    </div>
</body>
</html>
HTML;
}

// 执行检测和处理
$result = detectFrameworkAndHandle();

// 根据框架类型输出结果
if (is_string($result)) {
    echo $result;
} elseif (is_object($result)) {
    // 处理框架响应对象
    if (method_exists($result, 'send')) {
        $result->send();
    } elseif (method_exists($result, 'getContent')) {
        echo $result->getContent();
    } else {
        echo $result;
    }
} else {
    echo getDefaultHTML();
} 