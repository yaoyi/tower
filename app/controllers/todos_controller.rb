class TodosController < ApplicationController
	before_action :authenticate_user!
	before_action :set_todo, except: [:index, :create]
	include TeamConcern

	def index
		
	end
	def create
		@project = current_user.projects.find(params[:project_id])
		todo = Todo.new(todo_params)
		todo.user = current_user
		todo.save
		redirect_to project_path(@project)
	end
	def new

	end
	def update
		@todo.update_attributes(todo_params)
		@todo.save
		redirect_to project_todo_path(params[:project_id], @todo)
	end
	def edit

	end
	def show
		@project = current_user.projects.find(params[:project_id])
	end

	def destroy
		@todo.trigger(:delete)
		@todo.destroy
		redirect_to :back
	end

	def restore
		@todo.restore
		redirect_to :back
	end

	def done
		params[:done] == "false" ? @todo.complete : @todo.resume
		respond_to do |format|
			format.html {
				redirect_to :back
			}
			format.json {
				render text: ''
			}
		end
		
	end
	protected
	def set_todo
		@todo = Todo.find(params[:id])
		@todo.identify(current_user.id)
	end
	def todo_params
		params.require(:todo).permit!
	end
end