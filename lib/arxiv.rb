require 'net/http'
require 'uri'
require 'nokogiri'
require 'category.rb'
require 'query.rb'
require 'request.rb'
require 'xml_parser.rb'
require 'version.rb'


module ArXiv
  def self.view
    hash = {
      search_query: 'cat:math.GT',
      start: 0,
      max_results: 25,
      sort_by: 'lastUpdatedDate',
      sort_order: 'descending' 
    }
    puts Request.new(hash).url
    puts
    l = '-'*80
    get(hash,:it).map{|x|[l,x.title, "  [#{x.link_pdf}]",x.updated,l, x.summary,l,'']}
  end
end

