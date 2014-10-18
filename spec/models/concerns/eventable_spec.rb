require 'rails_helper'

RSpec.describe Eventable do
	let(:user) { create(:user)}
	let(:project) { create(:project)}
	describe "identify" do
		it "should set actor" do
			project.identify(user.id)
			expect(project.actor).to eq(user.id)
		end	
	end
	describe "trigger" do
		it "should set action" do
			project.trigger(:create)
			expect(project.action).to eq(:create)
		end
		it "should not create an event" do
			expect{
				project.trigger(:create)
			}.to change(Event, :count).by(0)
		end
		it "should create an event" do
			expect{
				project.trigger(:create, user.id)
			}.to change(Event, :count).by(1)
		end	
		it "should create an event" do
			expect{
				project.identify(user.id)
				project.trigger(:create)
			}.to change(Event, :count).by(1)
		end
		it "should create a project:create event" do
			event = project.trigger(:create, user.id)
			expect(event.action).to eq(:create)
			expect(event.eventable).to eq(project)
		end	
		it "should reset action & actor" do
			project.identify(user.id)
			project.trigger(:create)
			expect(project.action).to be_nil
			expect(project.actor).to be_nil
		end	
		it "should reset action & actor" do
			project.trigger(:create, user.id)
			expect(project.action).to be_nil
			expect(project.actor).to be_nil
		end
	end
	describe "observers" do
		it "should create an event after project create" do
			expect{
				project = create(:project, actor: user.id, action: :create)
			}.to change(Event, :count).by(1)
		end
		it "should create a project:create event after project create" do
			project = create(:project, actor: user.id, action: :create)
			expect(Event.first.action).to eq(:create)
			expect(Event.first.eventable).to eq(project)
		end
	end
end
