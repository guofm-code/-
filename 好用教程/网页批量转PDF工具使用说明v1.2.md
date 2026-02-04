# 网页批量转PDF工具

将网页文章（微信公众号、网页等）一键转换为 PDF，使用 Kimi AI 自动提取标题、作者、日期并智能命名。

---

## 使用方法

### 前置要求：安装 Python

本工具需要 **Python 3.8 或更高版本**。

**检查是否已安装：**
```bash
python --version
```

**未安装请下载：** https://www.python.org/downloads/

> ⚠️ **重要**：安装时务必勾选 **"Add Python to PATH"**，否则工具无法运行。

### 1. 首次使用 - 安装环境

双击运行 **\`setup.bat\`**，自动安装 Python 依赖库和浏览器组件。

### 2. 配置 API Key（可选但推荐）

打开 \`config.json\`，将你的 Kimi API Key 填入：

\`\`\`json
{
  "api_key": "sk-xxxxxxxxxxxxxxxxxxxxxxxx"
}
\`\`\`

**获取方式**：访问 https://platform.moonshot.cn/ → 注册登录 → API Key 管理 → 新建

> 不配置 API Key 也能使用，但准确率会降低。

### 3. 添加要转换的网页链接

打开 \`urls.txt\`，每行输入一个网址：

\`\`\`
https://mp.weixin.qq.com/s/xxxxx
https://example.com/article
\`\`\`

### 4. 运行转换

**双击 \`一键启动.bat\` 或 \`run.bat\`**

转换完成的 PDF 保存在 \`Research_Archive\` 文件夹。

---

## 文件说明

| 文件 | 用途 |
|------|------|
| \`url_to_pdf.py\` | 主程序 |
| \`setup.bat\` | 首次安装环境 |
| \`一键启动.bat\` / \`run.bat\` | 启动转换 |
| \`config.json\` | API 配置 |
| \`urls.txt\` | 待转换链接列表 |
| \`Research_Archive/\` | PDF 输出目录 |

---

## 常见问题

**Q: 不配置 API Key 能用吗？**
A: 能用，会使用本地解析模式，但准确率较低。

**Q: 图片没有加载？**
A: 脚本已处理懒加载，如仍有问题可能是网页限制。

**Q: 支持哪些网站？**
A: 支持所有网页，对微信公众号文章有特殊优化。
