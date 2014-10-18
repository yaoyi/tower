class TodolistsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_todolist, except: [:index, :create]
	include TeamConcern

	def index

	end

	def create
		@project = current_user.projects.find(params[:project_id])
		todolist = @project.todolists.new(todolist_params)
		todolist.user = current_user
		todolist.save
		redirect_to project_path(@project)
	end

	def show

	end

	def destroy
		@todolist.soft_delete
		redirect_to :back
	end

	def restore
		todolist.restore
		redirect_to :back
	end

	protected
	def set_todolist
		@todolist = Todolist.find(params[:id])
		@todolist.identify(current_user.id)
	end
	def todolist_params
		params.require(:todolist).permit!
	end
end