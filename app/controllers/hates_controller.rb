class HatesController < ApplicationController
    def new
        @new_hate = Hate.new
    end
    
    def create
        if user_signed_in?
            @new_hate = Hate.new
            @new_hate.from_id = current_user_id
            @new_hate.to_id = params[:to_id]
            @new_hate.post_id = params[:post_id]
            @new_hate.save
            redirect_to(:back)
        else
            redirect_to('/login')
        end
    end
    
   
end