class Subhoot_data
    attr_accessor :subhoot_id,:username, :avatar, :user_link, :user_id, :content
    def initialize subhoot_id,username, avatar, user_link, user_id, content
        @subhoot_id = subhoot_id
        @user_id = user_id
        @username = username
        @user_link = user_link
        @avatar = avatar
        @content = content
    end
end