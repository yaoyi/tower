class EventsController < ApplicationController
	before_action :authenticate_user!
	layout 'team'
	def index
		@team = current_user.teams.find(params[:team_id])
		@events = @team.events
	end
end