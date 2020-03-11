class Message < ApplicationRecord
  validates :text, presence: true, unless: :image?

  belongs_to :user
  belongs_to :group

  mount_uploader :image, ImageUploader
end
