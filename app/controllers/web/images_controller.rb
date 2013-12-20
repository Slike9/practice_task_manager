class Web::ImagesController < ApplicationController
  def show
    sleep params[:sleep].to_f if params[:sleep]
    
    im = params[:im] || '1.png'
    file = "public/#{im}"
    t_file = 'public/im.png'
    FileUtils.cp file, t_file
    respond_to do |format|
      format.png do
        send_file Rails.root.join(t_file), type: 'image/png', disposition: 'inline'
      end
      format.jpeg do
        send_file Rails.root.join(t_file), type: 'image/jpeg', disposition: 'inline'
      end
    end
    FileUtils.rm(t_file)
  end
end
