require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Dget" do
  it "should accept some args" do
    [
      [%w(github dpp/liftweb), ["github", "dpp/liftweb", nil]],
      [%w(github dpp/liftweb test.html), ["github", "dpp/liftweb", 'test.html']],
      [["http://wiki.github.com/jgarber/redcloth"], ["github", "jgarber/redcloth", nil]],
      [["http://wiki.github.com/jgarber/redcloth", "test.html"], ["github", "jgarber/redcloth", "test.html"]]
    ].each do |args, out|
      DGet.parse_args(args).should == out
    end    

  end
end
