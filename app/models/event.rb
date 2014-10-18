class Event
	include Mongoid::Document
	include Mongoid::Timestamps
	include Mongoid::Enum
	enum :action, [:create, :delete, :restore, :complete, :resume, :assign, :schedule]
	field :extra, type: Hash

	belongs_to :team
	belongs_to :project
	belongs_to :actor, class_name: 'User'
	belongs_to :eventable, polymorphic: true

	paginates_per 10

	default_scope -> { order('created_at DESC') }
end