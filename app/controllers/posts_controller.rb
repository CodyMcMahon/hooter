class PostsController < ApplicationController
    
    def new
        @post = Post.new
    end 
    
    def create
        @post = Post.new(post_params)
        @post.user_id = session[:user_id]
        respond_to do |f|
            if(@post.save)
                f.html { redirect_to "", notice: ""}
            else
                f.html { redirect_to "", notice: ""}
            end
        end    
    end
    
    private
    def post_params
        params.require(:post).permit(:User_id, :content)
    end
end
