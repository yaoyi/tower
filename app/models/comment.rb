class Comment
	include Mongoid::Document
	include Mongoid::Timestamps
	field :content, type: String
	field :deleted_at, type: DateTime

	belongs_to :commentable, polymorphic: true
	belongs_to :user
	delegate :team, to: :commentable
	delegate :project, to: :commentable

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
end
