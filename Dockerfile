FROM debian
SHELL ["/bin/bash", "-c"]

WORKDIR /app

EXPOSE 8025
EXPOSE 2519

COPY entrypoint.sh /app/
COPY init.sh /

VOLUME /data

RUN apt update \
    && apt install curl python3 python3-pip python3-venv nano unzip pipx -y \
    && mkdir -p /app/agent \
    && mkdir -p /app/dashboard \
    && pipx install nb-cli \
    && pipx ensurepath \
    && source ~/.bashrc \
    && cd /app/agent \
    && ARCH=$(uname -m) \
    && if [ "$ARCH" = "x86_64" ]; then \
        ARCH="amd64"; \
    elif [ "$ARCH" = "aarch64" ]; then \
        ARCH="arm64"; \
    else \
        echo "Unsupported architecture"; \
        exit 1; \
    fi \
    && DOWN=$(curl https://api.github.com/repos/NonebotGUI/nonebot-agent/releases/latest | grep "browser_download_url" | grep linux | grep $ARCH | cut -d '"' -f 4) \
    && curl -OL $DOWN \
    && chmod 777 agent-linux-$ARCH \
    && timeout -s SIGKILL 6s ./agent-linux-$ARCH || true \
    && sed -i 's/"nbcli":"default"/"nbcli":"\/root\/.local\/bin\/nb"/g' config.json \
    && cd /app/dashboard \
    && DOWN_MAIN=$(curl https://api.github.com/repos/NonebotGUI/nonebot-flutter-webui-dashboard/releases/latest | grep "browser_download_url" | grep linux | grep $ARCH | cut -d '"' -f 4) \
    && DOWN_WEB=$(curl https://api.github.com/repos/NonebotGUI/nonebot-flutter-webui-dashboard/releases/latest | grep "browser_download_url" | grep canvaskit | cut -d '"' -f 4) \
    && curl -OL $DOWN_MAIN \
    && curl -OL $DOWN_WEB \
    && unzip dashboard-index-canvaskit.zip \
    && chmod 777 dashboard-linux-$ARCH \
    && rm dashboard-index-canvaskit.zip \
    && pip config set global.index-url https://mirrors.ustc.edu.cn/pypi/simple \
    && timeout -s SIGKILL 3s ./dashboard-linux-$ARCH || true \
    && sed -i 's/"connectionMode": 1/"connectionMode": 2/g' config.json \

ENTRYPOINT ["sh", "/init.sh"]