class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  field :content, type: Text

  belongs_to :commentable, :polymorphic => true
  belongs_to :user
  
  after_create :event_add
	after_destroy :event_del

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
end
