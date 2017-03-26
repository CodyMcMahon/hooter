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
            if @new_subhoot.save
                render plain: 'success'
            else
                if params[:content] > 1
                    render plain: 'subhoots can only be 50 characters buddy'
                else
                    render plain: "subhoots can't be blank"
                end
            end
        else
           
            render plain: 'machine broke'
            
            
        end
    end
    
    def get_subhoots
        masterarr = Array.new
        for sh in Subhoot.all.where("post_id = ?", params[:id])
            next if sh == nil
            u = User.find(sh.user_id)
            masterarr.push(Subhoot_data.new sh.id,u.name, u.profile_image, '/'+URI.encode(u.name), u.id, sh.content )
        end
        render json: masterarr
    end
    
    def get_subhoots_update
        masterarr = Array.new
        for sh in Subhoot.where("id > ?", params[:from_id]).where("post_id = ?", params[:id])
            next if sh == nil
            u = User.find(sh.user_id)
            masterarr.push(Subhoot_data.new sh.id,u.name, u.profile_image, '/'+URI.encode(u.name), u.id, sh.content )
        end
        render json: masterarr
    end
end
