class User_data
    attr_accessor :username, :avatar, :user_id, :link
    def initialize username, avatar, user_id, link
        @user_id = user_id
        @username = username
        @avatar = avatar
        @link = link
    end
end