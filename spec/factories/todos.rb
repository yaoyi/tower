FactoryGirl.define do
	factory :todo do
		content { Faker::Lorem.sentence }
		todolist
    user
	end
end