module Eventable
	extend ActiveSupport::Concern
	included do
		attr_accessor :action
		attr_accessor :actor
		attr_accessor :extra
		has_many :events, as: :eventable
		after_create  :record_create
		after_destroy :record_delete
	end
	def identify(actor)
		self.actor = actor
	end
	def trigger(action, actor=nil, extra={})
		identify(actor) if actor
		self.action = action
		self.extra = extra
		record
	end
	def event_content
		self.content
	end

	private
	def reset
		self.action = nil
		self.actor = nil
	end

	def record_create
		trigger(:create)
	end

	def record_delete
		trigger(:delete)
	end

	def record
		return unless action and actor
		event = Event.create!(
			team: team,
			project: project,
			action: action, 
			actor: actor,
			content: event_content,
			extra: extra,
			eventable: self
		)
		reset
		event
	end
end