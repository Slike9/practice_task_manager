require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  def setup
    @present_user_data = {email: '1@1.ru', password: '1', password_confirmation: '1'}
    @present_user = User.create!(@present_user_data)
  end

  test "get new success" do
    get :new
    assert_response :success
  end

  test 'post create redirects to root url for correct user data' do
    post :create, user_data: {email: @present_user_data[:email], password: @present_user_data[:password]}
    assert_redirected_to root_url
  end

  test 'post create success for incorrect user data' do
    post :create, user_data: {email: '2@2.ru', password: '2'}
    assert_response :success
  end

  test 'delete destroy redirects to root page' do
    delete :destroy
    assert_redirected_to root_url

    delete :destroy, {}, {user_id: @present_user.id}
    assert_redirected_to root_url
  end

end
