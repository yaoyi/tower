class ProjectsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_project, except: [:index, :create, :new]
	layout 'team'

	def index
		@team = current_user.teams.find(params[:team_id])
		@projects = @team.projects
	end
	def create
		@team = current_user.teams.find(params[:team_id])
		@project = @team.projects.new(project_params)
		@project.user = current_user
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

	end

	def invite
		redirect_to :back if params[:user_ids].blank?
		@project = current_user.projects.find(params[:id])
		params['user_ids'].each do |id|
			@project.member_ids << id unless @project.member_ids.include?(id)
		end
		@project.save
		redirect_to :back
	end

	protected
	def set_project
		@project = Project.find(params[:id])
		@project.identify(current_user.id)
	end
	def project_params
		params.require(:project).permit!
	end
end
	