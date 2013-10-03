require 'test_helper'

class Api::Stories::CommentsControllerTest < ActionController::TestCase
  setup do
    @current_user = create(:user)
    sign_in(@current_user)
    @story = create(:story)
    @comment = create(:comment, story: @story)
  end

  test 'show comment' do
    get :show, format: :json, story_id: @story, id: @comment
    assert_response :success
  end

  test 'delete comment' do
    delete :destroy, format: :json, story_id: @story, id: @comment
    assert_response :success
    assert_not @story.comments.exists?(body: @comment.body)
  end

  test "create comment" do
    comment_params = attributes_for(:comment)
    post :create, format: :json, story_id: @story, comment: comment_params
    assert_response :created
    created_comment = @story.comments.find_by(body: comment_params[:body], author: current_user)
    assert created_comment.present?
    assert_nil created_comment.parent
  end

  test 'create child comment' do
    comment_params = attributes_for(:child_comment, parent_id: @comment.id)
    post :create, format: :json, story_id: @story, comment: comment_params
    assert_response :created
    created_comment = @story.comments.find_by(body: comment_params[:body], author: current_user)
    assert created_comment.present?
    assert_equal @comment, created_comment.parent
  end

  test 'update comment' do
    comment_params = attributes_for(:comment)
    patch :update, format: :json, story_id: @story, id: @comment, comment: comment_params
    assert_response :success
    comment = @story.comments.find_by(body: comment_params[:body])
    assert comment.present?
  end

end
