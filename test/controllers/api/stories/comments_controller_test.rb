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
    assert_response :no_content
    assert_not Comment.exists?(body: @comment.body)
  end

  test "create comment" do
    comment_params = attributes_for(:comment)
    post :create, format: :json, story_id: @story, comment: comment_params
    assert_response :created
    created_comment = Comment.find_by(body: comment_params[:body])
    assert created_comment.present?
    assert_equal current_user, created_comment.author
    assert_nil created_comment.parent
    assert_equal @story, created_comment.story
  end

  test 'create child comment' do
    comment_params = attributes_for(:child_comment, parent_id: @comment.id)
    post :create, format: :json, story_id: @story, comment: comment_params
    assert_response :created
    created_comment = Comment.find_by(body: comment_params[:body])
    assert created_comment.present?
    assert_equal @comment, created_comment.parent
  end

end
