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
end