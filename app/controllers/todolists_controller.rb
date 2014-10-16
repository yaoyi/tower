class TodolistsController < ApplicationController
	before_action :authenticate_user!
	layout 'team'
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
		@project = current_user.projects.find(params[:project_id])
		@todolist = Todolist.find(params[:id])
	end

	def destroy
		todolist = Todolist.find(params[:id])
		todolist.delete!
		redirect_to :back
	end

	def restore
		todolist = Todolist.find(params[:id])
		todolist.restore!
		redirect_to :back
	end

	protected
	def todolist_params
		params.require(:todolist).permit!
	end
end