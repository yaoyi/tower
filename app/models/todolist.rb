class Todolist
	include Mongoid::Document
	include Mongoid::Timestamps
	include Eventable
	field :name, type: String
	field :deleted_at, type: DateTime
	
	has_many :todos
	belongs_to :user
	belongs_to :project

	delegate :team, to: :project

	def deleted?
		!self.deleted_at.nil?
	end
	def soft_delete
		self.deleted_at = Time.now
		self.save
	end

	def restore
		self.deleted_at = nil
		self.save
	end
end