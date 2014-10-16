class Project
	include Mongoid::Document
	include Mongoid::Timestamps
	field :name, type: String
	field :desc, type: String
	belongs_to :team
	belongs_to :owner, class_name: 'User'
	has_and_belongs_to_many :members, class_name: 'User'
	has_many :events
	has_many :todolists

	after_create :event_add
	after_destroy :event_del

	protected
	def create_event(action)
		event = Event.new
		event.actor = self.owner
		event.team = self.team
		event.project = self
		event.eventable = self
		event.action = action
		event.save
	end
	def event_add
		create_event('add')	
	end
	def event_del
		create_event('del')	
	end
end