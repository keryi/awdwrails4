class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_i18n_locale_from_params
  before_action :authorize

  protected

  def authorize
    if request.format == Mime::HTML
      user = User.find_by id: session[:user_id]
    else
      user = authenticate_or_request_with_http_basic do |name, pass|
        User.find_by(name: name).try(:authenticate, pass)
      end
    end
    redirect_to login_url, notice: 'Please log in' unless user
  end

  def set_i18n_locale_from_params
    if params[:locale]
      if I18n.available_locales.map(&:to_s).include? params[:locale]
        I18n.locale = params[:locale]
      else
        flash.now[:notice] = "#{params[:locale]} translation not available"
        logger.error flash.now[:notice]
      end
    end
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
