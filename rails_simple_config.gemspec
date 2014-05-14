# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rails_simple_config/version"

Gem::Specification.new do |s|
  s.name        = "rails_simple_config"
  s.summary     = %q{Simple YAML based configuration gem for Rails}
  s.description = %q{A simple YAML based configuration for Ruby on Rails, which supports shared settings, ERB and more.}

  s.authors     = ["Chris Stefano"]
  s.email       = ["virtualstaticvoid@gmail.com"]

  s.homepage    = "https://github.com/virtualstaticvoid/rails_simple_config"

  s.version     = RailsSimpleConfig::VERSION
  s.platform    = Gem::Platform::RUBY

  s.rubyforge_project = "rails_simple_config"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
