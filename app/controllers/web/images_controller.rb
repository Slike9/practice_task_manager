class Web::ImagesController < ApplicationController
  def show
    sleep params[:sleep].to_f if params[:sleep]
    
    respond_to do |format|
      format.png do
        send_file Rails.root.join('public/404.html'), type: 'image/png', disposition: 'inline'
      end
      format.jpeg do
        send_file Rails.root.join('public/404.html'), type: 'image/jpeg', disposition: 'inline'
      end
    end
  end
end
