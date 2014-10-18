require 'rails_helper'

RSpec.describe TodolistsController, :type => :controller do
	render_views
	let(:user) { create(:user) }
	let(:team) { create(:team) }
	let(:project) { create(:project) }
	let(:todolist) { create(:todolist) }
	before(:each) do 
		project.todolists << todolist
		user.projects << project
		user.teams << team
	end
	describe "POST create" do
		it "should redirect to sign in page if not signed in" do
			post :create, :project_id => project.id, :todolist => {name: todolist.name}
			expect(response).to redirect_to(new_user_session_path)
		end
		it "should redirect to project path" do
			session[:team_id] = team.id
			sign_in user
			post :create, :project_id => project.id, :todolist => {name: todolist.name}
			expect(response).to redirect_to(project_path(project))
		end
	end
	describe "DELETE destroy" do
		it "should redirect to sign in page if not signed in" do
			delete :destroy, :project_id => project.id, :id => todolist.id
			expect(response).to redirect_to(new_user_session_path)
		end
		it "should redirect to root page if current team is nil" do
			sign_in user
			delete :destroy, :project_id => project.id, :id => todolist.id
			expect(response).to redirect_to(root_path)
		end
		it "should redirect back" do
			session[:team_id] = team.id
			request.env["HTTP_REFERER"] = project_path(project)
			sign_in user
			delete :destroy, :project_id => project.id, :id => todolist.id
			expect(response).to redirect_to(project_path(project))
		end
	end
end
