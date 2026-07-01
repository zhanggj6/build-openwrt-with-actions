#!/bin/bash
# 本地测试脚本 - 模拟 SSH 配置同步流程
# 使用方法: bash test_local.sh

set -e

echo "=========================================="
echo "🧪 本地测试: SSH 配置同步流程"
echo "=========================================="

# 1. 创建模拟的 openWRT 目录和 .config
echo ""
echo "📁 Step 1: 创建模拟 SSH 修改后的 .config"
mkdir -p openWRT
cat > openWRT/.config << 'EOFCONFIG'
# SSH 修改后的配置文件
CONFIG_TARGET_x86_64=y
CONFIG_TARGET_BOARD="x86_64"
CONFIG_PACKAGE_luci=y
CONFIG_PACKAGE_curl=y
CONFIG_PACKAGE_wget=y
EOFCONFIG
echo "✅ openWRT/.config 已创建"
cat openWRT/.config

# 2. 复制到仓库根目录
echo ""
echo "📁 Step 2: 复制 .config 到仓库根目录"
cp -f openWRT/.config .config
echo "✅ 已复制"
cat .config

# 3. 显示 git 状态
echo ""
echo "📁 Step 3: Git 状态"
git status
git diff .config || echo "(无变化或新文件)"

# 4. 模拟提交
echo ""
echo "📁 Step 4: 模拟提交检查"
if [ -z "$(git diff --cached)" ] && [ -z "$(git diff)" ]; then
    echo "⚠️  文件内容相同，跳过实际提交"
else
    echo "📝 文件有变化"
fi

echo ""
echo "=========================================="
echo "✅ 本地测试完成!"
echo "=========================================="
echo ""
echo "实际 GitHub Actions 测试方法:"
echo "1. 推送这个测试 workflow 到 GitHub"
echo "2. 在 Actions 页面点击 '🧪 测试 SSH 配置同步流程'"
echo "3. 点击 'Run workflow' 按钮"
echo "4. 可以自定义 test_config_content 参数"
