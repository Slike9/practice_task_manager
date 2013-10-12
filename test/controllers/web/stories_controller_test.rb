require 'test_helper'

class Web::StoriesControllerTest < ActionController::TestCase
  setup do
    @current_user = FactoryGirl.create(:user)
    sign_in(@current_user)
    @story = FactoryGirl.create(:story_with_comments)
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
    story_params = attributes_for(:story)
    post :create, story: story_params
    assert_response :redirect
    created_story = Story.find_by(title: story_params[:title])
    assert { created_story.present? }
    assert { created_story.description == story_params[:description] }
    assert { @current_user == created_story.author }
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
    story_params = attributes_for(:story)
    patch :update, id: @story, story: story_params
    assert_response :redirect
    @story.reload
    assert { story_params[:title] == @story.title }
    assert { story_params[:description] == @story.description }
  end

  test "destroy story" do
    delete :destroy, id: @story
    assert_response :redirect
    assert { not Story.exists?(title: @story.title) }
  end

  test 'story state changing' do
    story = create(:new_story)
    patch :proceed_state, id: story.id, event: :start
    assert_response :redirect
    story.reload
    assert { story.started? }
  end

end
