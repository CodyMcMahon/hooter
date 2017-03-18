#validates :name, presence: true, length: { maximum: 20 }
#validates :password, presence: true, length: { minimum: 2 }
class UsersController < ApplicationController
    def new
        @user = User.new
    end
    def create
        @user = User.new user_params
        @user[:profile_image] = params[:user][:profile_image] if !params[:user][:profile_image].empty?
        
        if @user.name.size <= 20 and @user.password.size >= 2 and !@user.name[/[^0-9a-zA-Z_ ]/] and @user.save
            session[:user_id] = @user.id
            session[:user_name] = @user.name
            redirect_to '/'
        else
            redirect_to '/signup'
        end
    end
    
    def change_password
        @user = current_user
        if @user and params[:user][:new_password].size>=2 and @user.authenticate(params[:user][:password]) and !params[:user][:new_password].empty? and params[:user][:new_password] == params[:user][:new_password_confirm]
            @user[:password_digest] = salt_n_hash params[:user][:new_password]
            if @user.save
                redirect_to '/'
            else
                redirect_to '/edit_profile'
            end
        else
            redirect_to '/edit_profile'
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
        else
            redirect_to '/edit_profile'
        end
    end
    
    def delete
        if user_signed_in?
            User.find(current_user_id).destroy
            session[:user_id] = nil
            session[:user_name] = nil
        end
        redirect_to('/')
    end
    
    def ban_user
        if current_user.is_admin?
            User.find(params[:user_to_ban]).destroy
        end
        redirect_to('/')
    end
    
    private
    def user_params
        params.require(:user).permit(:name,:password,:password_confirmation)
    end
end
