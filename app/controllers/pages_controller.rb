class PagesController < ApplicationController
  def index
    
  end
  
  def kill_my_account
    
  end
  
  def login
    
  end
  
  def search
    
  end
  
  def signup
    @user = User.new
  end
  
  def help
    
  end
  
  def single_hoot
    @hoot = Post.find_by_id(params[:id])
  end
  
  def no_hoot
    
  end
  
  def following
    @username = params[:id]
  end
  
  def followers
    @username = params[:id]
  end
  
  def hoots
    
  end

  def home
    @this_user = current_user
    @username = current_user_name
  end

  def profile
    @username = params[:id]
    @this_user = User.find_by_name(params[:id])
  end

  def explore
  end
end
