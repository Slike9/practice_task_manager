class Web::PlaylistsController < ApplicationController
  def show
    sleep params[:sleep] if params[:sleep]
  end
end
