class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authorize
  before_action :set_i18n_locale_from_params
  protected
  def set_i18n_locale_from_params
    if params[:locale]
      if I18n.available_locales.map(&:to_s).include?(params[:locale])
        I18n.locale = params[:locale]
      else
        flash.now[:notice] = 
        "#{params[:locale]} tarnslation not available"
        logger.error flash.now[:notice] 
      end
    end
  end
  def default_url_options
      { locale: I18n.locale }
  end
def authorize
    unless User.find_by(id: session[:user_id])
    redirect_to login_url, notice: "Please log in"
    end
end
  def increment_count
      session[:counter] ||= 0
      session[:counter] += 1
    end
end
