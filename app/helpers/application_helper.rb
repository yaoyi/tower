module ApplicationHelper
	def current_team
		team_id = session[:team_id]
		@current_team ||= Team.find(team_id)
	end
end
