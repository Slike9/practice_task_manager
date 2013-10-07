class Web::StoriesController < Web::ApplicationController
  before_action :set_story, only: [:show, :edit, :update, :destroy, :proceed_state]

  add_breadcrumb :stories, :stories_path
  add_breadcrumb :new, :new_story_path, only: [:new]
  before_action only: [:show, :edit] do
    add_breadcrumb :story, story_path(@story)
  end
  before_action only: :edit do
    add_breadcrumb :edit, edit_story_path(@story)
  end

  # GET /stories
  def index
    @search = Story.search(params[:q])
    @stories = @search.result.includes(:author, :owner)
    @stories = @stories.page(params[:page]).per(params[:per_page])
    respond_with(@stories)
  end

  # GET /stories/1
  def show
    @comments = @story.comments.includes(:author, :story).arrange(order: :created_at)
    @story = @story.decorate
    respond_with(@story)
  end

  # GET /stories/new
  def new
    @story = Story.new
    respond_with(@story)
  end

  # GET /stories/1/edit
  def edit
    respond_with(@story)
  end

  # POST /stories
  def create
    @story = Story.new(story_params)
    @story.author = current_user
    @story.save
    respond_with(@story)
  end

  # PATCH/PUT /stories/1
  def update
    @story.update(story_params)
    respond_with(@story)
  end

  # DELETE /stories/1
  def destroy
    @story.destroy
    respond_with(@story)
  end

  def proceed_state
    @story.state_event = params[:event]
    if @story.save
      redirect_to story_url(@story), notice: t('flash.web.stories.proceed_state.state_changed', state: @story.human_state_name)
    else
      redirect_to story_url(@story), flash: {error: t('flash.web.stories.proceed_state.invalid_state_event')}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_story
      @story = Story.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def story_params
      params.require(:story).permit(:title, :description, :owner_id, :comments_attributes => [:id, :body, :_destroy])
    end
end
