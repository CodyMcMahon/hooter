class PagesController < ApplicationController
  def index
  end
  
  def help
  end
  
  def following_self
    @following 
  end
  
  def following
    @following 
  end
  
  def followers_self
    @followers
  end
  
  def followers
    @followers
  end
  
  def one_hoot
    @newPost = Post.new
  end
  
  def hoots
    @posts = Post.all.where("content = ?",'hoot')
  end

  def home
    if user_signed_in?
      @this_user = User.find_by_username(current_user.username)
      @username = current_user.username
      @newPost = Post.new
      @posts = Post.all
    end
  end

  def profile
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
    @posts = Post.all
  end
end
