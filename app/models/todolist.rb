class Todolist
	include Mongoid::Document
	include Mongoid::Timestamps
	field :name, type: String
	field :deleted_at, type: DateTime
	has_many :todos
	belongs_to :user
	belongs_to :project
	delegate :team, to: :project

	after_create :event_add
	after_destroy :event_del


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
end