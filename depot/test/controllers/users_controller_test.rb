require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { name: 'Jenny', password: 'secret', password_confirmation: 'secret' }
    end

    assert_redirected_to users_path
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user with correct current password" do
    patch :update, id: @user,
      user: {
        name: 'Jenny',
        current_password: 'secret',
        password: 'secret',
        password_confirmation: 'secret'
      }
    assert_redirected_to users_path
  end

  test "should not update user with incorrect current password" do
    patch :update, id: @user,
      user: {
        name: 'Jenny',
        current_password: 'wrong',
        password: 'secret',
        password_confirmation: 'secret'
      }
    assert_redirected_to edit_user_path(@user)
    assert_equal flash[:notice], 'Incorrect current password'
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
