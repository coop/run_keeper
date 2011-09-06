# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "run_keeper/version"

Gem::Specification.new do |s|
  s.name        = "run_keeper"
  s.version     = RunKeeper::VERSION
  s.authors     = ["Tim Cooper"]
  s.email       = ["coop@latrobest.com"]
  s.homepage    = "http://github.com/coop/run_keeper"
  s.summary     = "Run Keeper API client"
  s.description = "Run Keeper API client"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'activesupport', '~> 3.1.0'
  s.add_dependency 'oauth2', '~> 0.5.0'
end
