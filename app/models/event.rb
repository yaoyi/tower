class Event
	ACTIONS = %w[add del done undo assign due comment]
	include Mongoid::Document
	include Mongoid::Timestamps
	belongs_to :team
	belongs_to :actor, class_name: 'User'
	belongs_to :project
	belongs_to :eventable, polymorphic: true
	field :action, type: String
	paginates_per 2

	default_scope -> { order('created_at DESC') }
end