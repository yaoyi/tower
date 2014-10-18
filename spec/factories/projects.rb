FactoryGirl.define do
	factory :project do
		name { Faker::Lorem.word }
		team
		user
	end
end