require 'rails_helper'

RSpec.describe ProjectsController, :type => :controller do
	render_views
	let(:user) { create(:user) }
	let(:team) { create(:team_with_projects) }
	let(:project) { create(:project) }
	before(:each) do 
		user.teams << team
		user.projects << project
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
			expect(assigns(:projects)).to match_array(team.projects)
		end
	end
	describe "GET show" do
		it "should redirect to sign in page if not signed in" do
			get :show, :id => project.id
			expect(response).to redirect_to(new_user_session_path)
		end
		it "should redirect to root page if current_team is nil" do
			sign_in user
			get :show, :id => project.id
			expect(response).to redirect_to(root_path)
		end
		it "should responds successfully with an HTTP 200 status code" do
			session[:team_id] = team.id
			sign_in user
			get :show, :id => project.id
			expect(response).to be_success
      		expect(response).to have_http_status(200)
		end
		it "should render the show template" do
			session[:team_id] = team.id
			sign_in user
			get :show, :id => project.id
			expect(response).to render_template("show")
		end
		it "should load product into @product" do
			session[:team_id] = team.id
			sign_in user
			get :show, :id => project.id
			expect(assigns(:project)).to match(project)
		end
	end
	describe "POST invite" do
		let(:member) { create(:user) }
		let(:team) { create(:team) }
		before(:each) do
			team.projects << project
		end
		it "should redirect to sign in page if not signed in" do
			post :invite, :id => project.id, :user_ids => [ member.id ]
			expect(response).to redirect_to(new_user_session_path)
		end
		it "should redirect to project index page" do
			session[:team_id] = team.id
			request.env["HTTP_REFERER"] = project_path(project)
			sign_in user
			post :invite, :id => project.id, :user_ids => [ member.id ]
			expect(response).to redirect_to(project_path(project))
		end
	end
end
