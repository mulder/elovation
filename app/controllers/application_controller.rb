class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_player

  before_filter :authorize_user!

  def current_player
    @current_player ||= Player.find_by(guid: session[:guid]) if session[:guid].present?
  end


  def authorize_user!
    redirect_to(login_path) if current_player.blank?
  end
end
