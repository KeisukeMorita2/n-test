class Question < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 255 }, uniqueness: true
  validates :content, presence: true, length: { maximum: 255 }
  validates :answer, presence: true, length: { maximum: 255 }

end
