require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  def setup
    @present_user = FactoryGirl.create(:user)
  end

  test "get new success" do
    get :new
    assert_response :success
  end

  test 'post create with correct user data signs in the user' do
    post :create, user_data: {email: @present_user.email, password: @present_user.password}
    assert_response :redirect
    assert_equal @present_user, @controller.current_user
  end

  test 'post create with incorrect user data: any user does not sign in' do
    post :create, user_data: {email: '2@2.ru', password: '2'}
    assert_response :success
    assert !@controller.user_signed_in?
  end

  test 'delete destroy signs out user' do
    @controller.sign_in(@present_user)
    delete :destroy
    assert_response :redirect
    assert !@controller.user_signed_in?
  end

end
