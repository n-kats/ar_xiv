require 'net/http'
require 'uri'
require 'nokogiri'
require 'category.rb'
require 'request.rb'
require 'xml_parser.rb'
require 'version.rb'

module ArXiv
  @config = {}
  def self.get(key, value=nil)
    case key
    when Query
      query = key
    when ComposedQuery
      query = key
    else
      query = Query.new(key,value)
    end
    xml = Request.new(query,@config).get
    XMLParser.parse_short(xml)
  end

  def self.config
    @config
  end

  def self.config=(hash)
    @config = hash
  end
end

