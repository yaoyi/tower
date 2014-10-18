class EventsController < ApplicationController
	before_action :authenticate_user!
	include TeamConcern
	def index
		@events = current_team.events.page(params[:page])
		@next_page = params[:page].to_i + 1 unless params[:page].blank?
  		unless @events.empty?
  			@last_project = params[:last_project] || @events.last.project.id.to_s
  			@last_date = params[:last_date] || @events.last.created_at.to_date.to_s
  		end
	end
end