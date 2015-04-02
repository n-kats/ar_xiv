module ArXiv

  DATA_CSS_LIST = {
    id:         "id",
    title:      "title",
    authors:    "author>name",
    summary:    "summary",
    updated:    "updated",
    published:  "published",
    categories: "category"
  }

  class XMLParser
    def initialize(xml)
      @entries = Nokogiri::XML(xml).css('entry').map{|x| Entry.new(x)}
    end

    def to_obj
      @entries.map(&:to_hash)
    end

    def self.parse(xml)
      XMLParse.new(xml).to_obj
    end
  end

  # ‚»‚ê‚¼‚ê‚ÌƒGƒ“ƒgƒŠ[‚Ìˆ—
  class Entry
    
    def initialize(noko)
      @xml = noko
    end

    %w{updated published summary}.each do |x|
      define_method x.to_sym do
        @xml.css(x).text
      end
    end

    def id
      case @xml.css("id").text
      when /\/(\d+\.\d+v\d+)\z/
        return $1
      when /\/(\d+v\d+)\z/
        return $1
      end
    end

    def title
      @xml.css("title").text.gsub(/\n/,' ').gsub(/\s+/,' ')
    end

    def authors
      @xml.css('author>name').map(&:text)
    end

    def primary_category
      @xml.css('arxiv:primary_category').first['term']
    end

    def categories
      @xml.css('category').map{|x|x['term']}
    end

    def to_hash
      {
        id: id,
        title: title,
        authors: authors,
        abstract: summary,
        updated: updated,
        published: published,
        categories: categories
      }
    end
  end

end

