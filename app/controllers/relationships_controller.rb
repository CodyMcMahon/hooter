class RelationshipsController < ApplicationController
        def create 
            user = User.find(params[:followed_id])
            current_user.follow(user)
            redirect_to(:back)
        end         
        
        def destroy 
            user = Relationship.find(params[:id]).followed
            current_user.unfollowed(user)
            redirect_to(:back)
        end
        
        def followings_for
            masterarr = Array.new
            User.find_by_name(params[:id]).following.each do |u|
                masterarr.push(User_data.new u.name, u.profile_image, u.id,'/'+URI.encode(u.name)) if u
            end
            render json: masterarr
        end
          
        def followers_for
            masterarr = Array.new
            User.find_by_name(params[:id]).followers.each do |u|
                masterarr.push(User_data.new u.name, u.profile_image, u.id,'/'+URI.encode(u.name)) if u
            end
            render json: masterarr
        end
end