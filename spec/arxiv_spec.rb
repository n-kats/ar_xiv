require 'spec_helper.rb'

describe ArXiv do
  it 'has a version number' do
    expect(ArXiv::VERSION).not_to be nil
  end

  it 'loads ArXiv::Query' do
    expect(ArXiv::Query).not_to be nil
  end
  
  # TODO: ()‚ð%28%29‚Ö’¼‚·
  describe ArXiv::Query do
    Query = ArXiv::Query
    it 'make simple query by string' do
      str = "math"
      expect(Query.new(str).to_query_string).to eq "all:(\"math\")"
    end

    it 'make simple query' do
      k = "all"
      v = "math"
      expect(Query.new(k, v).to_query_string).to eq "all:(\"math\")"
    end

    it 'make simple phrase query by string' do
      option = "up to homotopy"
      expect(Query.new(option).to_query_string).to eq "all:(\"up to homotopy\")"
    end

    it 'make simple phrase query' do
      option = {all: "up to homotopy"}
      expect(Query.new(option).to_query_string).to eq "all:(\"up to homotopy\")"
    end
    
    it 'make query with several words' do
      option = {all: %w{math topology}}
      expect(Query.new(option).to_query_string).to eq "all:(\"math\"+AND+\"topology\")"
    end

    it 'is composable' do
      expect(Query.new("math").and(Query.new("physics")).to_query_string).to eq "(all:(\"math\"))+AND+(all:(\"physics\"))"
      expect(Query.new("math").or(Query.new("physics")).to_query_string).to eq "(all:(\"math\"))+OR+(all:(\"physics\"))"
      expect(Query.new("math").andnot(Query.new("physics")).to_query_string).to eq "(all:(\"math\"))+ANDNOT+(all:(\"physics\"))"
    end
  end
end














