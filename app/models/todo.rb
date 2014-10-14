class Todo
	include Mongoid::Document
	include Mongoid::Timestamps
	field :title, type: String
	field :is_completed, type: Boolean
	field :deadline, type: DateTime

	has_many :comments, as: :commentable	
	has_one :assignee, :class => 'User'
	belongs_to :user
	belongs_to :todolist
	delegate :team, to: :todolist
	delegate :project, to: :todolist

	after_create :event_add
	after_destroy :event_del
	after_save :check_deadline

	def check_deadline
		event_todo_deadline if deadline.changed?
	end
	def assign(user)
		self.assignee = user
		self.save
		event_assign
	end

	def complete
		self.is_completed = true
		self.save
		event_todo_complete
	end

	protected
	def create_event(action)
		event = Event.new
		event.user = self.user
		event.team = self.team
		event.project = self.project
		event.eventable = self
		event.action = action
		event.save
		event
	end
	def event_add
		create_event('add')
	end
	def event_del
		create_event('del')
	end
	def event_complete
		create_event('complete')
	end
	def event_assign
		create_event('assign')
	end
	def event_deadline
		create_event('deadline')
	end
end