class Message < ApplicationRecord
  mount_uploader :image, ImageUploader
  
  validates :text, presence: true, unless: :image?

  belongs_to :user
  belongs_to :group

end
