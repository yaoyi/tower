require 'rails_helper'

RSpec.describe Project, :type => :model do
	let(:project) { create(:project) }
	let(:user) { create(:user) }
	describe "invite" do
		it "should add user to the team" do
			expect{
				project.invite([user.id])
			}.to change(project.user_ids, :count).by(1)
		end
		it "should add user to the team" do
			expect{
				project.invite([user.id.to_s])
			}.to change(project.user_ids, :count).by(1)
		end
	end
end