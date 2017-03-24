class Subhoot_data
    attr_accessor :username, :avatar, :user_link, :user_id, :content
    def initialize username, avatar, user_link, user_id, content
        @user_id = user_id
        @username = username
        @user_link = user_link
        @avatar = avatar
        @content = content
    end
end