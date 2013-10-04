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
  # GET /stories.json
  def index
    @search = Story.search(params[:q])
    @stories = @search.result
    @stories = @stories.includes(:author, :owner).page(params[:page]).per(params[:per_page])
  end

  # GET /stories/1
  # GET /stories/1.json
  def show
    @comments = @story.comments.includes(:author, :story).arrange(order: :created_at)
  end

  # GET /stories/new
  def new
    @story = Story.new
  end

  # GET /stories/1/edit
  def edit
  end

  # POST /stories
  # POST /stories.json
  def create
    @story = Story.new(story_params)
    @story.author = current_user

    respond_to do |format|
      if @story.save
        format.html { redirect_to @story, notice: 'Story was successfully created.' }
        format.json { render action: 'show', status: :created, location: @story }
      else
        format.html { render action: 'new' }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stories/1
  # PATCH/PUT /stories/1.json
  def update
    respond_to do |format|
      if @story.update(story_params)
        format.html { redirect_to @story, notice: 'Story was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stories/1
  # DELETE /stories/1.json
  def destroy
    @story.destroy
    respond_to do |format|
      format.html { redirect_to stories_url }
      format.json { head :no_content }
    end
  end

  def proceed_state
    @story.state_event = params[:event]
    if @story.save
      redirect_to story_url(@story), notice: t('flashes.story.state_changed', state: @story.human_state_name)
    else
      redirect_to story_url(@story), flash: {error: t('flashes.story.invalid_state_event')}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_story
      @story = Story.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def story_params
      params.require(:story).permit(:title, :description, :owner_id)
    end
end
