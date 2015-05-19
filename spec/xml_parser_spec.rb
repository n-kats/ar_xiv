require 'spec_helper.rb'
require 'pp'
describe ArXiv::XMLParser do
  xml = File.read(File.expand_path("../sample.xml", __FILE__))
  
  it "should success to read xml" do
    data = ArXiv::XMLParser.new(xml)
    expect{data.to_obj}.to_not raise_error
  end
  
  it "should has string keys" do
    expect(ArXiv::XMLParser.parse(xml).first.keys.first).to be_a_kind_of String
    expect(ArXiv::XMLParser.parse_short(xml).first.keys.first).to be_a_kind_of String
  end

end
