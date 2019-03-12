class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: {maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user
  has_many :ownerships
  has_many :sakes, through: :ownerships
  has_many :wants
  has_many :want_sakes, through: :wants, source: :sake

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
  relationship = self.relationships.find_by(follow_id: other_user.id)
  relationship.destroy if relationship
  end

  def following?(other_user)
  self.followings.include?(other_user)
  end
  
  def want(sake)
    self.wants.find_or_create_by(sake_id: sake.id)
  end
  
  def unwant(sake)
    want = self.wants.find_by(sake_id: sake.id)
    want.destroy if want
  end
  
  def want?(sake)
    self.want_sakes.include?(sake)
  end
end