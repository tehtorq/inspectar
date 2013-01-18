# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "inspectar/version"

Gem::Specification.new do |s|
  s.name        = "inspectar"
  s.version     = Inspectar::VERSION
  s.authors     = ["Douglas Anderson"]
  s.email       = ["i.am.douglas.anderson@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{ Generate activerecord models for a MySQL database. }
  s.description = %q{ Given an existing MySQL database, Inspectar will dynamically generate activerecord classes for each of the tables. }

  s.rubyforge_project = "inspectar"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "activesupport"
  s.add_dependency "activerecord", "~> 3.0"
  s.add_dependency "i18n"
  
  s.add_development_dependency 'combustion', '~> 0.3.1'
end
