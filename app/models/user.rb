class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :events
  has_many :active_notifications, class_name: "Notification", foreign_key: "visiter_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy
  attachment :profile_image

  def follow(user_id)
  relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
  relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
  followings.include?(user)
  end

  def self.looks(search, word)
    if search == "perfect_match"
    @user = User.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
    @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
    @user = User.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
    @user = User.where("name LIKE?","%#{word}%")
    else
    @user = User.all
    end
  end

  #フォロー時の通知
  def create_notification_follow!(current_user)
    temp = Notification.where(["visiter_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

  validates :name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true
end
