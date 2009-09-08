$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

%w{rubygems erb nokogiri open-uri}.each { |r| require r }

require "dget/utils"
require "dget/googlecode"
require "dget/github"
  
module DGet
  VERSION = '0.0.1' #unless defined? VERSION
  
  def self.cli(stdin, stdout, args)
    engine, project_spec, file = *args
    if (engine && project_spec) then 
      case engine
      when "github"
        GitHubEngine.new.do(project_spec, file)
      when "googlecode"
        GoogleCodeEngine.new.do(project_spec, file)
      end
    else 
      stdout.puts "Usage: dget [github|googlecode] [user/project|project] [file]"
    end
  end
end
