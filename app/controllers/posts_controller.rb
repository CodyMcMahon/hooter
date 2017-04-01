class PostsController < ApplicationController
    require 'hoot_data_class.rb'
    require 'meme_data_class.rb'
    def new
        @post = Post.new
    end 
    
    def create
        #dont use
    end
    
    def hoot
        @post = Post.new
        if user_signed_in?
            if params[:content].length > 140
                render plain: "you're hoot is too long"
            else
                @post.content = params[:content].gsub('&lt;','ⲵ').gsub('&gt;','⳾').gsub('<','ⲵ').gsub('>','⳾')
                @post.user_id = current_user_id
                if(@post.save)
                    render plain: "success"
                else
                    render plain: "you left it blank idiot"
                end
            end
        else
            render plain: 'sign in to hoot'
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
    
    def timeline_update
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
            @posts = Post.where("id > ?", params[:id]).where("user_id IN (?)", arr)
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
    
    def explore_update
        masterarr = Array.new
        Post.where("id > ?", params[:id]).each do |p|
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
    
    def hoot_hoots_update
        masterarr = Array.new
        Post.where("id > ?", params[:id]).where(content: 'hoot').each do |p|
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
    
    def single_json
        masterarr = Array.new
        masterarr.push(mk_hoot_data Post.find(params[:id]))
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
    
    #use weird symbols to stop strange XSS problem involved with caching that occurs on heroku
    private
    def mk_hoot_data p
        u = User.find(p.user_id)
        h = Hoot_data.new(u.id, u.name, u.profile_image, p.id, p.created_at, p.content.gsub('<','ⲵ').gsub('>','⳾'), p.subhoots.count,p.likes.count,p.hates.count)
    end
end
