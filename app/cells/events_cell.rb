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
   	@action = '创建了项目'
    @content_path = polymorphic_path(@event.eventable)
    render
  end

  def project_delete(args)
  	@event = args[:event]
   	@action = '删除了项目'
    @content_path = polymorphic_path(@event.eventable)
    render
  end

  def project_restore(args)
  	@event = args[:event]
   	@action = '恢复了项目'
    @content_path = polymorphic_path(@event.eventable)
    render
  end
  def todolist_create(args)
   	@event = args[:event]
   	@action = '创建了任务清单'
    render
  end
  def todolist_delete(args)
   	@event = args[:event]
   	@action = '删除了任务清单'
    render
  end
  def todolist_restore(args)
   	@event = args[:event]
   	@action = '恢复了任务清单'
    render
  end
  def todo_create(args)
   	@event = args[:event]
   	@action = '创建了任务'
    render
  end
  def todo_delete(args)
   	@event = args[:event]
   	@action = '删除了任务'
    render
  end
  def todo_restore(args)
   	@event = args[:event]
   	@action = '恢复了任务'
    render
  end
  def todo_complete(args)
   	@event = args[:event]
   	@action = '完成了任务'
    render
  end
  def todo_resume(args)
   	@event = args[:event]
   	@action = '重新打开了任务'
    render
  end
  def todo_assign(args)
    @event = args[:event]
    @action = "给 #{@event.eventable.assignee.nickname} 指派了任务"
    render
  end
  def todo_schedule(args)
   	@event = args[:event]
    if @event.extra[:old_date].nil? 
      old_date = "没有截止日期"
    else
      old_date = @event.extra[:old_date].strftime("%m月%d日")
    end
    new_date = @event.extra[:new_date].strftime("%m月%d日")
   	@action = "将任务完成时间从 #{old_date} 修改为 #{new_date}"
    render
  end
  
  def comment_create(args)
   	@event = args[:event]
   	@action = "回复了任务"
   	@body = @event.eventable.content
    @content_path = polymorphic_path([@event.project, @event.eventable.commentable])
    render
  end
  def comment_delete(args)
   	@event = args[:event]
   	@action = "删除了回复"
   	@body = @event.eventable.content
    @content_path = polymorphic_path([@event.project, @event.eventable.commentable])
    render
  end
end