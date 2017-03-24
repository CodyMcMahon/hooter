# username,avatar,post_id,time,content,subhoot_count,like_count,hate_count
class Hoot_data
    attr_accessor :user_id, :username, :avatar, :post_id, :time, :content, :subhoot_count,:like_count,:hate_count
    def initialize user_id, username, avatar, post_id, time, content, subhoot_count,like_count,hate_count
      @user_id = user_id
      @username = username
      @avatar = avatar
      @post_id = post_id
      @time = time
      @content = content
      @subhoot_count = subhoot_count
      @like_count = like_count
      @hate_count = hate_count
    end
end