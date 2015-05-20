module ArXiv
  module QueryOperator
    def and(query)
      ComposedQuery.new("AND", self, query)
    end

    def or(query)
      ComposedQuery.new("OR", self, query)
    end

    def andnot(query)
      ComposedQuery.new("ANDNOT", self, query)
    end

    # TODO: + や - の実装
  end

  # AND OR ANDOR を意識しないquery
  class Query
    include QueryOperator
    # @queryは
    # {xx: [str,str,str]}
    def initialize(key, value=nil)
      if value==nil
        case key
        when String
          @key = "all"
          @value = [key]
        when Array
          @key = "all"
          @value = key
        when Hash
          raise if key.keys.length != 1 # TODO: 1以外に対応
          @key = key.keys.first
          @value = (key[@key].is_a? Array) ? key[@key] : [key[@key]]
        end
      else
        @key = key
        @value = (key.is_a? Array) ? value : [value]
      end
    end

    def to_query_string
      "#{@key}:%28%22#{@value.join("%22+AND+%22")}%22%29"
    end
  end

  class ComposedQuery
    include QueryOperator
    def initialize(str, *args)
      case str
      when String
        @op = str
        @requests = args
      when Query
        @op = ""
        @request = str
      else
        raise "Fail to make a Composed Request"
      end
    end

    def to_query_string
      if @op.empty?
        @request.to_query_string
      else
        "%28#{@requests.map(&:to_query_string).join("%29+#{@op.upcase}+%28")}%29"
      end
    end

  end

  class Request

    PARAMS = %w{search_query start max_results id_list sort_by sort_order}

    def initialize(query=nil, hash={})
      @option = hash.dup
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
