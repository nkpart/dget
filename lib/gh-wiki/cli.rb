require 'optparse'

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
      project = ARGV[1]
      if !user || !project then
        puts banner
      else 
        path = options[:path]
        
        # do it!
      end

    end
  end
end