class UsersController < ApplicationController
	before_action :authenticate_user!
	layout "team"
	def index
		unless params[:team_id].blank?
			@team = current_user.teams.find(params[:team_id])
			@users = @team.members
			render 'team'
		end
		unless params[:project_id].blank?
			@project = current_user.projects.find(params[:project_id])
			@users = @project.members
			render 'project'
		end
	end
	def show
	end
end