

> 本指南介绍如何使用 Git + GitHub 实现 Obsidian 在手机、工作电脑、家用电脑之间的同步。
>
> 🤖 **Claude Code 可直接操作的步骤**：本指南中标注 🤖 的步骤可以让 Claude Code 直接帮你完成，只需要说出对应的话即可。

---

## 📋 准备工作

- [ ] 注册 GitHub 账号：https://github.com/signup
- [ ] 所有设备安装 Obsidian

---

## 第一步：第一台电脑（工作电脑）配置

> 💡 **提示**：标注 🤖 的步骤可以让 Claude Code 直接帮你操作

### 1.1 初始化 Git 仓库 🤖

打开 PowerShell/CMD，依次执行：

```bash
# 进入 Vault 目录（修改为你的实际路径）
cd "C:\Users\用户名\Documents\Obsidian Vault"

# 初始化 Git
git init

# 配置用户名和邮箱（随意填写，只是标记作用）
git config --global user.name "你的用户名"
git config --global user.email "你的邮箱"
```

> 💬 对 Claude Code 说："帮我初始化 Obsidian Vault 的 Git 仓库"

### 1.2 创建忽略文件 🤖

在 Vault 根目录创建 `.gitignore` 文件，内容如下：

> 💬 对 Claude Code 说："帮我创建 Obsidian 的 .gitignore 文件"

```gitignore
# Obsidian 工作区配置（不同设备布局不同，不建议同步）
.obsidian/workspace.json
.obsidian/workspace-mobile.json
.obsidian/cache/

# 系统文件
.DS_Store
Thumbs.db

# 临时文件
*.tmp
*.swp
*~
```

> 💡 **注意**：插件配置（`.obsidian/plugins/*/data.json`）**建议同步**，这样各设备的插件设置保持一致。如果某些插件需要在不同设备上用不同设置，可以单独添加到忽略列表。

### 1.3 第一次提交 🤖

```bash
# 添加所有文件
git add .

# 提交
git commit -m "Initial commit: Obsidian vault setup"
```

> 💬 对 Claude Code 说："帮我把 Vault 的更改提交到 Git"

### 1.4 创建 GitHub 仓库

1. 打开 https://github.com/new
2. 填写仓库名称，如 `obsidian-vault`
3. **不要勾选** "Initialize this repository with a README"
4. 选择 **Public**（公开）或 **Private**（私有需要 Token）
5. 点击 **Create repository**

### 1.5 连接远程仓库 🤖

在 GitHub 创建页面找到 push 命令，或执行：

```bash
git remote add origin https://github.com/你的用户名/仓库名.git
git branch -M main
git push -u origin main
```

> 💬 对 Claude Code 说："帮我连接 GitHub 远程仓库并推送"（需要提供仓库地址）

### 1.6 创建同步脚本（可选）🤖

创建 `sync.bat` 文件：

> 💬 对 Claude Code 说："帮我创建一个 Git 同步脚本 sync.bat"

```bat
@echo off
cd /d "%~dp0"

if "%1"=="pull" goto pull
if "%1"=="push" goto push

echo 用法: sync.bat push 或 sync.bat pull
goto end

:push
git add .
git commit -m "Update notes"
git push origin main
echo 推送完成！
goto end

:pull
git pull origin main
echo 拉取完成！
goto end

:end
pause
```

### 1.7 安装 Obsidian Git 插件

1. Obsidian 设置 → 第三方插件 → 关闭安全模式
2. 浏览插件 → 搜索 **Git** → 安装 **Obsidian Git**
3. 启用插件

### 1.8 配置 Obsidian Git 🤖

设置 → Obsidian Git → Options：

| 设置项 | 推荐值 |
|--------|--------|
| Vault backup interval | 30 |
| Auto pull interval | 10 |
| Commit message | `vault backup: {{date}}` |
| Pull updates on startup | ✅ 开启 |
| Push on backup | ✅ 开启 |
| Show status bar | ✅ 开启 |
| Author name for commits | 你的用户名 |
| Author email for commits | 你的邮箱 |

> 💬 对 Claude Code 说："帮我配置 Obsidian Git 插件的自动同步设置"

---

## 第二步：安卓手机配置

### 2.1 安装软件

1. **安装 Termux**：https://f-droid.org/packages/com.termux/
2. **安装 Obsidian**：应用商店或官网

### 2.2 Termux 配置

打开 Termux，依次执行：

```bash
# 更新软件包
pkg update && pkg upgrade

# 安装 Git
pkg install git

# 配置用户名邮箱
git config --global user.name "手机用户"
git config --global user.email "mobile@example.com"

# 给存储权限
termux-setup-storage
```

### 2.3 克隆仓库

```bash
cd /storage/emulated/0/Documents
git clone https://github.com/你的用户名/仓库名.git "Obsidian Vault"
```

如果仓库是私有的，会提示输入：
- Username: `你的GitHub用户名`
- Password: **Personal Access Token**（不是登录密码）

#### 创建 Personal Access Token

1. 电脑访问 https://github.com/settings/tokens
2. Generate new token (classic)
3. Note 填 `手机同步`
4. Expiration 选 `No expiration`
5. 勾选 `repo`
6. 点击 Generate token
7. **复制 token**（只显示一次）
8. 在手机上粘贴作为密码

### 2.4 记住凭证（避免每次输入）

```bash
git config --global credential.helper store
```

### 2.5 在 Obsidian 中打开 Vault

1. 打开 Obsidian
2. 管理仓库 → 打开本地文件夹
3. 选择：`/Documents/Obsidian Vault`

### 2.6 安装 Obsidian Git 插件

同电脑端步骤 1.7

### 2.7 配置 Obsidian Git

> ⚠️ **重要区别**：手机端**不需要**设置 "Path to git executable" 这个选项（该选项只在电脑端存在）。只需配置以下两项：

设置 → Obsidian Git：
- **Author name for commits**：你的用户名
- **Author email for commits**：你的邮箱

其他设置（备份间隔、自动拉取等）同电脑端步骤 1.8

### 2.8 手机端日常使用（Obsidian Git 插件方式）

#### 同步流程：

1. **编辑前** → 下拉刷新或点击 ↓ 拉取按钮
2. **编辑笔记**
3. **编辑后** → Source Control → 点击 + 暂存 → 点击 ✓ 提交 → 点击 ↑ 推送

#### 快捷操作：

| 按钮 | 功能 |
|------|------|
| ✓ | 提交（Commit） |
| ↑ | 推送（Push） |
| ↓ | 拉取（Pull） |
| + | 暂存文件（Stage） |

---

### 2.9 手机端日常使用（Termux 命令行方式）🤖

> 💡 **推荐**：使用 Termux 命令行比 Obsidian Git 插件更稳定可靠

#### 快捷命令配置 🤖

在 Termux 中执行以下命令创建快捷方式：

```bash
# 创建进入 Vault 的别名
git config --global alias.o '!cd ~/storage/shared/Documents/Obsidian\ Vault/'

# 创建一键同步别名（拉取+提交+推送）
git config alias.sync '!git pull origin main && git add -A && git commit -m "sync: $(date)" && git push origin main'
```

> 💬 对 Claude Code 说："帮我配置手机端 Git 快捷命令"

#### 日常使用流程

| 场景 | 命令 |
|------|------|
| **进入 Vault 目录** | `git o` |
| **一键同步**（拉取+提交+推送） | `git sync` |

#### 完整操作示例

**场景 A：手机端开始工作前（拉取电脑端的更改）**
```bash
git o          # 进入 Obsidian Vault 目录
git sync       # 拉取远程最新内容
```
然后打开手机 Obsidian 编辑笔记。

**场景 B：手机端编辑完成后（推送到电脑端）**
```bash
git o          # 进入 Obsidian Vault 目录
git sync       # 提交本地更改并推送到远程
```
然后电脑端执行 `git pull` 或点击 Obsidian Git 的 Pull 按钮即可看到更新。

#### ⚠️ 注意事项

1. **Token 缓存 15 分钟** - 如果提示输入密码，输入你的 GitHub Personal Access Token（`ghp_` 开头）
2. **先拉后推** - `git sync` 会自动先拉取再推送，避免冲突
3. **冲突处理** - 如果提示冲突，联系 Claude Code 帮你解决

---

## 第三步：家用电脑配置

### 3.1 克隆仓库

打开 PowerShell/CMD：

```bash
cd "C:\Users\用户名\Documents"
git clone https://github.com/你的用户名/仓库名.git "Obsidian Vault"
```

### 3.2 在 Obsidian 中打开

1. 打开 Obsidian
2. 管理仓库 → 打开本地文件夹
3. 选择克隆下来的 `Obsidian Vault` 文件夹

### 3.3 安装并配置 Obsidian Git 🤖

同工作电脑步骤 1.7、1.8

> 💬 对 Claude Code 说："帮我配置这台电脑的 Obsidian Git 插件"（需先安装插件）

---

## 📱 日常使用流程

### 场景 1：在电脑上编辑，手机查看

```
电脑：编辑 → 自动备份（30分钟）或手动 Commit + Push
手机：打开 Obsidian → 自动 Pull（启动时）或手动点击 ↓
```

### 场景 2：在手机上编辑，电脑查看

```
手机：编辑 → Source Control → + → ✓ → ↑
电脑：打开 Obsidian → 自动 Pull 或运行 sync.bat pull
```

### 场景 3：多设备同时编辑（⚠️ 不推荐）

如果产生冲突：

```bash
# 在 Termux 或 PowerShell 中
git pull origin main
# 手动解决冲突后
git add .
git commit -m "解决冲突"
git push
```

> 💬 对 Claude Code 说："帮我解决 Git 合并冲突"（需要描述冲突情况）

---

## ⚠️ 常见问题

### Q1: 推送时提示 "No commits to push"
- 原因：没有提交就推送了
- 解决：先点击 ✓ 提交，再点击 ↑ 推送

### Q2: 提示 "Git author name and email are not set"
- 原因：Obsidian Git 插件需要单独配置提交者信息
- 解决：设置 → Obsidian Git → 填写 Author name 和 Author email

### Q3: 手机推送需要每次都输入密码
- 原因：没有配置凭证助手
- 解决：Termux 运行 `git config --global credential.helper store`

### Q4: 电脑端 Obsidian Git 找不到 Git
- 原因：Git 路径未配置
- 解决：Obsidian Git 设置 → Advanced → Path to Git binary → 填写 `C:\Program Files\Git\bin\git.exe`

### Q5: 出现 .base 文件 🤖
- 原因：Git 合并冲突产生的备份
- 解决：直接删除，或让 Claude Code 帮你清理

---

## 🔧 纯命令行操作（备用）🤖

如果不使用 Obsidian Git 插件，可以使用命令行：

> 💬 对 Claude Code 说："帮我推送 Vault 的更改到 GitHub" 或 "帮我拉取最新笔记"

### 推送更改

```bash
git add .
git commit -m "更新笔记"
git push origin main
```

### 拉取更改

```bash
git pull origin main
```

### 查看状态

```bash
git status
```

---

## ✅ 同步检查清单

- [ ] 所有设备都能正常打开 Vault
- [ ] 电脑编辑后，手机能收到更新
- [ ] 手机编辑后，电脑能收到更新
- [ ] Obsidian Git 自动备份正常工作
- [ ] 了解如何解决冲突

---

## 📚 相关链接

- GitHub: https://github.com
- Obsidian Git 插件: https://github.com/denolehov/obsidian-git
- Termux: https://termux.dev/

---

**最后更新：** {{date}}
