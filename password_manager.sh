#!/bin/bash

echo "パスワードマネージャーへようこそ！"

read -p "サービス名を入力してください：" service

read -p "ユーザー名を入力してください：" username

read -s -p "パスワードを入力してください：" password

echo "hello"

echo "Thank you!"

echo "$service;$username;$password" >> passwords.txt


