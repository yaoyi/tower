class UsersController < ApplicationController
	before_action :authenticate_user!
	include TeamConcern
	def index
		unless params[:team_id].blank?
			@users = current_team.users
			render 'team'
		end
		unless params[:project_id].blank?
			@project = current_user.projects.find(params[:project_id])
			@users = @project.users
			render 'project'
		end
	end
	def show
	end
end