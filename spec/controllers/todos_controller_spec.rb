require 'rails_helper'

RSpec.describe TodosController, :type => :controller do
	render_views
	let(:user) { create(:user) }
	let(:team) { create(:team) }
	let(:project) { create(:project) }
	let(:todolist) { create(:todolist) }
	let(:todo) { create(:todo) }
	before(:each) do 
		todolist.todos << todo
		project.todolists << todolist
		user.projects << project
		user.teams << team
	end
	describe "GET show" do
		it "should redirect to sign in page if not signed in" do
			get :show, :project_id => project.id, :id => todo.id
			expect(response).to redirect_to(new_user_session_path)
		end
		it "should redirect to root page if current_team is nil" do
			sign_in user
			get :show, :project_id => project.id, :id => todo.id
			expect(response).to redirect_to(root_path)
		end
		it "should responds successfully with an HTTP 200 status code" do
			session[:team_id] = team.id
			sign_in user
			get :show, :project_id => project.id, :id => todo.id
			expect(response).to be_success
      		expect(response).to have_http_status(200)
		end
		it "should render the show template" do
			session[:team_id] = team.id
			sign_in user
			get :show, :project_id => project.id, :id => todo.id
			expect(response).to render_template("show")
		end
		it "should load product into @product" do
			session[:team_id] = team.id
			sign_in user
			get :show, :project_id => project.id, :id => todo.id
			expect(assigns(:todo)).to match(todo)
		end
	end
	describe "POST create" do
		it "should redirect to sign in page if not signed in" do
			post :create, :project_id => project.id, :todo => {content: todo.content}
			expect(response).to redirect_to(new_user_session_path)
		end
		it "should redirect to project path" do
			session[:team_id] = team.id
			sign_in user
			post :create, :project_id => project.id, :todo => {content: todo.content}
			expect(response).to redirect_to(project_path(project))
		end
	end
	describe "POST done" do
		it "should redirect to sign in page if not signed in" do
			post :done, :project_id => project.id, :id => todo.id, :done => 'false'
			expect(response).to redirect_to(new_user_session_path)
		end
		it "should redirect back" do
			session[:team_id] = team.id
			request.env["HTTP_REFERER"] = project_path(project)
			sign_in user
			post :done, :project_id => project.id, :id => todo.id, :done => 'false'
			expect(response).to redirect_to(project_path(project))
		end
	end
	describe "DELETE destroy" do
		it "should redirect to sign in page if not signed in" do
			delete :destroy, :project_id => project.id, :id => todo.id
			expect(response).to redirect_to(new_user_session_path)
		end
		it "should redirect to root page if current team is nil" do
			sign_in user
			delete :destroy, :project_id => project.id, :id => todo.id
			expect(response).to redirect_to(root_path)
		end
		it "should redirect back" do
			session[:team_id] = team.id
			request.env["HTTP_REFERER"] = project_path(project)
			sign_in user
			delete :destroy, :project_id => project.id, :id => todo.id
			expect(response).to redirect_to(project_path(project))
		end
	end
end
