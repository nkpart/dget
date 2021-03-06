$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

%w{rubygems erb nokogiri open-uri}.each { |r| require r }

require 'peach'
require "dget/utils"
require "dget/googlecode"
require "dget/github"
  
module DGet
  VERSION = '0.0.1' unless defined? VERSION
  
  GH = GitHubEngine.new unless defined? GH
  GC = GoogleCodeEngine.new unless defined? GC
  
  def self.parse_args args    
    if (args[0] =~ /github.com\/(.*)\/(.*)[\/]{0,1}/)
      return ["github", $1 + "/" + $2, args[1]]
    end
    
    engine, project_spec, file = *args
    if (engine && project_spec)
      [engine, project_spec, file]
    else 
      []
    end
  end
  
  def self.cli(stdin, stdout, args)
    parsed = parse_args(args)
    if !parsed.empty?
      engine, project_spec, file = *parsed
      case engine
      when "github"
        GH.do(project_spec, file)
      when "googlecode"
        GC.do(project_spec, file)
      end
    else
      stdout.puts <<USAGE 
 Usage: 
   dget [github|googlecode] [user/project|project] [file]
   dget http://github.com/user/project [file]
USAGE
    end
  end
end
