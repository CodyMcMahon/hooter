class PagesController < ApplicationController
  def index
    
  end
  
  def kill_my_account
    
  end
  
  def login
    
  end
  
  def search
    @search = Regexp.new params[:regex]
    @owls = Array.new
    for @u in User.all
      @owls.push(@u) if @u.name[@search]
    end
    @posts = Array.new
    for @p in Post.all
      @posts.push(@p) if @p.content[@search]
    end
  end
  
  def searchT
    if params[:search]
      @search = Regexp.new params[:search]
      @owls = Array.new
      for @u in User.all
        @owls.push(@u) if @u.name[@search]
      end
      @posts = Array.new
      for @p in Post.all
        @posts.push(@p) if @p.content[@search]
      end
    end
  end
  
  def signup
    @user = User.new
  end
  
  def help
  end
  
  def single_hoot
    @new_like = Like.new
    @new_hate = Hate.new
    @hoot = Post.find_by_id(params[:id])
    @subhoots = Subhoot.all.where("post_id = ?", params[:id])
  end
  
  def no_hoot
    
  end
  
  def following_self
    if user_signed_in?
      @owls = current_user.following
    end
  end
  
  def following
    @username = params[:id]
    test = User.find_by_name(params[:id])
    if test
      @owls = test.following
    end
  end
  
  def followers_self
    if user_signed_in?
      @owls = current_user.followers
    end
  end
  
  def followers
    @username = params[:id]
    test = User.find_by_name(params[:id])
    if test
      @owls = test.followers
    end
  end
  
  def one_hoot
    @newPost = Post.new
  end
  
  def hoots
    @new_like = Like.new
    @new_hate = Hate.new
    @posts = Post.all.where("content = ?",'hoot')
  end

  def home
    @new_like = Like.new
    @new_hate = Hate.new
    if user_signed_in?
      @this_user = current_user
      @username = session[:user_name]
      @newPost = Post.new
      arr = Array.new
      for @a in @this_user.following
        arr.push(@a.id)
      end
      arr.push(session[:user_id])
      @posts = Post.where("user_id IN (?)", arr)
    end
  end

  def profile
    @new_like = Like.new
    @new_hate = Hate.new
    if (User.find_by_name(params[:id]))
      @this_user = User.find_by_name(params[:id])
      @username = params[:id]
      @posts = Post.all.where("user_id = ?", User.find_by_name(params[:id]).id)
    else
      @username = params[:id]
      @posts = Post.all
    end
    
    
  end

  def explore
    @new_like = Like.new
    @new_hate = Hate.new
    @posts = Post.all
  end
end
