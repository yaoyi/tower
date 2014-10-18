require 'rails_helper'

RSpec.describe Todo, :type => :model do
	let(:todo) { create(:todo) }
	let(:user) { create(:user) }
	describe "complete" do
		it "should set a task to complete" do
			expect{
				todo.complete
			}.to change(todo, :done).from(false).to(true)
		end
		it "should set a task to resume" do
			todo = create(:todo, done: true)
			expect{
				todo.resume
			}.to change(todo, :done).from(true).to(false)
		end
	end
end