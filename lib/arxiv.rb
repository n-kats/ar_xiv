# coding : UTF-8

require 'net/http'
require 'uri'
require 'nokogiri'
require 'category.rb'
require 'query.rb'
require 'request.rb'
require 'xml_parser.rb'
require 'version.rb'
module ArXiv
  # xml
  class Document
    def initialize(xml)
      @doc = Nokogiri::XML(xml)
    end
    
    def css(str)
      @doc.css(str)
    end

    def entries
      @doc.css('entry').map{|e|Entry.new(e)}
    end
  end

  # それぞれのエントリーの処理
  class Entry
    attr_accessor :xml
    
    def initialize(xml)
      @xml = xml
    end

    def it
      self
    end

    def self.get_uniq(*ar)
      ar.each do |x|
        define_method x do
          @xml.css(x.to_s).text
        end
      end
    end

    get_uniq :id, :updated, :published, :title, :summary

    alias :old_title :title
    def title
      old_title.gsub(/\n/,' ').gsub(/\s+/,' ')
    end

    def authors
      @xml.css('author>name').map(&:text)
    end

    def link_pdf
      @xml.css('link[title="pdf"]').first['href']
    end

    def primary_category
      @xml.css('arxiv:primary_category').first['term']
    end

    def categories
      @xml.css('category').map{|x|x['term']}
    end

    def to_hash
      {
        title: title,
        authors: authors,
        abstract: summary,
        link_abs: id,
        link_pdf: link_pdf,
        updated: updated,
        published: published,
        categories: categories
      }
    end
  end

  def self.get(hash, sym=:to_hash)
    Request.new(hash).get.entries.map{|x|x.send(sym)}
  end
  
  def values
    %w{title authors abstract link_abs link_pdf updated published categories}
  end
end


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

