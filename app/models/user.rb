class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true
  
  has_many :messages
  has_many :group_users
  has_many :groups, through: :group_users

  def self.search(input, id)
    # クラスメソッドの定義、引数は検索ワードと自身のID
    return nil if input == ""
    # ワードがなければnilを返す、キーワドが空白で無い場合は⬇へ
    User.where(['name LIKE ?', "%#{input}%"] ).where.not(id: id).limit(10)
    # キーワードを元にユーザーを曖昧検索、自身のIDは除外、検索するのは10件だけ
  end
  # 検索したワードを含むレコード、もしくはnilを返す
end
