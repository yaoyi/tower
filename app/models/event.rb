class Event
	ACTIONS = %w[add del complete assign modify_assign modify_time comment]
	include Mongoid::Document
	include Mongoid::Timestamps
	belongs_to :team
	has_one :actor, :class => 'User'
	belongs_to :project
	belongs_to :eventable, polymorphic: true
	field :action, type: String

	default_scope -> { order('created_at ASC') }
end