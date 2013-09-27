require 'test_helper'

class StoriesControllerTest < ActionController::TestCase
  setup do
    @current_user = FactoryGirl.create(:user)
    @controller.sign_in(@current_user)
    @story = FactoryGirl.create(:story)
  end

  test "get index" do
    get :index
    assert_response :success
  end

  test "get new" do
    get :new
    assert_response :success
  end

  test "create story" do
    assert_difference('Story.count') do
      post :create, story: { description: 'eval 1 + 1', title: 'Math operation' }
    end
    assert_response :redirect

    created_story = assigns(:story)
    assert_equal created_story.title, 'Math operation'
    assert_equal created_story.description, 'eval 1 + 1'
    assert_equal @current_user, created_story.author
  end

  test "show story" do
    get :show, id: @story
    assert_response :success
  end

  test "get edit" do
    get :edit, id: @story
    assert_response :success
  end

  test "update story" do
    patch :update, id: @story, story: { description: 'implement', title: 'super feature' }
    assert_response :redirect
    @story.reload
    assert_equal 'super feature', @story.title
    assert_equal 'implement', @story.description
  end

  test "destroy story" do
    assert_difference('Story.count', -1) do
      delete :destroy, id: @story
    end
    assert_response :redirect
  end
end
