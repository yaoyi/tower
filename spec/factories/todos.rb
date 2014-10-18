FactoryGirl.define do
	factory :todo do
		content { Faker::Lorem.sentence }
		todolist
    	user
    	factory :todo_with_comments do
	      ignore do
	        comments_count 5
	      end
	      after(:create) do |todo, evaluator|
	        create_list(:comment, evaluator.comments_count, commentable: todo)
	      end
	    end
	end
end