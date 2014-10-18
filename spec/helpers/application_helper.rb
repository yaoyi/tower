require "rails_helper"

RSpec.describe ApplicationHelper do
    let(:team) { create(:team) }
    describe "#current_team" do
        it "should return current team" do
            session[:team_id] = team.id
            expect(helper.current_team).to eq(team) 
        end
    end
end