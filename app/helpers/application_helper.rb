module ApplicationHelper
	class ActionView::Helpers::FormBuilder
	    include ActionView::Helpers::FormTagHelper
	    include ActionView::Helpers::FormOptionsHelper
	    def event_trigger(action, actor)
	   	  action_tag = hidden_field_tag @object_name + '[action]', action
	      actor_tag = hidden_field_tag @object_name + '[actor]', actor
	      return actor_tag + action_tag
	    end
  	end
	def current_team
		team_id = session[:team_id]
		@current_team ||= Team.find(team_id)
	end
end
