module Eventable
	extend ActiveSupport::Concern
	included do
		attr_accessor :action
		attr_accessor :actor
		attr_accessor :extra
		has_many :events, as: :eventable
		after_create  :record
		after_destroy :record
	end
	def identify(actor)
		self.actor = actor
	end
	def trigger(action, actor=nil, extra={})
		identify(actor) unless actor.nil?
		self.action = action
		self.extra = extra
		record
	end

	private
	def record
		return unless action and actor
		binding.pry
		Event.create!(
			team: team,
			project: project,
			action: action, 
			actor: actor,
			extra: extra,
			eventable: self
		)
	end
end