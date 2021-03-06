ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def login_as(user)
    session[:user_id] = user.id
  end

  def logout
    session[:user_id] = nil
  end

  def setup
    login_as users(:one) if defined? session
  end
end
