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
    comment_params = attributes_for(:comment)
    post :create, story_id: @story, comment: comment_params
    assert_response :redirect
    created_comment = Comment.find_by(body: comment_params[:body])
    assert created_comment.present?
    assert_equal current_user, created_comment.author
    assert_equal @story, created_comment.story
  end

  test 'create child comment' do
    comment_params = attributes_for(:child_comment, parent_id: @comment)
    post :create, comment: comment_params
    assert_response :redirect
    created_comment = Comment.find_by(body: comment_params[:body])
    assert created_comment.present?
    assert_equal @comment, created_comment.parent
    assert_nil created_comment.story
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
    comment_params = attributes_for(:comment)
    patch :update, id: @comment, story_id: @story, comment: comment_params
    assert_response :redirect
    @comment.reload
    assert_equal comment_params[:body], @comment.body
  end

  test "should destroy comment" do
    delete :destroy, id: @comment, story_id: @story
    assert_response :redirect
    assert_not Comment.exists?(body: @comment.body)
  end
end
