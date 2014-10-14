class Project
	include Mongoid::Document
	include Mongoid::Timestamps
	field :title, type: String
	belongs_to :team
	belongs_to :user
	has_many :events

	after_create :event_project_add
	after_destroy :event_project_del

	protected
	def event_project_add
		event = Event.new
		event.user = self.user
		event.team = self.team
		event.project = self
		event.eventable = self
		event.action = 'add'
	end
	def event_project_del
		event = Event.new
		event.user = self.user
		event.team = self.team
		event.project = self
		event.eventable = self
		event.action = 'del'
	end
end