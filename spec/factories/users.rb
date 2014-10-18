FactoryGirl.define do
    factory :user do
        nickname Faker::Name.name
        sequence(:email){|n| "email#{n}@example.com"}
        password Faker::Internet.password
        factory :user_with_teams do
          ignore do
            teams_count 5
          end
          after(:create) do |user, evaluator|
            create_list(:team, evaluator.teams_count, users: [user])
          end
        end
        factory :user_with_projects do
          ignore do
            projects_count 5
          end
          after(:create) do |user, evaluator|
            create_list(:project, evaluator.projects_count, user: user)
          end
        end
    end
end