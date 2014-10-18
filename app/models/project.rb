class Project
	include Mongoid::Document
	include Mongoid::Timestamps
	include Eventable
	include SoftDelete
	field :name, type: String
	field :desc, type: String
	
	belongs_to :team
	belongs_to :user
	
	has_and_belongs_to_many :members, class_name: 'User'
	has_many :todolists	

	def project
		self
	end

	def invite(user_ids)
		user_ids.each do |id|
			self.member_ids << id unless self.member_ids.include?(BSON::ObjectId.from_string(id))
		end
		self.save
	end
end