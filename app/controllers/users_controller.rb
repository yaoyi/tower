class UsersController < ApplicationController
	before_action :authenticate_user!
	layout "team"
	def index
		@team = current_user.teams.find(params[:team_id])
		@users = @team.users
	end
	def show
	end
	def invite
		redirect_to :back if params[:user_ids].blank?
		@team = current_user.teams.find(params[:team_id])
		params['user_ids'].each do |id|
			@team.user_ids << id unless @team.user_ids.include?(id)
		end
		@team.save
		redirect_to :back
	end
end