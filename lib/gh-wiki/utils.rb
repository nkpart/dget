module GhWiki
  module_function
  
  def N url
    Nokogiri::HTML(open(url))
  rescue SocketError => e
    puts "No connection available: #{url}"
    exit 1
  end
end

class String
  def / other
    File.join(self, other)
  end
end

class Symbol
  # def to_proc
  #   proc { |x| x.send(self) }
  # end
end

class Object
  def fmap &blk
    if (self.respond_to? :map) then
      self.map(&blk)
    else
      yield self if self
    end
  end
  
  def filter &blk
    if (self.respond_to? :select) then
      self.select(&blk)
    else
      if self && (yield self)
        self
      else
        nil
      end
    end
  end
end

