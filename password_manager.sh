#!/bin/bash

# GnuPGのキーID
gpg_key="D7E31FCDBFE72353"

while true; do
	# パスワードマネージャーのメニュー表示
	echo "パスワードマネージャーへようこそ！"
	echo "次の選択肢から入力してください(Add Password/Get Password/Exit)："
	read choice

	# Add Password が入力された場合
	if [ "$choice" == "Add Password" ]; then
		echo "サービス名を入力してください："
		read service_name
		echo "ユーザー名を入力してください："
		read username
		echo "パスワードを入力してください："
		read -s password
                
                temp_file="${service_name}.txt"

		# パスワード情報をファイルに追記
		echo "サービス名：$service_name" >> "$temp_file"
		echo "ユーザー名：$username" >> "$temp_file"
		echo "パスワード：$password" >> "$temp_file"

		# ファイルをGnuPGを使用して暗号化
		gpg --encrypt --recipient "$gpg_key" "$temp_file"
		echo "パスワードの追加は成功しました。"

		rm "$temp_file"

	# Get Password が入力された場合
	elif [ "$choice" == "Get Password" ]; then
		echo "サービス名を入力してください："
		read service_name

                temp_file="${service_name}.txt.gpg"

		# 暗号化されたファイルを復号化して表示
		gpg --decrypt "${temp_file}" > "decryped_passwords.txt" 2>/dev/null
		if [ $? -eq 0 ]; then
			# サービス名に一致する情報を抽出
			grep -A2 "サービス名：$service_name" "decryped_passwords.txt"
			rm "decryped_passwords.txt"
		else
			echo "そのサービスは登録されていません。"
		fi

	# Exit が入力された場合
	elif [ "$choice" == "Exit" ]; then
		echo "Thank you!"
		break

	# Add Password/Get Password/Exit 以外が入力された場合
	else
		echo "入力が間違えています。Add Password/Get Password/Exit から入力してください。"
	fi
done  

