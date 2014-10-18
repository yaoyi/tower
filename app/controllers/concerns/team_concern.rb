module TeamConcern
  include ApplicationHelper
  extend ActiveSupport::Concern

  included do
    layout 'team'
    before_action :check_current_team
  end

  protected
  def check_current_team
    @team = current_team
    if current_team.nil? 
      set_current_team(params[:team_id])
      redirect_to root_path if current_team.nil?
    end
  end

  def set_current_team
    @team = current_team = params[:team_id]
  end
end