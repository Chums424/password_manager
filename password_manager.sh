#!/bin/bash

password_file="passwords.txt"

display_menu() {
	echo "パスワードマネージャーへようこそ！"
	echo "次の選択肢から入力してください(Add Password/Get Password/Exit)："
}

add_password() {
	echo "サービス名を入力してください："
	read service_name
	echo "ユーザー名を入力してください："
	read username
	echo "パスワードを入力してください："
	read password
	echo "サービス名：$service_name" >> "$password_file"
	echo "ユーザー名：$username" >> "$password_file"
	echo "パスワード：$password" >> "$password_file"
	echo "パスワードの追加は成功しました。"
}

get_password(){
	echo "サービス名を入力してください："
	read search_service
	found=false
	while IFS= read -r line; do
		if [[ $line == "サービス名：$search_service" ]]; then 
			found=true
			echo "$line"
			read -r line
			echo "$line"
			read -r line
			echo "$line"
			break
		fi
	done < "$password_file"
	if [ "$found" == false ]; then
		echo "そのサービスは登録されていません。"
	fi
}

while true; do
	display_menu
	read choice
	case "$choice" in
		"Add Password")
			add_password
			;;
		"Get Password")
			get_password
			;;
		"Exit")
			echo "Thank you!"
			exit 0
			;;
		*)echo "入力が間違えています。Add Password/Get Password/Exit から入力してください。"
		;;
	esac
done  

