require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  def setup
    @present_user = FactoryGirl.create(:user)
  end

  test "get new" do
    get :new
    assert_response :success
  end

  test 'creating user session: user data correct' do
    post :create, user_data: {email: @present_user.email, password: @present_user.password}
    assert_response :redirect
    assert_equal @present_user, current_user
  end

  test 'creating user session: user data incorrect' do
    post :create, user_data: {email: '2@2.ru', password: '2'}
    assert_response :success
    assert_not user_signed_in?
  end

  test 'destroying user session' do
    sign_in(@present_user)
    delete :destroy
    assert_response :redirect
    assert_not user_signed_in?
  end

end
