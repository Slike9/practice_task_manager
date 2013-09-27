require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "get new" do
    get :new
    assert_response :success
  end

  test 'user creating: correct user data' do
    post :create, user: {email: '1@1.ru', password: '1', password_confirmation: '1'}
    assert_response :redirect
    assert user_with_email_exists?('1@1.ru')
  end

  test 'user creating: incorrect user data' do
    data_without_email = {email: '', password: '1', password_confirmation: '1'}
    assert_no_difference -> { User.count } do
      post :create, user: data_without_email
    end
    assert_response :success

    data_with_incorrect_password = {email: '1@1.ru', password: '1', password_confirmation: '2'}
    assert_no_difference -> { User.count } do
      post :create, user: data_with_incorrect_password
    end
    assert_response :success
  end

  private

  def user_with_email_exists?(email)
    User.find_by(email: email).present?
  end
end
