require "rails_simple_config/version"
require "rails_simple_config/railtie"

module RailsSimpleConfig
end

module SimpleConfig

  class Config < ActiveSupport::OrderedOptions

    def load!
      puts "Loading configuration for '#{Rails.env}'."
      filename = Rails.root + 'config.yml'
      if File.exist?(filename)
        configuration = YAML.load(ERB.new(File.read(filename)).result)[Rails.env]
        configuration.each do |key, value|
          self.__send__("#{key}=", value)
        end if configuration
      end
    end
    
    def reload!
      clear
      load!
    end

  end

  @@config = Config.new
  
  def self.load!
    @@config.load!
  end
  
  def self.method_missing(method, *args)
    @@config.__send__(method, *args)
  end

end

