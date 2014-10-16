class CommentsController < ApplicationController
	before_action :authenticate_user!
	def index
		
	end
	def create
	    @comment = Comment.new(comment_params)
	    @comment.user = current_user
	    @comment.commentable.comments << @comment
	    @comment.save
	    redirect_to :back
  	end

  	def destroy
  		@comment = Comment.find(params[:id])
  		@comment.delete!
  		redirect_to :back
  	end

  	protected
	  def comment_params
	    params.require(:comment).permit(:commentable_type, :commentable_id, :content)
	  end
end