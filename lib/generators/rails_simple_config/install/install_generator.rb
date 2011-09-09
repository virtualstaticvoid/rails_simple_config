module RailsSimpleConfig
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    
    def copy_files
      template "config.yml", "./config.yml"
      template "secrets.yml", "./secrets.yml"
      template "secrets.yml", "./secrets.example.yml"
    end
  
  end
end
