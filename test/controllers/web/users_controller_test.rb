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
    post :create, user: {email: '1@1.ru', password: '1', password_confirmation: '1'}
    assert_response :redirect
    assert User.exists?(email: '1@1.ru')
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
    patch :update, id: @user, user: {email: 'new@mail.ru'}
    assert_response :redirect
    @user.reload
    assert 'new@mail.ru', @user.email
  end
end
