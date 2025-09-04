# NoneBot-Webui-Docker

<div align="center">
  <img src="https://raw.githubusercontent.com/NonebotGUI/nonebot-flutter-webui-dashboard/refs/heads/main/lib/assets/logo.png" alt="nonebot-flutter-gui" width="320" height="320" /><br>
</div>

<div align="center" style="font-size:20px;">
    ✨ NoneBot Webui Docker安装版本 ✨
</div>

[DockerHub](https://hub.docker.com/r/myxuebi/nonebot-webui) 

✨容器已更换为Debian系统,可放心使用✨

## ⚙️安装容器

#### Docker加速站(自建)
使用文档：[Docker加速服务](https://docker.myxuebi.top/) 

加速URL: ```https://docker.myxuebi.top/```

### 命令行安装运行 （推荐）
```shell
sudo docker run -d  \
    -p 8025:8025 \
    -p 2519:2519 \
    -v /opt/nb-webui:/data \
    --name nonebot-webui \
    --restart=always \
    myxuebi/nonebot-webui:latest
```
镜像WebUI初始密码为：123456 

需修改看下面配置

### Dockerfile 自构建运行
```shell
git clone https://github.com/NonebotGUI/nonebot-webui-docker
cd nonebot-webui-docker
sudo docker build -t nonebot-webui .
sudo docker run -d -p 8025:8025 -p 2519:2519 -v /opt/nb-webui:/data nonebot-webui
```

## 📑 配置
### 修改密码
1.修改 /opt/nb-webui/dashboard/config.json 内的password值 

2.sudo docker restart nonebot-webui 重启服务就可以修改成功

### 修改配置文件
已挂载到本地

dashboard配置文件：/opt/nb-webui/dashboard/config.json 

agent配置文件：/opt/nb-webui/agent/config.json 

⚠️注意⚠️： 
后端token默认为123456，若需开放到公网请修改token！！！！

## 🖼️ 登录
WebUI地址：http://<宿主机IP>:8025/

## ⚠️ 已知问题
在 protocol 模式下（默认） 有可能出现CPU、内存无法显示正常值的情况
![bug](img/bug.png) 


需要静等作者修复~ 

但是好像得等等了？ 

![yefeng](img/msg.png)