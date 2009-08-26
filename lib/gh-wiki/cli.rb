require 'optparse'
require 'gh-wiki'

module GhWiki
  class CLI
    def self.execute(stdout, arguments=[])

      # NOTE: the option -p/--path= is given as an example, and should be replaced in your application.

      options = {
        :path     => '~'
      }
      mandatory_options = %w(  )

      banner = <<-BANNER.gsub(/^        /,'')
        Usage: gh-wiki user project [options]
          eg. gh-wiki dpp liftweb
      BANNER
      parser = OptionParser.new do |opts|
        opts.banner = banner
        opts.separator ""
        opts.on("-p", "--path=PATH", String,
                "The path to dump the wiki to. Default: ./project") { |arg| options[:path] = arg }
        opts.on("-h", "--help",
                "") { stdout.puts opts; exit }
        opts.parse!(arguments)

        if mandatory_options && mandatory_options.find { |option| options[option.to_sym].nil? }
          stdout.puts opts; exit
        end
      end

      user = ARGV[0]
      project_name = ARGV[1]
      if !user || !project_name then
        puts banner
      else 
        path = options[:path]
        
        project = Project.new(user,project_name)
        puts "#{user} / #{project.name}"
        puts "Description:	#{project.description}"
        puts "Pages: #{project.pages.map{ |x| x.inspect }.join(", ")}"
      end

    end
  end
end