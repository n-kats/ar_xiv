require 'spec_helper.rb'
require 'pp'
describe ArXiv::XMLParser do
  xml = File.read(File.expand_path("../sample.xml", __FILE__))
  it "read xml" do
    expect{ArXiv::XMLParser.new(xml).to_obj}.to_not raise_error
  end
end
