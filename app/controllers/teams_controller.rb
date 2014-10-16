class TeamsController < ApplicationController
	before_action :authenticate_user!
	layout 'team'
	def index

	end
	def create
		@team = current_user.teams.build(team_params)
    	@team.save
    	redirect_to root_path
	end
	def new
		@tema = Team.new
	end
	def update
	end
	def edit
	end

	def show
		session[:team_id] = params[:id]
		redirect_to team_projects_path(params[:id])
	end
	
	protected
	def team_params
		params.require(:team).permit!
	end
end