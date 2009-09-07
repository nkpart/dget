$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
  
module GhWiki
  module_function
  
  def template
    IO.read(File.dirname(__FILE__) / 'googlecode.html')
  end
  
  def main user, project_name
    root = N('http://wiki.github.com/%s/%s' % [user, project_name])
    pages = get_pages(root, project_name)
    
    build_doc(root, pages)
  end
  
  def build_doc root, pages
    #
    root.css('#wikimaincol').first.fmap { |c| clean_links c }
    
    # Template vars
    project_description = root.css("#repository_description").first.content
    main_content = root.css('.main').first.inner_html
    page_list = sidebar(pages)
    page_content = pages.map { |title, id, content_f| 
      "<div id=\"#{id}\">#{content_f[]}</div>"
    }.join
    
    ERB.new(template()).result(binding)
  end
  
  def clean_links page_main_doc
    page_main_doc.css('a').each do |some_a|
      some_a['href'][/#{project_name}\/(.*)/, 1].fmap { |id|
        some_a['href'] = "javascript:go(\'#{id}\')"
      }
    end
  end

  def get_pages root_doc, project_name
    root_doc.css(".sidebar ul li b a").map do |link|
      [
        link.content, 
        link['href'][/#{project_name}\/(.*)/, 1] || "home", 
        proc { 
          content = N(link['href']).css('.main').first
          clean_links content
          content
        }
      ]
    end
  end
end
