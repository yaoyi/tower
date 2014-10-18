require 'rails_helper'

RSpec.describe Team, :type => :model do
	let(:team) { create(:team) }
	let(:user) { create(:user) }
	describe "invite" do
		it "should add user to the team" do
			expect{
				team.invite([user.id])
			}.to change(team.user_ids, :count).by(1)
		end
		it "should add user to the team" do
			expect{
				team.invite([user.id.to_s])
			}.to change(team.user_ids, :count).by(1)
		end
	end
end