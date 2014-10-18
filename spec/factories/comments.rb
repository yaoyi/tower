FactoryGirl.define do
	factory :comment do
		content { Faker::Lorem.sentence }
    user
    association :commentable, factory: :todo
	end
end