require 'rails_helper'

RSpec.describe TeamsController, :type => :controller do
	render_views
	let(:user) { create(:user_with_teams) }
	describe "GET index" do
		it "should redirect to sign in page if not signed in" do
			get :index 
			expect(response).to redirect_to(new_user_session_path)
		end
		it "should redirect to root path" do
			sign_in user
			get :index 
			expect(response).to redirect_to(root_path)
		end
	end
	describe "GET show" do
		include ActionView::Helpers
		let(:team) { create(:team) }
		before(:each) do
			user.teams << team
		end
		it "should redirect to sign in page if not signed in" do
			get :show, :id => team.id
			expect(response).to redirect_to(new_user_session_path)
		end
		it "should redirect to project index page" do
			sign_in user
			get :show, :id => team.id
			expect(response).to redirect_to(team_projects_path(team))
		end
	end
	describe "POST invite" do
		let(:member) { create(:user) }
		it "should redirect to sign in page if not signed in" do
			team = user.teams.last
			post :invite, :id => team.id, :user_ids => [ member.id ]
			expect(response).to redirect_to(new_user_session_path)
		end
		it "should redirect to project index page" do
			team = user.teams.last
			request.env["HTTP_REFERER"] = team_projects_path(team)
			sign_in user
			post :invite, :id => team.id, :user_ids => [ member.id ]
			expect(response).to redirect_to(team_projects_path(team))
		end
	end
end
