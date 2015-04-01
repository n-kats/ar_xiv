module ArXiv
  class Request

    PARAMS = %w{search_query start max_results id_list sort_by sort_order}

    def initialize(query=nil, hash={})
      @option = hash
      @query = query # String, Query, or ComposedQuery
    end
    
    def api_url
      @option["search_query"] = @query.to_query_string if @query
      url = "http://export.arxiv.org/api/query?"
      @option.each.with_index do |(k,v),i|
        url += "&" if i != 0
        url += "#{k}=#{v}"
      end
      url
    end

    def get
      req = Net::HTTP.get_response(URI.parse(api_url))
      req.body
    end

    PARAMS.each do |par|
      define_method "#{par}=".to_sym do |val|
        @option[par] = val
      end
    end
  end
end
