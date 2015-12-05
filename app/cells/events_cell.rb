# coding: utf-8
class EventsCell < Cell::Rails
  helper :application
  def index(args)
    events = args[:events]
  	@events = events.chunk{|e| e.created_at.to_date}
    render unless events.empty?
  end

  def show(args)
    @event = args[:event]
    @template = @event.eventable_type.downcase + '_' + @event.action.to_s
    render
  end

  def events_day(args)
    events = args[:events]
    @date = events.first.created_at.to_date
  	@events = events.chunk {|e| e.project }
    render
  end

  def events_project_with_header(args)
    @events = args[:events]
    @project = @events.first.project
    render
  end

  def events_project(args)
    @events = args[:events]
    render
  end

  def project_create(args)
  	@event = args[:event]
   	@action = 'create project'
    @content_path = polymorphic_path(@event.eventable)
    render
  end

  def project_delete(args)
  	@event = args[:event]
   	@action = 'delete project'
    @content_path = polymorphic_path(@event.eventable)
    render
  end

  def project_restore(args)
  	@event = args[:event]
   	@action = 'restore project'
    @content_path = polymorphic_path(@event.eventable)
    render
  end
  def todolist_create(args)
   	@event = args[:event]
   	@action = 'create task list'
    render
  end
  def todolist_delete(args)
   	@event = args[:event]
   	@action = 'delete task list'
    render
  end
  def todolist_restore(args)
   	@event = args[:event]
   	@action = 'restore task list'
    render
  end
  def todo_create(args)
   	@event = args[:event]
   	@action = 'create task'
    render
  end
  def todo_delete(args)
   	@event = args[:event]
   	@action = 'delete task'
    render
  end
  def todo_restore(args)
   	@event = args[:event]
   	@action = 'restore task'
    render
  end
  def todo_complete(args)
   	@event = args[:event]
   	@action = 'complete task'
    render
  end
  def todo_resume(args)
   	@event = args[:event]
   	@action = 'reopen task'
    render
  end
  def todo_assign(args)
    @event = args[:event]
    @action = "assign task to #{@event.eventable.assignee.nickname}"
    render
  end
  def todo_schedule(args)
   	@event = args[:event]
    if @event.extra[:old_date].nil?
      old_date = "no deadline"
    else
      old_date = @event.extra[:old_date].strftime("%m-%d")
    end
    new_date = @event.extra[:new_date].strftime("%m-%d")
   	@action = "change the deadline from #{old_date} to #{new_date}"
    render
  end

  def comment_create(args)
   	@event = args[:event]
   	@action = "comment task"
   	@body = @event.eventable.content
    @content_path = polymorphic_path([@event.project, @event.eventable.commentable])
    render
  end
  def comment_delete(args)
   	@event = args[:event]
   	@action = "delete the comment"
   	@body = @event.eventable.content
    @content_path = polymorphic_path([@event.project, @event.eventable.commentable])
    render
  end
end
