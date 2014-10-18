require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
	render_views
	let(:user) { create(:user) }
	let(:team) { create(:team) }
	let(:project) { create(:project) }
	before(:each) do
		team.users << user
		project.users << user
		team.projects << project
	end
	describe "GET index" do
		it "should redirect to sign in page if not signed in" do
			get :index 
			expect(response).to redirect_to(new_user_session_path)
		end
		it "should load team members" do
			sign_in user
			get :index, :team_id => team.id
			expect(assigns(:users)).to match_array(team.users)
		end
		it "should render team template" do
			sign_in user
			get :index, :team_id => team.id
			expect(response).to render_template("team")
		end
		it "should load project members" do
			session[:team_id] = team.id
			sign_in user
			get :index, :project_id => project.id
			expect(assigns(:users)).to match_array(project.users)
		end
		it "should render project template" do
			session[:team_id] = team.id
			sign_in user
			get :index, :project_id => project.id
			expect(response).to render_template("project")
		end
	end
end
