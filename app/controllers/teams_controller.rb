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
		@team = current_user.teams.find(params[:id])
	end

	def trigger_project_add
		team = Team.find(params[:id])
		project = Project.new
		project.title = SecureRandom.hex
		project.user = current_user
		project.team = team
		project.save
	end

	def trigger_project_del
		event = Event.new
		event.user = current_user
		event.team = 
	end

	def trigger_topic_add
		event = Event.new
		event.user = current_user
		event.team = 
	end

	def trigger_topic_del
		event = Event.new
		event.user = current_user
		event.team = 
	end

	def trigger_comment_add
		event = Event.new
		event.user = current_user
		event.team = 
	end
	def trigger_comment_del
		event = Event.new
		event.user = current_user
		event.team = 
	end
	def trigger_assign_add
		event = Event.new
		event.user = current_user
		event.team = 
	end

	def trigger_assign_edit
		event = Event.new
		event.user = current_user
		event.team = 
	end

	def trigger_assign_del
		event = Event.new
		event.user = current_user
		event.team = 
	end

	def trigger_time_edit
		event = Event.new
		event.user = current_user
		event.team = 
	end

	def trigger_todolist_add
		event = Event.new
		event.user = current_user
		event.team = 
	end

	def trigger_todolist_del
		event = Event.new
		event.user = current_user
		event.team = 
	end

	def trigger_todo_add
		event = Event.new
		event.user = current_user
		event.team = 
	end

	def trigger_todo_del
		event = Event.new
		event.user = current_user
		event.team = 
	end


	


	protected
	def team_params
		params.require(:team).permit!
	end
end