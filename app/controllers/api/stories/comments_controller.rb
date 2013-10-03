class Api::Stories::CommentsController < Api::Stories::ApplicationController

  helper_method :comment

  def show
    respond_with(comment)
  end

  def create
    @comment = resource_story.comments.build(comment_params)
    @comment.author = current_user
    @comment.save
    respond_with(@comment, location: nil)
  end

  def update
    comment.update(comment_params)
    respond_with(comment)
  end

  def destroy
    comment.destroy
    respond_with(comment)
  end

  private

  def comment
    @comment ||= resource_story.comments.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end

end
