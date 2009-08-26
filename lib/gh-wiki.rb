$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'open-uri'
require 'nokogiri'

module GhWiki
  VERSION = '0.0.1' unless defined? VERSION
  
  def N url
    Nokogiri::HTML(open(url))
  end
  
  class Project
    include GhWiki
    
    attr_reader :user, :name
    def initialize user, name
      @user = user
      @name = name
    end
    
    def home_doc
      @home_doc ||= N("http://wiki.github.com/#{user}/#{name}")
    end
    
    def description
      home_doc.css("#repository_description").each do |h|
        @desc = h.content
      end
      @desc
    end
    
    def pages
      home_doc.css(".sidebar ul li b a").map do |item|
        item.content
      end
    end
  end
end
