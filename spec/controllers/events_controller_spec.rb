require 'rails_helper'

RSpec.describe EventsController, :type => :controller do
	render_views
	let(:user) { create(:user) }
	let(:team) { create(:team) }
	let(:event) { create(:event) }
	before(:each) do 
		user.teams << team
		team.events << event
	end
	describe "GET index" do
		it "should redirect to sign in page if not signed in" do
			get :index, :team_id => team.id
			expect(response).to redirect_to(new_user_session_path)
		end
		it "should responds successfully with an HTTP 200 status code" do
			sign_in user
			get :index, :team_id => team.id
			expect(response).to be_success
      		expect(response).to have_http_status(200)
		end
		it "should renders the index template" do
			sign_in user
			get :index, :team_id => team.id
			expect(response).to render_template("index")
		end
		it "should loads all projects of team into @projects" do
			sign_in user
			get :index, :team_id => team.id
			expect(assigns(:events)).to match_array(team.events)
		end
	end
end
