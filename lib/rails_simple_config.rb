require "rails_simple_config/version"
require "rails_simple_config/railtie"

module RailsSimpleConfig
end

module SimpleConfig

  class Config < ActiveSupport::OrderedOptions

    def load!
      puts "Loading configuration for '#{Rails.env}'."
      load_file File.join(Rails.root, 'config', 'secrets.yml')
      load_file File.join(Rails.root, 'config', 'config.yml')
    end
    
    def reload!
      clear
      load!
    end
    
    private
    
    def load_file(filename)
      if File.exist?(filename)
        configuration = YAML.load(ERB.new(File.read(filename)).result(binding))[Rails.env]
        configuration.each do |key, value|
          self.__send__("#{key}=", value)
        end if configuration
      end
    end

  end

  @@config = Config.new
  
  def self.load!
    @@config.load!
  end
  
  def self.reload!
    @@config.reload!
  end

  def self.method_missing(method, *args)
    @@config.__send__(method, *args)
  end

end

# alias to support using AppConfig global
AppConfig = SimpleConfig
