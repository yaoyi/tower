class Team
	include Mongoid::Document
	include Mongoid::Timestamps
	field :name, type: String
	has_and_belongs_to_many :users, class_name: 'User'
	has_many :events
	has_many :projects

	def invite(user_ids)
		user_ids.each do |id|
			self.user_ids << id unless self.user_ids.include?(BSON::ObjectId(id))
		end
		self.save
	end
end