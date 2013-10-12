require 'test_helper'

class Web::UsersControllerTest < ActionController::TestCase
  def setup
    @user = create(:user)
  end

  test "get new" do
    get :new
    assert_response :success
  end

  test 'user creating' do
    user_params = attributes_for(:user_with_password_confirmation)
    post :create, user: user_params
    assert_response :redirect

    user = User.find_by(email: user_params[:email])
    assert user.present?

    assert user_registration_email_sent?(user), 'User registration email has not been sent'
  end

  test 'get show' do
    get :show, id: @user
    assert_response :success
  end

  test 'get edit' do
    get :edit, id: @user
    assert_response :success
  end

  test 'patch update' do
    user_params = attributes_for(:user_with_password_confirmation)
    patch :update, id: @user, user: user_params
    assert_response :redirect

    @user.reload
    assert { user_params[:email] == @user.email }
  end

  private

  def user_registration_email_sent?(user)
    registration_email = ActionMailer::Base.deliveries.last
    registration_email.present? && [user.email] == registration_email.to
  end
end
