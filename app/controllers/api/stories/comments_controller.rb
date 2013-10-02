class Api::Stories::CommentsController < Api::Stories::ApplicationController

  helper_method :comment

  def show
    respond_with(comment)
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author = current_user
    @comment.story = story
    @comment.save
    respond_with(:api, story, @comment, template: 'show', status: :created)
  end

  def destroy
    comment.destroy
    respond_with(comment)
  end

  private

  def comment
    @comment ||= Comment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end

end
