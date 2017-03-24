class LikesController < ApplicationController
    def new
        @new_like = Like.new
    end
    
    def create
        if user_signed_in?
            @new_like = Like.new
            @new_like.from_id = current_user_id
            @new_like.to_id = params[:to_id]
            @new_like.post_id = params[:post_id]
            @new_like.save
            #redirect_to('/single_hoot/' + params[:post_id])
            render plain: "success"
        else
            render plain: "failure"
            #redirect_to('/login')
        end
        
        #works better with no redirect
    end
    
   
end