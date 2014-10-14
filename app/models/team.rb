class Team
	include Mongoid::Document
	include Mongoid::Timestamps
	field :name, type: String
	has_and_belongs_to_many :users
	has_many :events
	has_many :projects

	def remove_user(user)
		users.delete(user)
	end
	def add_user(user)
		users << user
	end
end