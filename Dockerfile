FROM ubuntu:22.04

WORKDIR /app

EXPOSE 8025
EXPOSE 2519

COPY entrypoint.sh /app/
COPY cpwd.sh /app/

RUN sed -i 's@//.*archive.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list \
    && apt update \
    && apt install curl python3 python3-pip python3-venv nano unzip -y \
    && pip config set global.index-url https://mirrors.ustc.edu.cn/pypi/simple \
    && pip install nb-cli \
    && mkdir -p /app/agent \
    && mkdir -p /app/dashboard \
    && cd /app/agent \
    && DOWN=$(curl https://api.github.com/repos/NonebotGUI/nonebot-agent/releases/latest | grep "browser_download_url" | grep linux | cut -d '"' -f 4) \
    && curl -OL $DOWN \
    && chmod 777 agent-linux \
    && ./agent-linux || true \
    && sed -i 's/"token": ""/"token": "123456"/g' config.json \
    && cd /app/dashboard \
    && DOWN_MAIN=$(curl https://api.github.com/repos/NonebotGUI/nonebot-flutter-webui-dashboard/releases/latest | grep "browser_download_url" | grep linux | cut -d '"' -f 4) \
    && DOWN_WEB=$(curl https://api.github.com/repos/NonebotGUI/nonebot-flutter-webui-dashboard/releases/latest | grep "browser_download_url" | grep canvaskit | cut -d '"' -f 4) \
    && curl -OL $DOWN_MAIN \
    && curl -OL $DOWN_WEB \
    && unzip dashboard-index-canvaskit.zip \
    && chmod 777 dashboard-linux \
    && rm dashboard-index-canvaskit.zip

ENTRYPOINT ["bash", "entrypoint.sh"]