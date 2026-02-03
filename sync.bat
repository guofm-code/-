@echo off
chcp 65001 >nul
cd /d "%~dp0"

echo === Obsidian Vault 同步工具 ===
echo.

if "%1"=="pull" goto pull
if "%1"=="push" goto push

echo 用法:
echo   sync.bat push  - 推送本地更改到 GitHub
echo   sync.bat pull  - 拉取远程更改到本地
echo.
goto end

:push
echo [1/3] 检查本地更改...
git status --short
echo.
echo [2/3] 添加所有更改...
git add .
echo.
echo [3/3] 提交并推送...
set /p msg="请输入提交信息 (直接回车使用默认): "
if "%msg%"=="" set msg="Update notes"
git commit -m "%msg%"
git push origin main
echo.
echo ✅ 推送完成！
goto end

:pull
echo [1/2] 拉取远程更改...
git pull origin main
echo.
echo ✅ 同步完成！
goto end

:end
echo.
pause
