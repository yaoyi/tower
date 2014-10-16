class EventsController < ApplicationController
	before_action :authenticate_user!
	layout 'team'
	def index
		@team = current_user.teams.find(params[:team_id])
		@events = @team.events.page(params[:page])
		@chunked_events = @events.chunk{|e| e.project}
		@next_page = params[:page].to_i + 1 unless params[:page].blank?
		@last_project = params[:last_project] || @events.last.project.id.to_s
	end
end