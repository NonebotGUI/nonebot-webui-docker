#!/bin/bash

# 读取用户输入的密码
read -sp "请输入修改的密码：" PASSWORD
echo  # 换行

# 检查输入是否为空
if [[ -z "$PASSWORD" ]]; then
    echo "密码不能为空，请重新运行脚本。"
    exit 1
fi

# 修改配置文件中的 token 和 password
sed -i "s/\"token\": \".*\"/\"token\": \"$PASSWORD\"/g" /app/agent/config.json
sed -i "s/\"password\": \".*\"/\"password\": \"$PASSWORD\"/g" /app/dashboard/config.json
sed -i "s/\"token\": \".*\"/\"token\": \"$PASSWORD\"/g" /app/dashboard/config.json

rm -rf /app/dashboard/secret.key

echo "密码已成功更新。"
