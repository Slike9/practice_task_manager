require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  setup do
    @current_user = create(:user)
    sign_in(@current_user)
    @story = create(:story)
    @comment = create(:comment, story: @story)
  end

  test "get index" do
    get :index, story_id: @story
    assert_response :success
  end

  test "should get new" do
    get :new, story_id: @story
    assert_response :success
  end

  test "should create comment" do
    assert_difference('Comment.count') do
      post :create, story_id: @story, comment: { body: @comment.body }
    end
    assert_response :redirect
    created_comment = assigns(:comment)
    assert_equal current_user, created_comment.author
    assert_equal @story, created_comment.story
  end


  test 'create child comment' do
    assert_difference('@comment.children.count', +1) do
      post :create, comment: {parent_id: @comment, body: 'It\'s a child comment'}
    end
    assert_response :redirect
  end

  test "should show comment" do
    get :show, id: @comment, story_id: @story
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @comment, story_id: @story
    assert_response :success
  end

  test "should update comment" do
    patch :update, id: @comment, story_id: @story, comment: { body: 'New comment body' }
    assert_response :redirect
    @comment.reload
    assert_equal 'New comment body', @comment.body
  end

  test "should destroy comment" do
    assert_difference('Comment.count', -1) do
      delete :destroy, id: @comment, story_id: @story
    end

    assert_response :redirect
  end
end
