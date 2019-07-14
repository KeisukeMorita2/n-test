class Question < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 255 }
  validates :content, presence: true, length: { maximum: 255 }
  validates :answer, presence: true, length: { maximum: 255 }

end
