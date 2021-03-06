# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rack-accept-header-updater}
  s.version = "1.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Cyril Rohr"]
  s.date = %q{2009-12-07}
  s.description = %q{A Rack middleware for automatically removing file extensions from URIs, and update the Accept HTTP Header accordingly.}
  s.email = %q{cyril.rohr@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "lib/rack/accept_header_updater.rb",
     "rack-accept-header-updater.gemspec",
     "spec/rack_accept_header_updater_spec.rb",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/crohr/rack-accept-header-updater}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{A Rack middleware for automatically removing file extensions from URIs, and update the Accept HTTP Header accordingly.}
  s.test_files = [
    "spec/rack_accept_header_updater_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

