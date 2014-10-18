FactoryGirl.define do
	factory :event do
    action :create
    team
    project
    association :actor, factory: :user
    association :eventable, factory: :project
    trait :project_create_event do
      association :eventable, factory: :project
      action :create
    end
    trait :project_delete_event do
      association :eventable, factory: :project
      action :delete
    end
    trait :project_restore_event do
      association :eventable, factory: :project
      action :restore
    end
    trait :todolist_create_event do
      association :eventable, factory: :todolist
      action :create
    end
    trait :todolist_delete_event do
      association :eventable, factory: :todolist
      action :delete
    end
    trait :todolist_restore_event do
      association :eventable, factory: :todolist
      action :delete
    end
    trait :todo_create_event do
      association :eventable, factory: :todo
      action :create
    end
    trait :todo_delete_event do
      association :eventable, factory: :todo
      action :delete
    end
    trait :todo_restore_event do
      association :eventable, factory: :todo
      action :restore
    end
    trait :todo_complete_event do
      association :eventable, factory: :todo
      action :complete
    end
    trait :todo_assign_event do
      association :eventable, factory: :todo
      action :assign
    end
    trait :todo_resume_event do
      association :eventable, factory: :todo
      action :resume
    end
    trait :todo_schedule_event do
      association :eventable, factory: :todo
      action :schedule
    end
  end
end