module RailsSimpleConfig
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    
    def copy_files
      template "config.yml", File.join("config", "config.yml")
      template "secrets.yml", File.join("config", "secrets.yml")
      template "secrets.yml", File.join("config", "secrets.example.yml")
    end
  
  end
end
