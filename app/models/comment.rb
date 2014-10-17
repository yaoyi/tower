class Comment
	include Mongoid::Document
	include Mongoid::Timestamps
	include Eventable
	field :content, type: String
	field :deleted_at, type: DateTime

	belongs_to :commentable, polymorphic: true
	belongs_to :user
	delegate :team, to: :commentable
	delegate :project, to: :commentable

	def deleted?
		!self.deleted_at.nil?
	end
	def delete
		self.deleted_at = Time.now
		self.save
		trigger(:delete)
	end
end
