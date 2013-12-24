class Web::ImagesController < ApplicationController
  def show
    sleep params[:sleep].to_f if params[:sleep]
    
    im = params[:im] || '1.png'
    file = "public/#{im}"
    t_file = 'public/im.png'
    t = Tempfile.new('t')
    t_file = t.path
    FileUtils.cp file, t_file
    respond_to do |format|
      format.png do
        send_data File.binread(t_file), type: 'image/png', disposition: 'inline'
      end
      format.jpeg do
        send_file t_file, type: 'image/jpeg', disposition: 'inline'
      end
    end
  end
end
