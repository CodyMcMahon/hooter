class SessionController < ApplicationController
  def new
    @session = Session.new
  end

  def create
    @user = User.find_by_name(params[:session][:name])
    if @user and @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      session[:user_name] = @user.name
      redirect_to '/'
    else
      redirect_to '/login/'
    end
  end

  def destroy
    session[:user_id] = nil
    session[:user_name] = nil
    redirect_to '/'
  end
end
