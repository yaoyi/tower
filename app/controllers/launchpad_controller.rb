class LaunchpadController < ApplicationController
	before_action :authenticate_user!
	def index
		@teams = current_user.teams
	end		
end	