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
        puts '11111'
        send_file Rails.root.join(t_file), type: 'image/png', disposition: 'inline'
        #FileUtils.rm(t_file)
        puts '2222222'
      end
      format.jpeg do
        send_file Rails.root.join(t_file), type: 'image/jpeg', disposition: 'inline'
        #FileUtils.rm(t_file)
      end
    end
  end
end
