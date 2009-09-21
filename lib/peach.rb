# Copyright (c) 2008 Ben Hughes
#  
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation
# files (the "Software"), to deal in the Software without
# restriction, including without limitation the rights to use,
# copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following
# conditions:
#  
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#  
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.


module Peach
  def peach(n = nil, &b)
    return [] if n == 0 or size == 0

    result = Array.new(size)

    n ||= $peach_default_threads || size
    div = (size.to_f/n).ceil

    return [] if div == 0

    threads = []
    max = size - 1
    offset = 0
    for i in (0..n-1)
      threads << Thread.new(offset - div, offset > max ? max : offset) do |lower, upper|
        for j in lower..upper
          yield(slice(j))
        end
      end
      offset += div
    end
    threads.each { |t| t.join }
    self
  end

  def pmap(n = nil, &b)
    return [] if n == 0

    n ||= $peach_default_threads || size
    div = (size.to_f/n).ceil

    return [] if div == 0

    result = Array.new(size)

    threads = []
    max = size - 1
    offset = div
    for i in (0..n-1)
      threads << Thread.new(offset - div, offset > max ? max : offset) do |lower, upper|
        for j in lower..upper
          result[j] = yield(slice(j))
        end
      end
      offset += div
    end
    threads.each { |t| t.join }

    result
  end

  def pselect(n = nil, &b)
    peach_run(:select, b, n)
  end

  protected
  def peach_run(meth, b, n = nil)
    threads, results, result = [],[],[]
    peach_divvy(n).each_with_index do |x,i|
      threads << Thread.new { results[i] = x.send(meth, &b)}
    end
    threads.each {|t| t.join }
    results.each {|x| result += x if x}
    result
  end

  def peach_divvy(n = nil)
    return [] if size == 0

    n ||= $peach_default_threads || size
    n = size if n > size

    lists = []

    div = (size/n).floor
    offset = 0
    for i in (0...n-1)
      lists << slice(offset, div)
      offset += div
    end
    lists << slice(offset...size)
    lists
  end
end

Array.send(:include, Peach)