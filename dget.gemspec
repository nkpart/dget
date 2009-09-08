# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{dget}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Nick Partridge"]
  s.date = %q{2009-09-08}
  s.default_executable = %q{dget}
  s.description = %q{Documentation getter}
  s.email = ["nkpart@gmail.com"]
  s.executables = ["dget"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt"]
  s.files = ["History.txt", "Manifest.txt", "README.rdoc", "Rakefile", "bin/dget", "lib/dget.rb", "lib/dget/github.html", "lib/dget/github.rb", "lib/dget/googlecode.rb", "lib/dget/utils.rb", "lib/googlecode.html", "script/console", "script/destroy", "script/generate", "test/test_gh-wiki.rb", "test/test_helper.rb"]
  s.homepage = %q{http://github.com/nkpart/dget}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{dget}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Documentation getter}
  s.test_files = ["test/test_gh-wiki.rb", "test/test_helper.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nokogiri>, [">= 0.0"])
      s.add_development_dependency(%q<hoe>, [">= 2.3.3"])
    else
      s.add_dependency(%q<nokogiri>, [">= 0.0"])
      s.add_dependency(%q<hoe>, [">= 2.3.3"])
    end
  else
    s.add_dependency(%q<nokogiri>, [">= 0.0"])
    s.add_dependency(%q<hoe>, [">= 2.3.3"])
  end
end
