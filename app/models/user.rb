class User < ApplicationRecord
  validates :name, presence: true, length:  { maximum: 50}
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length:{ maximum: 50},
                                    format:{ with: EMAIL_REGEX},
                                    uniqueness:{case_sensetive: false}
  has_secure_password
  validates :password, length: {minimum: 6}, allow_nil: true

  # Followed Users
  has_many :active_relationships, foreign_key: "follower_id",
                                  class_name: "relationship",
                                  dependent: :destroy
  
  # user.active_relationships.followed_id -> user.followed_users
  has_many :followed_users, through: :active_relationships, source: :followed

  # Followers
  has_many :passive_relationships, foreign_key: "followed_id",
                                   class_name: "Relationship",
                                   dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower                                


  # Returns true if the current user is following the other user
  def following?(other_user)
    active_relationships.find_by(followed_id: other_user.id)
  end

  # Follows a user
  def follow(other_user)
    active_relationships.create!(followed_id: other_user.id)
  end

  # Unfollows a user
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

end
