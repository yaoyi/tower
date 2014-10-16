class Topic
	include Mongoid::Document
	include Mongoid::Timestamps
	field :title, type: String
	has_many :comments, as: :commentable
end