require 'test_helper'

class PhotosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    photo = photos :one
    assert_difference('Photo.count') do
      post :create, photo:
      {
        title: photo.title,
        description: photo.description,
        uploaded_file: fixture_file_upload('cool.png', 'image/png')
      }
    end

    assert_redirected_to photos_path
  end

  test "should get destroy" do
    photo = photos :one
    delete :destroy, id: photo.id
    assert_redirected_to photos_url
  end

  test "shoudl get photo" do
    photo = photos :one
    get :photo, id: photo.id
    assert_response :success
  end

end
