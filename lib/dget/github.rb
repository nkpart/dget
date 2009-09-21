$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
  
require 'dget'
module DGet
  
  class GitHubDoc
    include DGet
    attr_reader :user, :project_name, :pages, :root_doc
    
    def initialize user, project_name
      @user = user
      @project_name = project_name
    end
  
    def root_doc
      @root_doc ||= proc {
        doc = N('http://wiki.github.com/%s/%s' % [@user, @project_name])
        doc.css('.main').first.fmap { |c| clean_links c }
        doc
      }.call
    end
    
    def pages
      @pages ||= root_doc.css(".sidebar ul li b a").map do |link|
        [
          link.content, 
          link['href'][/#{@project_name}\/(.*)/, 1] || "home", 
          proc {
            content = N(link['href']).css('.main').first
            clean_links content
            content
          }
        ]
      end
    end
    
    private 
    
    def clean_links doc
      # rewrites internal links to use the local navigation
      doc.css('a').each do |some_a|
        some_a['href'].fmap { |href| href[/#{@project_name}\/(.*)/, 1].fmap { |id|
            some_a['href'] = "javascript:go(\'#{id}\')"
          }
        }
      end
    end
    
  end
  
  class GitHubEngine
    def do project_spec, file = nil
      user, project_name = *project_spec.split('/')
      
      gh_doc = GitHubDoc.new(user, project_name)
      file ||= file_for(user, project_name)
      
      puts "Building wiki: #{user}/#{project_name} => #{file}"
      
      content = build_content gh_doc
      File.open(file, 'w') { |f| f.puts content }
    end
    
    private
    
    def build_content gh_doc
      build_doc(gh_doc.root_doc, gh_doc.pages, gh_doc.project_name, gh_doc.user)
    end
    
    def file_for user, project_name
      "#{project_name}_#{user}.html"
    end
    
    def template
      IO.read(File.dirname(__FILE__) / 'github.html')
    end
    
    def build_doc root, pages, project_name, user
      # Template variables, note: project_name and user are also used in the template
      project_description = root.css("#repository_description").first.fmap(&:content)
      main_content = root.css('.main').first.fmap(&:inner_html)
      page_list = sidebar(pages)
      i = 0 #todo better way to trace this?
      page_content = pages.map { |title, id, content_f|
        i += 1
        puts "  * [#{i}/#{pages.size}] #{title}"
        "<div id=\"#{id}\">#{content_f[]}</div>"
      }.join

      ERB.new(template()).result(binding)
    end

    def sidebar pages
      "<ul>" + 
      pages.map { |title, id, _| 
        "<li><b><a href=\"javascript:go(\'#{id}\')\""">#{title}</a></b></li>" 
      }.join + 
      "</ul>"
    end
    
  end
  
end
