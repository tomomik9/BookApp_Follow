class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :omniauthable, 
         omniauth_providers: %i(github)

  has_many :active_friendships,  class_name:  "Friendship",foreign_key: "follower_id",dependent:   :destroy
  has_many :passive_friendships, class_name:  "Friendship",foreign_key: "followed_id",dependent:   :destroy
  has_many :following, through: :active_friendships,  source: :followed
  has_many :followers, through: :passive_friendships, source: :follower

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_friendships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end
  
  has_one_attached :image
  
  def self.create_unique_string
    SecureRandom.uuid
  end

  def self.find_for_github_oauth(auth, signed_in_resource=nil)
    user = User.find_by(provider: auth.provider, uid: auth.uid)

    unless user
      user = User.create(provider: auth.provider,
                      uid:      auth.uid,
                      username: auth.info.name,
                      avatar_url: auth.info.image,
                      email:    auth.info.email,
                      password: Devise.friendly_token[0, 20]
      )
    end
    user.skip_confirmation!
    user.save
    user
 end
end
