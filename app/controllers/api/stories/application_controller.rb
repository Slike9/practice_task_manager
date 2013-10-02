class Api::Stories::ApplicationController < Api::ApplicationController

  helper_method :story

  private

  def story
    @story ||= Story.find(params[:story_id])
  end
end
