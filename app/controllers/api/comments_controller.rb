class Api::CommentsController < Api::ApplicationController
  before_action :set_story, only: [:create]

  def show
    @comment = Comment.find(params[:id])
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author = current_user
    @comment.story = @story
    if @comment.save
      render :show, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    head status: :no_content
  end

  private

  def set_story
    @story = Story.find(params[:story_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end
end
