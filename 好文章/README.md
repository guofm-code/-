# 网页批量转PDF工具

一个支持 AI 智能提取的网页批量转 PDF 脚本，专门用于将网页文章（微信公众号、科研博客等）一键转换为 PDF，并利用 Kimi 2.5 AI 自动提取“标题-作者-日期”进行标准化命名，特别针对微信公众号文章优化。

## 功能特点

- **AI 智能提取**：使用 Kimi AI 分析网页内容，自动提取标题、作者、日期
- **本地解析备份**：AI 提取失败时自动使用本地解析规则
- **微信公众号优化**：针对微信文章结构专门优化提取逻辑
- **图片懒加载处理**：自动滚动页面确保所有图片加载完成
- **智能文件名**：按 "标题 - 作者 - 日期.pdf" 格式自动命名

## 快速上手

### 第一步：安装 Python

确保已安装 Python 3.8 或更高版本：
```bash
python --version
```
⚠️ 重要：安装时请务必勾选底部的 “Add Python to PATH”，否则工具无法启动

### 第二步：一键安装环境

双击运行 `setup.bat`，或在命令行执行：
```bash
pip install -r requirements.txt
python -m playwright install chromium
```

### 第三步：配置 API Key

首次运行时会自动生成 `config.json` 文件，请按提示填写 API Key。

1. 打开 `config.json` 文件
2. 将 `"api_key"` 的值 `"你的API密钥"` 替换为你的 Kimi API Key
3. 保存文件

**获取 Kimi API Key 的方法**：
1. 访问 https://platform.moonshot.cn/
2. 注册/登录账号
3. 进入 "API Key 管理" 页面
4. 点击 "新建" 创建 API Key
5. 复制 Key 并粘贴到 config.json 中

### 第四步：添加 URL

编辑 `urls.txt` 文件，每行添加一个要转换的网页链接：
```
https://mp.weixin.qq.com/s/xxxxx
https://mp.weixin.qq.com/s/yyyyy
https://example.com/article
```

### 第五步：运行工具

在命令行执行：
```python url_to_pdf.py
```

转换完成的 PDF 会保存在 `Research_Archive` 文件夹中。

## 文件说明

| 文件                  | 说明                   |
| ------------------- | -------------------- |
| `url_to_pdf.py`     | 主程序脚本                |
| `setup.bat`         | 一键安装环境（双击运行）         |
| `run_tool.bat`      | 一键运行工具（双击运行）         |
| `config.json`       | API 配置文件（需填写自己的 Key） |
| `urls.txt`          | 待转换的 URL 列表          |
| `requirements.txt`  | Python 依赖库列表         |
| `Research_Archive/` | 输出的 PDF 文件夹          |

## 常见问题

**Q: 提示"未检测到有效的 API Key"怎么办？**
A: 请检查 config.json 文件中的 api_key 是否已替换为你的真实 Key，且没有多余的空格。

**Q: 图片没有加载出来怎么办？**
A: 脚本已包含图片懒加载处理，如果某些网页图片特别多，可以适当增加等待时间。

**Q: 可以转换非微信文章吗？**
A: 可以，脚本支持任意网页，但微信文章有专门的优化提取规则。

**Q: API 调用失败怎么办？**
A: 脚本会自动回退到本地解析模式，无需担心。你可以在 Kimi 控制台查看 API 调用情况和余额。
