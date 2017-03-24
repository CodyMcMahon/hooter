class SubhootsController < ApplicationController
    require 'subhoot_data_class.rb'
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
    
    def get_subhoots
        masterarr = Array.new
        for sh in Subhoot.all.where("post_id = ?", params[:id])
            next if sh == nil
            u = User.find(sh.user_id)
            masterarr.push(Subhoot_data.new u.name, u.profile_image, '/'+URI.encode(u.name), u.id, sh.content )
        end
        render json: masterarr
    end
end
