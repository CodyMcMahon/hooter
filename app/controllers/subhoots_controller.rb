class SubhootsController < ApplicationController
    def new
        @subhoot = Subhoot.new
    end
    def create
        if user_signed_in? and params[:post_id] and params[:content]
            @new_subhoot = Subhoot.new
            @new_subhoot.post_id = params[:post_id]
            @new_subhoot.content = params[:content]
            @new_subhoot.user_id = current_user_id
            @new_subhoot.save
        end
        redirect_to(:back)
    end
end
