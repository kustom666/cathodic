# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "cathodic/version"

Gem::Specification.new do |s|
  s.name        = "cathodic"
  s.version     = Cathodic::VERSION
  s.authors     = ["Paul Forti"]
  s.email       = ["paul@itsbi.fr"]
  s.homepage    = "https://github.com/kustom666/cathodic"
  s.summary     = "Gets a twitch.tv stream's info from the api"
  s.description = "Cathodic helps users retreiving the data from a twitch tv stream, such as the number of viewers, 
                   a preview thumbnail, the embed code, the status etc from the twitch channel's url"

  s.rubyforge_project = "cathodic"
  s.add_development_dependency "json"
  s.add_runtime_dependency "json"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
