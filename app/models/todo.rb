class Todo
	include Mongoid::Document
	include Mongoid::Timestamps
	include Eventable
	field :content, type: String
	field :done, type: Boolean, default: false
	field :due_at_old, type: DateTime
	field :due_at, type: DateTime
	field :deleted_at, type: DateTime

	belongs_to :assignee, class_name:'User'
	belongs_to :user
	belongs_to :todolist

	delegate :team, :project, to: :todolist
	
	has_many :comments, as: :commentable

	after_save :check_attr

	def check_attr
		trigger(:schedule, actor, {:old_date => due_at_was, :new_date => due_at}) if due_at_changed?
		trigger(:assign) if assignee_id_changed?
	end

	def complete
		self.done = true
		self.save
		trigger(:complete)
	end

	def resume
		self.done = false
		self.save
		trigger(:resume)
	end

	def deleted?
		!self.deleted_at.nil?
	end

	def soft_delete
		self.deleted_at = Time.now
		self.save
		trigger(:delete)
	end

	def restore
		self.deleted_at = nil
		self.save
		trigger(:restore)
	end
end