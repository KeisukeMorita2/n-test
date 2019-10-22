class Question < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 255 }, uniqueness: true
  validates :content, presence: true, length: { maximum: 255 }
  validates :answer, presence: true, length: { maximum: 255 }

  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites
  
  def self.ransackable_attributes(auth_object = nil)
    %w[title content answer]
  end
  
  def self.ransackable_associations(auth_object = nil)
    []
  end
end
