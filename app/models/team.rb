class Team
	include Mongoid::Document
	include Mongoid::Timestamps
	field :name, type: String
	
	has_many :events
	has_many :projects
	has_and_belongs_to_many :users

	def invite(user_ids)
		user_ids.each do |id|
			self.user_ids << id unless self.user_ids.include?(BSON::ObjectId.from_string(id))
		end
		self.save
	end
end