require 'rubygems'
gem 'hoe', '>= 2.1.0'
require 'hoe'
require 'fileutils'
require './lib/dget'

Hoe.plugin :newgem
Hoe.plugin :cucumberfeatures

puts DGet::VERSION
$hoe = Hoe.spec 'dget' do
  self.developer 'Nick Partridge', 'nkpart@gmail.com'
  self.rubyforge_name       = self.name # TODO this is default value
  self.extra_deps         = [['nokogiri','>= 0.0']] #TODO pick a version
  self.version = DGet::VERSION
  
end

require 'newgem/tasks'
Dir['tasks/**/*.rake'].each { |t| load t }
