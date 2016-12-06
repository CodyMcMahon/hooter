class PagesController < ApplicationController
  def index
  end
  
  def kill_my_account
    
  end
  
  def help
  end
  
  def single_hoot
    @new_like = Like.new
    @new_hate = Hate.new
    @hoot = Post.find_by_id(params[:id])
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
    if (User.find_by_username(params[:id]))
      @owls = User.find_by_username(params[:id]).following
    end
  end
  
  def followers_self
    if user_signed_in?
      @owls = current_user.followers
    end
  end
  
  def followers
    @username = params[:id]
    if (User.find_by_username(params[:id]))
      @owls = User.find_by_username(params[:id]).followers
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
      @this_user = User.find_by_username(current_user.username)
      @username = current_user.username
      @newPost = Post.new
      arr = Array.new
      for @a in current_user.following
        arr.push(@a.id)
      end
      arr.push(current_user.id)
      @posts = Post.where("user_id IN (?)", arr)
    end
  end

  def profile
    @new_like = Like.new
    @new_hate = Hate.new
    if (User.find_by_username(params[:id]))
      @this_user = User.find_by_username(params[:id])
      @username = params[:id]
      @posts = Post.all.where("user_id = ?", User.find_by_username(params[:id]).id)
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
