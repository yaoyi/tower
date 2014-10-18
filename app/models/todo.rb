class Todo
	include Mongoid::Document
	include Mongoid::Timestamps
	include Eventable
	include Commentable
	include SoftDelete
	field :content, type: String
	field :done, type: Boolean, default: false
	field :due_at_old, type: DateTime
	field :due_at, type: DateTime

	belongs_to :assignee, class_name:'User'
	belongs_to :user
	belongs_to :todolist

	delegate :team, :project, to: :todolist

	after_save :check_attr

	def check_attr
		trigger(:schedule, actor, {:old_date => due_at_was, :new_date => due_at}) if due_at_changed?
		trigger(:assign) if assignee_id_changed?
		trigger(:complete) if done_changed? and done
		trigger(:resume) if done_changed? and !done
	end

	def complete
		self.done = true
		self.save
	end

	def resume
		self.done = false
		self.save
	end
end