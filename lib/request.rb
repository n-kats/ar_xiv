module ArXiv
  class Request

    PARAMS = %w{search_query start max_results id_list sort_by sort_order}

    def initialize(hash={}, query= nil)
      @option = hash
      validate!
      @query = query # String, Query, or ComposedQuery
    end

    def validate!
      # @option["search_query"].is_a?(Query) || @option["search_query"].is_a?(ComposedQuery)
      true # TODO: set validation if needed
    end
    
    def api_url
      url = "http://export.arxiv.org/api/query?"
      @option.each.with_index do |(k,v),i|
        url += "&" if i != 0
        url += "#{k}=#{v}"
      end
      url
    end

    def get
      req = Net::HTTP.get_response(api_url)
      req.body
    end

    PARAMS.each do |par|
      define_method "#{par}=".to_sym do |val|
        @option[par] = val
      end
    end
  end
end
