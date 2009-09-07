$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

%w{rubygems erb nokogiri open-uri}.each { |r| require r }

require "gh-wiki/utils"
require "gh-wiki/googlecode"
require "gh-wiki/github"
  
module GhWiki
  VERSION = '0.0.1' unless defined? VERSION
end
