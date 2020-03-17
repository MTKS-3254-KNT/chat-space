json.array! @messages do |message|# 複数投稿されている可能性を考慮し、配列形式でarray!メソッドを使用

  json.id         message.id
  json.user_name  message.user.name
  json.text       message.text
  json.image      message.image.url
  json.created_at message.created_at.strftime("%Y年%m月%d日 %H時%M分")

end