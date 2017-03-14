class UsersController < ApplicationController
    def new
        @user = User.new
    end
    def create
        @user = User.new user_params
        @user[:profile_image] = params[:user][:profile_image] if !params[:user][:profile_image].empty?
        if @user.save
            session[:user_id] = @user.id
            session[:user_name] = @user.name
            redirect_to '/'
        else
            redirect_to '/'
        end
    end
    
    def change_password
        @user = current_user
        if @user and @user.authenticate(params[:user][:password]) and !params[:user][:new_password].empty? and params[:user][:new_password] == params[:user][:new_password_confirm]
            @user[:password_digest] = salt_n_hash params[:user][:new_password]
            if @user.save
                redirect_to '/'
            else
                redirect_to '/edit_profile'
            end
        end
    end
    
    def change_avatar
        @user = current_user
        if @user and @user.authenticate(params[:user][:password]) and !params[:user][:avatar].empty?
            @user[:profile_image] = params[:user][:avatar]
            if @user.save
                redirect_to '/'
            else
                redirect_to '/edit_profile'
            end
        end
    end
    
    
    private
    def user_params
        params.require(:user).permit(:name,:password,:password_confirmation)
    end
end
