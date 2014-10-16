class TodosController < ApplicationController
	before_action :authenticate_user!
	layout 'team'
	def index
		
	end
	def create
		@project = current_user.projects.find(params[:project_id])
		@todolist = @project.todolists.find(params[:todolist_id])
		todo = @todolist.todos.new(todo_params)
		todo.user = current_user
		todo.save
		redirect_to project_path(@project)
	end
	def new

	end
	def update
		@todo = Todo.find(params[:id])
		@todo.update_attributes(todo_params)
		@todo.save
		redirect_to project_todo_path(params[:project_id], @todo)
	end
	def edit
		@project = current_user.projects.find(params[:project_id])
		@todo = Todo.find(params[:id])
	end
	def show
		@project = current_user.projects.find(params[:project_id])
		@todo = Todo.find(params[:id])
	end

	def destroy
		todo = Todo.find(params[:id])
		todo.delete!
		redirect_to :back
	end

	def restore
		todo = Todo.find(params[:id])
		todo.restore!
		redirect_to :back
	end

	def done
		@todo = Todo.find(params[:id])
		params[:done] == "false" ? @todo.done! : @todo.undo!
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
	def todo_params
		params.require(:todo).permit!
	end
end