class ProjectsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_project, except: [:index, :create, :new]
	include TeamConcern

	def index
		@projects = current_team.projects
	end
	def create
		@project = current_team.projects.new(project_params)
		@project.creator_id = current_user.id
		@project.user_ids << current_user.id
		@project.save

		redirect_to team_projects_path(current_team)
	end
	def new
		@project = current_team.projects.build
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
		@project.invite(params[:user_ids])
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
	