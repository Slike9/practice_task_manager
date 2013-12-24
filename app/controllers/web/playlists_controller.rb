class Web::PlaylistsController < ApplicationController
  def show
    sleep params[:sleep].to_f if params[:sleep]
  end
end
