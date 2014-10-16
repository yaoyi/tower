class ProjectsController < ApplicationController
	before_action :authenticate_user!
	layout 'team'
	def index
		@team = current_user.teams.find(params[:team_id])
		@projects = @team.projects
	end
	def create
		@team = current_user.teams.find(params[:team_id])
		@project = @team.projects.new(project_params)
		@project.owner = current_user
		@project.member_ids << current_user.id
		@project.save

		redirect_to team_projects_path(@team)
	end
	def new
		@team = current_user.teams.find(params[:team_id])
		@project = @team.projects.build
	end
	def update
	end
	def edit
	end
	def show
		@project = current_user.projects.find(params[:id])
	end

	protected
	def project_params
		params.require(:project).permit!
	end
end
	