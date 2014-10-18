class Project
	include Mongoid::Document
	include Mongoid::Timestamps
	include Eventable
	include SoftDelete
	field :name, type: String
	field :desc, type: String
	field :creator_id, type: String

	alias_attribute :content, :name
	
	belongs_to :team
	
	has_and_belongs_to_many :users
	has_many :todolists	

	def project
		self
	end

	def invite(user_ids)
		user_ids.each do |id|
			self.user_ids << id unless self.user_ids.include?(BSON::ObjectId.from_string(id))
		end
		self.save
	end
end