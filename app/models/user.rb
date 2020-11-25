class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :photo

  validates :username, , uniqueness: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def friends
   Friendship.where("user_id = ? or friend_id = ?", self.id, self.id)
   # friends_array = friendships.map{|friendship| friendship.friend if friendship.confirmed}
   # friends_array + inverse_friendships.map{|friendship| friendship.user if friendship.confirmed}
   # friends_array.compact
  end

  def not_friends_of_user
    friends_ids = (self.friends.map(&:user_id) + self.friends.map(&:friend_id)).uniq
    User.all.select { |user| !friends_ids.include?(user.id) }
  end

  # Users who have yet to confirme friend requests
   def pending_friends
     friendships.map{|friendship| friendship.friend if !friendship.confirmed}.compact
   end

   # Users who have requested to be friends
   def friend_requests
     inverse_friendships.map{|friendship| friendship.user if !friendship.confirmed}.compact
   end

   def confirm_friend(user)
     friendship = inverse_friendships.find{|friendship| friendship.user == user}
     friendship.confirmed = true
     friendship.save
   end

   def friend?(user)
     friends.include?(user)
   end

end
