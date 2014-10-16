class Todo
	include Mongoid::Document
	include Mongoid::Timestamps
	field :content, type: String
	field :done, type: Boolean, default: false
	field :due_at_old, type: DateTime
	field :due_at, type: DateTime
	field :deleted_at, type: DateTime

	belongs_to :assignee, class_name:'User'
	belongs_to :user
	belongs_to :todolist
	delegate :team, to: :todolist
	delegate :project, to: :todolist
	has_many :events, as: :eventable
	has_many :comments, as: :commentable

	after_create :event_add
	after_save :check_state

	def check_state
		event_due if due_at_changed?
		event_assign if assignee_id_changed?
	end
	def assign(user)
		self.assignee = user
		self.save
		event_assign
	end

	def done!
		self.done = true
		self.save
		event_done
	end

	def undo!
		self.done = false
		self.save
		event_undo
	end

	def deleted?
		!self.deleted_at.nil?
	end

	def delete!
		self.deleted_at = Time.now
		self.save
		event_del
	end

	def restore!
		self.deleted_at = nil
		self.save
		event_restore
	end

	protected
	def create_event(action)
		event = Event.new
		event.actor = self.user
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
	def event_restore
		create_event('restore')
	end
	def event_done
		create_event('done')
	end
	def event_undo
		create_event('undo')
	end
	def event_assign
		create_event('assign')
	end
	def event_due
		create_event('due')
	end
end