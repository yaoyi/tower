class TeamsController < ApplicationController
	before_action :authenticate_user!
	layout 'team'
	def index
		redirect_to root_path
	end
	def create
		@team = current_user.teams.build(team_params)
    	@team.save
    	redirect_to root_path
	end
	def show
		current_team = params[:id]
		redirect_to team_projects_path(params[:id])
	end
	def invite
		redirect_to :back if params[:user_ids].blank?
		@team = current_user.teams.find(params[:id])
		@team.invite(params['user_ids'])
		redirect_to :back
	end
	
	protected
	def team_params
		params.require(:team).permit!
	end
end