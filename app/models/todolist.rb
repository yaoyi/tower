class Todolist
	include Mongoid::Document
	include Mongoid::Timestamps
	field :title, type: String
	has_many :todos
	belongs_to :project
	delegate :team, to: :project

	after_create :record_event
	after_destroy :record_event

	protected
	def record_event
		event = Event.new
		binding.pry
		event.eventable = self

	end
end