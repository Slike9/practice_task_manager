require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "get new success" do
    get :new
    assert_response :success
  end
end
