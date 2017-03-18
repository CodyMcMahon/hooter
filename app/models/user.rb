class User < ActiveRecord::Base
         
         has_secure_password
         
         has_many :posts, dependent: :destroy
         has_many :subhoots, dependent: :destroy
         has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
         has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
         has_many :followers, through: :passive_relationships, source: :follower
         has_many :following, through: :active_relationships, source: :followed
         
         
          #validates :name, presence: true, length: { maximum: 20 }
          #validates :password, presence: true, length: { minimum: 2 }
         
         
          def follow(other)
            active_relationships.create(followed_id: other.id)
          end
          
          def unfollowed(other)
            active_relationships.find_by(followed_id: other.id).destroy
          end
          
          def following?(other)
            following.include?(other)
          end
          
          def is_admin?
            self.admin
          end
          # Returns the hash digest of the given string.
          def User.digest(string)
              cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
              BCrypt::Password.create(string, cost: cost)
          end
end
