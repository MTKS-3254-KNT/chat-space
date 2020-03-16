json.user_name @message.user.name #コントローラーからのインスタンス変数を変換
json.created_at @message.created_at.strftime("%Y年%m月%d日 %H時%M分") #コントローラーからのインスタンス変数を変換
json.text @message.text #コントローラーからのインスタンス変数を変換
json.image @message.image_url #コントローラーからのインスタンス変数を変換