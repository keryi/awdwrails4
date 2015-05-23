class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authorize

  private

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
end
