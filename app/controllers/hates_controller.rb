class HatesController < ApplicationController
    def new
        @new_hate = Hate.new
    end
    
    def create
        @new_hate = Hate.new
        @new_hate.from_id = current_user.id
        @new_hate.to_id = params[:to_id]
        @new_hate.post_id = params[:post_id]
        @new_hate.save
        redirect_to(:back)
    end
    
   
end