# OneAIFW 本地服务使用教程

## 简介
OneAIFW 是一个 AI 隐私防火墙，可以在发送数据给 AI 之前自动脱敏敏感信息（邮箱、手机号、身份证号等），收到回复后再还原。

## 安装位置
- 项目目录：`C:\Users\22961\aifw\py-origin`
- 虚拟环境：`.venv`
- 配置文件：`C:\Users\22961\.aifw\aifw.yaml`

## 启动服务

### 方法一：命令行启动
```bash
# 进入目录
cd C:\Users\22961\aifw\py-origin

# 激活虚拟环境
.venv\Scripts\activate

# 启动服务
python -c "from services.app.main import app; import uvicorn; uvicorn.run(app, host='0.0.0.0', port=8844)"
```

### 方法二：批处理文件（推荐）
创建 `start-aifw.bat` 文件，内容如下：
```bat
@echo off
cd C:\Users\22961\aifw\py-origin
.venv\Scripts\python.exe -c "from services.app.main import app; import uvicorn; uvicorn.run(app, host='0.0.0.0', port=8844)"
pause
```
以后双击此文件即可启动。

## 检查服务状态
```bash
curl http://localhost:8844/api/health
```
返回 `{"status":"ok"}` 表示服务正常。

## API 使用示例

### 1. 脱敏文本
```python
import requests

data = {'text': '我的邮箱是 li_lei@example.com，电话是 13812345678'}
resp = requests.post('http://localhost:8844/api/mask_text', json=data)
result = resp.json()
print(result['output']['text'])
# 输出：我的邮箱是 __PII_EMAIL_ADDRESS_1__，电话是 __PII_PHONE_NUMBER_2__
```

### 2. 还原文本
```python
restore_data = {
    'text': result['output']['text'],
    'maskMeta': result['output']['maskMeta']
}
resp2 = requests.post('http://localhost:8844/api/restore_text', json=restore_data)
print(resp2.json()['output']['text'])
# 输出：我的邮箱是 li_lei@example.com，电话是 13812345678
```

## 支持的敏感信息类型
- 邮箱地址
- 手机号码
- 身份证号
- 银行卡号
- IP 地址
- URL 链接
- 姓名
- 公司名称
- API 密钥、密码

## 停止服务
关闭运行服务的命令行窗口，或按 `Ctrl+C`。

## 注意事项
1. 服务默认运行在 http://localhost:8844
2. 每次开机后需要手动启动服务
3. 关闭命令行窗口会停止服务

---
创建时间：2026-02-04
