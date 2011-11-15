# Rails Simple Config

A simple YAML based configuration for Ruby on Rails 3+, which supports shared settings, ERB and more.

Inspired in part by the database configuration in Rails, [app_config](https://github.com/die-antwort/app_config) and [rails_config](https://github.com/railsjedi/rails_config).

## Installation

Add RailsSimpleConfig to your Gemfile:

    gem 'rails_simple_config'

Run the generator to create the default configuration files:

    rails generate rails_simple_config:install
    
The generator will create 3 files in your Rails `config` directory, namely:

* `secrets.yml`
* `secrets.example.yml`
* `config.yml`

The `secrets.yml` should _not_ be committed to source control. It should be used to keep settings which are 
considered a secret; such as your Amazon credentials. It is loaded first.

The `secrets.example.yml` file can be added to source control and should serve as an _example_ of the settings 
contained in the `secrets.yml` file.

The `config.yml` file should contain all other configuration settings.

## Usage

### Define configuration settings

Define your settings in the generated `secrets.yml` and `config.yml` files, found in your Rails `config` directory. 

Both files contain a shared section and sections with overrides for the respective development, test and production Rails environments.
It can also contain ERB code so that more advanced configuration scenarios can be supported.

    # example configuration
    
    shared: &shared

      title: My Website Title
      description: Meta description of the site
      keywords: Meta keywords for search engines
      
      no_reply_email: noreply@example.com

      dynamic_setting: <%= 30 * 60 %>
      
    development:

      # inherit shared settings
      <<: *shared
      
      # define additional settings and overrides
      
      # e.g. mail settings for mailcatcher
      smtp_server: localhost
      smtp_port: 1025
      mail_prefix: DEV -
    
    production:

      # inherit shared settings
      <<: *shared
      
      # define additional settings and overrides
      
      # e.g. mail settings for send grid
      smtp_server: www.sendgrid.com
      smtp_port: 25

### Access configuration settings

To access configuration settings in your Rails application, use the `SimpleConfig` global or the `AppConfig` alias for it.

For example, in your application layout:

    <html>
      <head>
        <title><%= SimpleConfig.title %></title>
        <meta name="description" content="<%= SimpleConfig.description %>" />
        <meta name="keywords" content="<%= SimpleConfig.keywords %>" />

        ...

      </head>
      <body>

        ...

      </body>
    </html>          

In addition, unlike other Rails configuration solutions, `SimpleConfig` is available to the Rails development, test and production environment configuration files, 
initializers and routes during startup. It can be used as a replacement for environment variables; thus making your setup and code much cleaner.

For example, the `SimpleConfig.no_reply_email` will be accessible to the [devise](https://github.com/plataformatec/devise) initializer when configuring `mailer_sender`:

    # extract of the devise.rb initializer
    Devise.setup do |config|

      # ==> Mailer Configuration
      # Configure the e-mail address which will be shown in DeviseMailer.
      config.mailer_sender = SimpleConfig.no_reply_email

      ...

    end

### Notes

`SimpleConfig` makes use of the [ActiveSupport::OrderedOptions](http://api.rubyonrails.org/classes/ActiveSupport/OrderedOptions.html) class, so accessing undefined settings will always return `nil`.

In development, the configuration is reloaded upon each request, however, any configuration used within the `application.rb` file and initializers 
will _not_ be automatically reloaded, without having to restart your web server.

## Project Info

RailsSimpleConfig is hosted on [Github](http://github.com/virtualstaticvoid/rails_simple_config), where your contributions, forkings, comments and feedback are greatly welcomed.

Copyright © 2011 Chris Stefano, released under the MIT license.

