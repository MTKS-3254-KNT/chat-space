class Group < ApplicationRecord
  has_many :group_users
  has_many :messages
  has_many :users, through: :group_users
  validates :name, presence: true, uniqueness: true

  def show_last_message
    if (last_message = messages.last).present? #変数に最後のメッセージを代入し、レシーバーの値が存在すればtrueを返す
      if last_message.text? #代入されているものがtextならtrue
        last_message.text #最後に投稿されたメッセージを返す
      else
        '画像が投稿されています' #メッセージでは無い場合に返す
      end
    else
      'まだメッセージはありません。' #何も投稿が無い場合に返す
    end
  end


end