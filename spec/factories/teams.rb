FactoryGirl.define do
	factory :team do
		name { Faker::Lorem.word }
		factory :team_with_projects do
          ignore do
            projects_count 5
          end
          after(:create) do |team, evaluator|
            create_list(:project, evaluator.projects_count, team: team)
          end
        end
	end
end