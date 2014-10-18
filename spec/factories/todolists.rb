FactoryGirl.define do
	factory :todolist do
		name { Faker::Lorem.word }
		project
		user
		factory :todolist_with_todos do
      ignore do
        todos_count 5
      end
      after(:create) do |todolist, evaluator|
        create_list(:todo, evaluator.todos_count, todolist: todolist)
      end
    end
	end
end