class Project
	include Mongoid::Document
	include Mongoid::Timestamps
	include Eventable
	field :name, type: String
	field :desc, type: String
	
	belongs_to :team
	belongs_to :user
	
	has_and_belongs_to_many :members, class_name: 'User'
	has_many :todolists	

	def project
		self
	end
end