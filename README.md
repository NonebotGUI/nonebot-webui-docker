# NoneBot-Webui-Docker

<div align="center">
  <img src="https://raw.githubusercontent.com/NonebotGUI/nonebot-flutter-webui-dashboard/refs/heads/main/lib/assets/logo.png" alt="nonebot-flutter-gui" width="320" height="320" /><br>
</div>

<div align="center" style="font-size:20px;">
    ✨ NoneBot Webui Docker安装版本 ✨
</div>

<a title="Crowdin" target="_blank" href="https://hub.docker.com/r/myxuebi/nonebot-webui">
    <img src="https://img.shields.io/docker/pulls/myxuebi/nonebot-webui">
</a>

✨容器已更换为Debian系统,可放心使用✨

## ⚙️安装容器

#### Docker加速站(自建)
使用文档：[Docker加速服务](https://docker.myxuebi.top/) 

加速URL： ```https://docker-hub.myxuebi.top```

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

### Dockerfile 自构建运行
```shell
git clone https://github.com/NonebotGUI/nonebot-webui-docker
cd nonebot-webui-docker
sudo docker build -t nonebot-webui .
sudo docker run -d -p 8025:8025 -p 2519:2519 -v /opt/nb-webui:/data nonebot-webui
```

## 🖼️ 登录
WebUI地址：http://<宿主机IP>:8025/ 

查看WebUI登录密码：
```shell
grep '"password"' /opt/nb-webui/dashboard/config.json | awk -F '"' '{print $4}'
```

## 📑 配置
### 修改密码
1.修改 /opt/nb-webui/dashboard/config.json 内的password值 （只需要修改password值，不要修改token值，否则可能出现意外错误）

2.sudo docker restart nonebot-webui 重启服务就可以修改成功

### 修改配置文件
已挂载到本地

dashboard配置文件：/opt/nb-webui/dashboard/config.json 

agent配置文件：/opt/nb-webui/agent/config.json 


### Docker 磁盘挂载说明
> [!warning] 
> 未挂载目录前只能将bot数据放在/data目录下，否则会出错或造成严重后果
#### 已运行容器后追加挂载目录

1. 先停止并删除原有容器（不会影响本地已挂载的数据）：
   ```shell
   sudo docker stop nonebot-webui
   sudo docker rm nonebot-webui
   ```
2. 用原有命令重新 run，并在 -v 后面追加你需要的新挂载参数。例如：
   ```shell
   sudo docker run -d  \
       -p 8025:8025 \
       -p 2519:2519 \
       -v /opt/nb-webui:/data \
       -v /your/bot/path:/your/bot/path \
       --name nonebot-webui \
       --restart=always \
       myxuebi/nonebot-webui:latest
   ```
   这样不会影响原有的 /opt/nb-webui:/data 挂载，只是多挂载了一个子目录。

3. 在 WebUI 里将 bot 存放路径设置为 `/data/bot1`，即可让 bot 数据写入你新挂载的本地目录。

例如：
```shell
sudo docker run -d  \
       -p 8025:8025 \
       -p 2519:2519 \
       -v /opt/nb-webui:/data \
       -v /disk1/bot:/disk1/bot \
       --name nonebot-webui \
       --restart=always \
       myxuebi/nonebot-webui:latest
```
就是把本地的/disk1/bot文件夹挂载到docker里面了

> [!warning] 
> 注意：不要删除或修改原有的挂载参数，否则原有数据会丢失。

如果你希望将 bot 的数据（如配置、插件、日志等）永久存放在本地磁盘上，防止容器删除后数据丢失，可以通过 Docker 的挂载功能将本地目录映射到容器内的数据目录。

## 🗑️ 彻底删除容器(此操作会删除所有数据)
```shell
sudo docker stop nonebot-webui
sudo docker rm nonebot-webui
sudo docker rmi -f myxuebi/nonebot-webui
sudo rm -rf /opt/nb-webui/
```

## ⚠️ 已知问题
在 protocol 模式下（默认） 有可能出现CPU、内存无法显示正常值的情况
![bug](img/bug.png) 


需要静等作者修复~ 

但是好像得等等了？ 

![yefeng](img/msg.png)