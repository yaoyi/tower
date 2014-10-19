class EventsController < ApplicationController
	before_action :authenticate_user!
	include TeamConcern
	def index
		@events = current_team.events.page(params[:_p])
		unless @events.empty?
			events = @events.to_a
			query = {
		      _p:  params[:_p].blank? ? 2 : params[:_p].to_i + 1,
		      _pj: events.last.project.id.to_s,
		      _d:  events.last.created_at.to_date.to_s
	    	}.to_query
	    end
	    @next_page_path = team_events_path(current_team) + ".js?" + (query || '')
	end
end