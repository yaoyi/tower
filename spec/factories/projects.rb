FactoryGirl.define do
	factory :project do
		name { Faker::Lorem.word }
		team
		factory :project_with_members do
	      ignore do
	        members_count 5
	      end
	      after(:create) do |project, evaluator|
	        create_list(:user, evaluator.members_count, project: project)
	      end
    	end
	end
end