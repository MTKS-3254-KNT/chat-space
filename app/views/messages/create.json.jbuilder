json.id         @message.id
json.user_name  @message.user.name
json.text       @message.text
json.image      @message.image.url
# json.created_at @message.created_at.time_format("%Y/%m/%d %H:%M")
json.created_at @message.created_at.strftime("%Y/%m/%d %H:%M")# "%Y年%m月%d日 %H時%M分"


