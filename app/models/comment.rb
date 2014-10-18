class Comment
	include Mongoid::Document
	include Mongoid::Timestamps
	include Eventable
	include SoftDelete
	field :content, type: String

	belongs_to :commentable, polymorphic: true
	belongs_to :user
	delegate :team, to: :commentable
	delegate :project, to: :commentable

	def event_content
		commentable.content || commentable.name
	end
end
