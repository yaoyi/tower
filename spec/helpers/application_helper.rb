require "rails_helper"

RSpec.describe ApplicationHelper do
    let(:team) { create(:team) }
    describe "#current_team" do
        it "should set and return current team" do
            helper.current_team = team
            expect(helper.current_team).to eq(team) 
        end
    end
end