class SessionsController < ApplicationController
  skip_before_action :authorize

  def new
  end

  def create
    if User.count.zero?
      admin = User.create name: params[:name], password: params[:password]
      session[:user_id] = admin.id
      redirect_to admin_url, notice: "#{admin.name} has become the administrator"
      return
    end
    user = User.find_by name: params[:name]
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to admin_url
    else
      redirect_to login_url, notice: 'Invalid user/password combination'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to store_url, notice: 'Logged out'
  end
end
