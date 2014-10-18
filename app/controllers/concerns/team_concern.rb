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
  def check_current_team
    if current_team.nil? 
      session[:team_id] = params[:team_id]
      redirect_to root_path if current_team.nil?
    end
  end
end