class LikesController < ApplicationController
    def new
        @new_like = Like.new
    end
    
    def create
        @new_like = Like.new
        @new_like.from_id = current_user.id
        @new_like.to_id = params[:to_id]
        @new_like.post_id = params[:post_id]
        @new_like.save
        redirect_to(:back)
    end
    
   
end