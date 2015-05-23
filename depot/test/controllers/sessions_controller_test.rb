require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should login" do
    user = users :one
    post :create, { name: user.name, password: 'secret' }
    assert_redirected_to admin_url
    assert user.id, session[:user_id]
  end

  test "should fail login" do
    user = users :one
    post :create, { name: user.name, password: 'secret1' }
    assert_redirected_to login_url
  end

  test "should logout" do
    delete :destroy
    assert_redirected_to store_url
  end

  test "should create an admin if no user in database" do
    User.delete_all
    post :create, { name: 'David', password: 'secret' }
    assert_redirected_to admin_url
    user = User.first
    assert_equal "#{user.name} has become the administrator", flash[:notice]
    assert 1, User.count
    assert user.id, session[:user_id]
  end
end
