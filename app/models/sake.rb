class Sake < ApplicationRecord
  
  validates :identify_code, presence: true, length: { maximum: 255 }
  validates :name, presence: true, length: { maximum: 255 }
  validates :furigana, presence: true, length: { maximum: 255 }
  
  has_many :ownerships
  has_many :users, through: :ownerships
  has_many :wants
  has_many :want_users, through: :wants, source: :user
end

