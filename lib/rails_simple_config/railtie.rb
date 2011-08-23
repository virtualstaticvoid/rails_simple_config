require 'rails_simple_config'

module RailsSimpleConfig
  class Railtie < Rails::Railtie
  
    # load the configuration before the respective environment configuration file is loaded!
    initializer :load_simple_config, :before => :load_environment_config do
      ::SimpleConfig.reload!    
    end
    
    # Rails Dev should reload the configuration on each request
    if Rails.env.development?
      initializer :load_simple_config_development do
        ActionController::Base.class_eval do
          prepend_before_filter { ::SimpleConfig.reload! }
        end
      end
    end 
  
  end
end

