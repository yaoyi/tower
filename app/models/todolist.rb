class Todolist
	include Mongoid::Document
	include Mongoid::Timestamps
	include Eventable
	include SoftDelete
	field :name, type: String
	
	has_many :todos
	belongs_to :user
	belongs_to :project

	delegate :team, to: :project
	alias_attribute :content, :name

	def restore
		super
		trigger(:restore)
	end
end