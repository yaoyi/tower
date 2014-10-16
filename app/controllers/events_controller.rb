class EventsController < ApplicationController
	before_action :authenticate_user!
	layout 'team'
	def index
		@team = current_user.teams.find(params[:team_id])
		@events = @team.events.page(params[:page])
		# @date_chunked_events = @events.chunk{|e| e.project}
		# @chunked_events = @events.chunk{|e| e.project}
		@chunked_events = @events.chunk{|e| e.created_at.to_date}
		@next_page = params[:page].to_i + 1 unless params[:page].blank?
		@last_project = params[:last_project] || @events.last.project.id.to_s
		@last_date = params[:last_date] || @events.last.created_at.to_date.to_s
	end
end