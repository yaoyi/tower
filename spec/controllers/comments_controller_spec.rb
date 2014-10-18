require 'rails_helper'

RSpec.describe CommentsController, :type => :controller do
	render_views
	let(:user) { create(:user) }
	let(:project) { create(:project) }
	let(:todo) { create(:todo) }
	let(:comment) { create(:comment) }
	before(:each) do
		project.todolists << todo.todolist
	end
	describe "POST create" do
		it "should redirect to sign in page if not signed in" do
			post :create, :comment => {
				content: comment.content,
				commentable_type: todo.class.name, 
				commentable_id: todo.id
			}
			expect(response).to redirect_to(new_user_session_path)
		end
		it "should redirect to project path" do
			request.env["HTTP_REFERER"] = project_path(project)
			sign_in user
			post :create, :comment => {
				content: comment.content,
				commentable_type: todo.class.name, 
				commentable_id: todo.id
			}
			expect(response).to redirect_to(project_path(project))
		end
	end
	describe "DELETE destroy" do
		it "should redirect to sign in page if not signed in" do
			delete :destroy, :id => comment.id
			expect(response).to redirect_to(new_user_session_path)
		end
		it "should redirect back" do
			request.env["HTTP_REFERER"] = project_path(project)
			sign_in user
			delete :destroy, :id => comment.id
			expect(response).to redirect_to(project_path(project))
		end
	end
end
