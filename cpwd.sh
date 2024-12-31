#!/bin/bash

read -sp "请输入修改的密码：" PASSWORD
echo 

if [[ -z "$PASSWORD" ]]; then
    echo "密码不能为空，请重新运行脚本。"
    exit 1
fi

sed -i "s/\"token\": \".*\"/\"token\": \"$PASSWORD\"/g" /app/agent/config.json
sed -i "s/\"password\": \".*\"/\"password\": \"$PASSWORD\"/g" /app/dashboard/config.json
sed -i "s/\"token\": \".*\"/\"token\": \"$PASSWORD\"/g" /app/dashboard/config.json

rm -rf /app/dashboard/secret.key

echo "密码已成功更新。"
