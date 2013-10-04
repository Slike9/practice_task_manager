Configus.build Rails.env do
  env :production do
    admin_email 'admin@task-manaber.ru'
  end

  env :development do
    admin_email 'admin@dev.task-manaber.ru'
  end

  env :test do
    admin_email 'admin@test.task-manaber.ru'
  end
end
