class Topic
	include Mongoid::Document
	include Mongoid::Timestamps
	include Eventable
	include Commentable
	include SoftDelete
	field :title, type: String
end