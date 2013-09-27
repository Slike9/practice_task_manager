require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "get new success" do
    get :new
    assert_response :success
  end

  test 'post create redirects to root url for correct user data' do
    post :create, user: {email: '1@1.ru', password: '1', password_confirmation: '1'}
    assert_redirected_to root_url
  end

  test 'post create success for incorrect user data' do
    post :create, user: {email: '', password: '1', password_confirmation: '1'}
    assert_response :success

    post :create, user: {email: '1@1.ru', password: '1', password_confirmation: '2'}
    assert_response :success
  end
end
