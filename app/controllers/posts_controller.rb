class PostsController < ApplicationController
    require 'hoot_data_class.rb'
    require 'meme_data_class.rb'
    def new
        @post = Post.new
    end 
    
    def create
        @post = Post.new(post_params)
        @post.user_id = session[:user_id]
        respond_to do |f|
            if(@post.save)
                f.html { redirect_to "", notice: ""}
            else
                f.html { redirect_to "", notice: ""}
            end
        end    
    end
    
    def timeline
        masterarr = Array.new
        if user_signed_in?
            @this_user = current_user
            @username = @this_user.name
            @newPost = Post.new
            arr = Array.new
            for @a in @this_user.following
                arr.push(@a.id)
            end
            arr.push(@this_user.id)
            @posts = Post.where("user_id IN (?)", arr)
            @posts.each do |p|
                masterarr.push (mk_hoot_data p) if p
            end
        end
        render json: masterarr
    end
    
    def explore
        masterarr = Array.new
        Post.all.each do |p|
            masterarr.push (mk_hoot_data p) if p
        end
        render json: masterarr
    end
    
    def hoots_for
        masterarr = Array.new
        u = User.find_by_name(params[:id])
        if u
            Post.where(user_id: u.id).each do |p|
                masterarr.push (mk_hoot_data p) if p
            end
        end
        render json: masterarr
    end
    
    def hoot_hoots
        masterarr = Array.new
        Post.all.where(content: 'hoot').each do |p|
            masterarr.push (mk_hoot_data p)
        end
        render json: masterarr
    end
    
    def memes
        masterarr = Array.new
        10.times do
            offset = rand(Post.count)
            @m = Post.offset(offset).first
            masterarr.push(Meme_data.new @m.content)
        end
        render json: masterarr
    end
    
    def hoots_through_regex
        masterarr = Array.new
        if params[:search]
          search = Regexp.new params[:search]
          for @p in Post.all
            masterarr.push(mk_hoot_data @p) if @p.content[search]
          end
        end
        render json: masterarr
    end
    
    private
    def post_params
        params.require(:post).permit(:User_id, :content)
    end
    def mk_hoot_data p
        u = User.find(p.user_id)
        h = Hoot_data.new(u.id, u.name, u.profile_image, p.id, p.created_at, p.content, p.subhoots.count,p.likes.count,p.hates.count)
    end
end
