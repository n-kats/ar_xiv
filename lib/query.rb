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
          raise if key.keys.length != 1
          @key = key.keys.first
          @value = (key[@key].is_a? Array) ? key[@key] : [key[@key]]
        end
      else
        @key = key
        @value = (key.is_a? Array) ? value : [value]
      end
    end

    def to_query_string
      "#{@key}:(\"#{@value.join("\"+AND+\"")}\")"
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
        "(#{@requests.map(&:to_query_string).join(")+#{@op.upcase}+(")})"
      end
    end

  end
end
