module TeamConcern
  extend ActiveSupport::Concern

  included do
    layout 'team'
    before_action :check_current_team
  end

  protected
  def current_team
    return unless session[:team_id]
    @current_team ||= Team.find(session[:team_id])
  end
  def current_team=(team)
    team_id = team.is_a? Team ? team.id : team
    session[:team_id] = team_id
  end
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