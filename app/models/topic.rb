class Topic
	include Mongoid::Document
	include Mongoid::Timestamps
	include SoftDelete
	field :title, type: String
	has_many :comments, as: :commentable

end