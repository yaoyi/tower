class CommentsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_comment, except: [:index, :create]

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
  		@comment.trigger(:delete)
  		@comment.destroy
  		redirect_to :back
  	end

  	protected
  	  def set_comment
		@comment = Comment.find(params[:id])
		@comment.identify(current_user.id)
	  end
	  def comment_params
	    params.require(:comment).permit!
	  end
end